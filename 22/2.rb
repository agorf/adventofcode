class String
  def pluralize(n, plural = self + 's')
    n == 1 ? "1 #{self}" : "#{n} #{plural}"
  end
end

class Spell
  def initialize(player:, boss:)
    @player = player
    @boss   = boss
    @timer  = duration || 0
  end

  def self.duration
    nil
  end

  def cost
    self.class.cost
  end

  def first_cast?
    timer == duration
  end

  def start_effect?
    duration && duration > 0
  end

  def wore_off?
    timer < 0
  end

  private

  attr_reader :armor, :boss, :damage

  def decrement_timer
    @timer -= 1
  end

  def duration
    self.class.duration
  end

  attr_reader :hit, :mana, :player

  attr_reader :timer
end

class MagicMissileSpell < Spell
  def initialize(player:, boss:)
    @damage = 4

    super
  end

  def self.cost
    53
  end

  def cast
    boss.damage!(damage)
    $stderr.puts "Player casts Magic Missile, dealing #{damage} damage."
  end
end

class DrainSpell < Spell
  def initialize(player:, boss:)
    @damage = 2
    @hit    = 2

    super
  end

  def self.cost
    73
  end

  def cast
    boss.damage!(damage)
    player.heal!(hit)
    $stderr.puts "Player casts Drain, dealing #{damage} damage, and healing #{'hit point'.pluralize(hit)}."
  end
end

class ShieldSpell < Spell
  def initialize(player:, boss:)
    @armor = 7

    super
  end

  def self.cost
    113
  end

  def self.duration
    6
  end

  def cast
    if first_cast?
      player.give_armor!(armor)
      $stderr.puts "Player casts Shield, increasing armor by #{armor}."
    else
      $stderr.puts "Shield's timer is now #{timer}."
    end

    decrement_timer

    if wore_off?
      player.take_armor!(armor)
      $stderr.puts "Shield wears off, decreasing armor by #{armor}."
    end
  end
end

class PoisonSpell < Spell
  def initialize(player:, boss:)
    @damage = 3

    super
  end

  def self.cost
    173
  end

  def self.duration
    6
  end

  def cast
    if first_cast?
      $stderr.puts 'Player casts Poison.'
    else
      boss.damage!(damage)
      $stderr.print "Poison deals #{damage} damage"

      if boss.alive?
        $stderr.puts "; its timer is now #{timer}."
      else
        $stderr.puts '. This kills the boss and the player wins.'
      end
    end

    decrement_timer

    if wore_off?
      $stderr.puts 'Poison wears off.'
    end
  end
end

class RechargeSpell < Spell
  def initialize(player:, boss:)
    @mana = 101

    super
  end

  def self.cost
    229
  end

  def self.duration
    5
  end

  def cast
    if first_cast?
      $stderr.puts 'Player casts Recharge.'
    else
      player.give_mana!(mana)
      $stderr.puts "Recharge provides #{mana} mana; its timer is now #{timer}."
    end

    decrement_timer

    if wore_off?
      $stderr.puts 'Recharge wears off.'
    end
  end
end

class Boss
  def initialize(hit:, damage:)
    @hit    = hit
    @damage = damage
  end

  def alive?
    hit > 0
  end

  def attack(player)
    effective_damage = [damage - player.armor, 1].max
    player.damage!(effective_damage)

    if damage == effective_damage
      displayed_damage = damage
    else
      displayed_damage = "#{damage} - #{player.armor} = #{effective_damage}"
    end

    $stderr.print "Boss attacks for #{displayed_damage} damage!"

    if player.dead?
      $stderr.puts ' This kills the player and the boss wins.'
    else
      $stderr.puts
    end
  end

  attr_reader :damage

  def damage!(damage)
    @hit -= damage
  end

  def dead?
    !alive?
  end

  def to_s
    "- Boss has #{'hit point'.pluralize(hit)}"
  end

  private

  attr_reader :hit
end

class Player
  def initialize(hit:, mana:)
    @hit        = hit
    @armor      = 0
    @mana       = mana
    @spent_mana = 0
    @spells     = []
  end

  def alive?
    hit > 0
  end

  def apply_effects!
    spells.each {|spell| cast!(spell) }
  end

  attr_reader :armor

  def already_casted?(spell)
    spells.any? {|s| s.is_a?(spell.class) }
  end

  def cannot_afford?(spell)
    mana < spell.cost
  end

  def cast!(spell)
    charge!(spell) if charge_spell?(spell)
    @spells << spell if add_spell?(spell)

    spell.cast
  end

  def cleanup_spells!
    spells.reject! {|spell| spell.wore_off? }
  end

  def damage!(points)
    @hit -= points
  end

  def dead?
    !alive?
  end

  def give_armor!(armor)
    @armor += armor
  end

  def give_mana!(mana)
    @mana += mana
  end

  def heal!(points)
    @hit += points
  end

  attr_reader :spent_mana

  def take_armor!(armor)
    @armor -= armor
  end

  def to_s
    "- Player has #{'hit point'.pluralize(hit)}, #{armor} armor, #{mana} mana"
  end

  private

  def add_spell?(spell)
    spell.start_effect? && spell.first_cast?
  end

  def charge!(spell)
    @mana -= spell.cost
    @spent_mana += spell.cost
  end

  def charge_spell?(spell)
    !spell.start_effect? || spell.first_cast?
  end

  attr_reader :hit, :mana, :spells
end

class Game
  def initialize(player:, boss:, spell_generator:)
    @player          = player
    @boss            = boss
    @spell_generator = spell_generator
    @spells          = spell_generator.spells
    @player_turn     = true
  end

  def play!
    loop do
      $stderr.puts "-- #{player_turn ? 'Player' : 'Boss'} turn"
      $stderr.puts player
      $stderr.puts boss

      if player_turn
        player.damage!(1)

        if boss_won?
          if unused_spells?
            puts 'Player has unused spells; skipping...'
            spell_generator.skip!
          else
            puts 'Player lost; incrementing...'
            spell_generator.inc!
          end

          break
        end
      end

      player.apply_effects!

      if player_won?
        $min_cost = [$min_cost, player.spent_mana].min
        spell_generator.inc!
        break
      end

      player.cleanup_spells!

      if player_turn
        unless spell_class = spells.first
          puts 'Player has no spell to cast; digging...'
          spell_generator.dig!
          break
        end

        spell = spell_class.new(player: player, boss: boss)

        if player.cannot_afford?(spell)
          puts 'Player cannot afford spell; incrementing...'
          spell_generator.inc!
          break
        end

        if player.already_casted?(spell)
          puts 'Player already casted spell; incrementing...'
          spell_generator.inc!
          break
        end

        player.cast!(spell)

        if player_won?
          $min_cost = [$min_cost, player.spent_mana].min
          spell_generator.inc!
          break
        end

        spells.shift
      else
        boss.attack(player)

        if boss_won?
          if unused_spells?
            puts 'Player has unused spells; skipping...'
            spell_generator.skip!
          else
            puts 'Player lost; incrementing...'
            spell_generator.inc!
          end

          break
        end
      end

      $stderr.puts

      switch_turns!
    end
  end

  private

  attr_reader :boss

  def boss_won?
    boss.alive? && player.dead?
  end

  attr_reader :player, :player_turn

  def player_won?
    player.alive? && boss.dead?
  end

  attr_reader :spell_generator, :spells

  def switch_turns!
    @player_turn = !@player_turn
  end

  def unused_spells?
    spells.any?
  end
end

class SpellGenerator
  SPELLS = [
    MagicMissileSpell,
    DrainSpell,
    ShieldSpell,
    PoisonSpell,
    RechargeSpell
  ]

  def initialize
    @indexes = [0]
  end

  def dig!
    indexes << 0
  end

  def finished?
    indexes.empty?
  end

  def inc!
    loop do
      indexes.pop while indexes[-1] == SPELLS.size - 1

      break if finished?

      indexes[-1] += 1

      break unless total_cost > $min_cost
    end
  end

  def skip!
    indexes.pop
    inc!
  end

  def spells
    p indexes
    indexes.map {|i| SPELLS[i] }
  end

  private

  attr_reader :indexes

  def total_cost
    indexes.reduce(0) {|cost, i| cost + SPELLS[i].cost }
  end
end

BOSS = $stdin.reduce({}) {|stats, line|
  key, val = line.chomp.split(': ')
  stats.merge(key => val.to_i)
}.freeze

spell_generator = SpellGenerator.new
$min_cost = Float::INFINITY

until spell_generator.finished?
  Game.new(
    player: Player.new(hit: 50, mana: 500),
    boss: Boss.new(hit: BOSS['Hit Points'], damage: BOSS['Damage']),
    spell_generator: spell_generator
  ).play!
end

puts $min_cost
