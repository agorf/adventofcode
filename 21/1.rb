WEAPONS = {
  'Dagger'     => { 'Cost' =>  8, 'Damage' => 4, 'Armor' => 0 },
  'Shortsword' => { 'Cost' => 10, 'Damage' => 5, 'Armor' => 0 },
  'Warhammer'  => { 'Cost' => 25, 'Damage' => 6, 'Armor' => 0 },
  'Longsword'  => { 'Cost' => 40, 'Damage' => 7, 'Armor' => 0 },
  'Greataxe'   => { 'Cost' => 74, 'Damage' => 8, 'Armor' => 0 },
}

ARMOR = {
  'Leather'    => { 'Cost' =>  13, 'Damage' => 0, 'Armor' => 1 },
  'Chainmail'  => { 'Cost' =>  31, 'Damage' => 0, 'Armor' => 2 },
  'Splintmail' => { 'Cost' =>  53, 'Damage' => 0, 'Armor' => 3 },
  'Bandedmail' => { 'Cost' =>  75, 'Damage' => 0, 'Armor' => 4 },
  'Platemail'  => { 'Cost' => 102, 'Damage' => 0, 'Armor' => 5 },
}

RINGS = {
  'Damage +1'  => { 'Cost' =>  25, 'Damage' => 1, 'Armor' => 0 },
  'Damage +2'  => { 'Cost' =>  50, 'Damage' => 2, 'Armor' => 0 },
  'Damage +3'  => { 'Cost' => 100, 'Damage' => 3, 'Armor' => 0 },
  'Defense +1' => { 'Cost' =>  20, 'Damage' => 0, 'Armor' => 1 },
  'Defense +2' => { 'Cost' =>  40, 'Damage' => 0, 'Armor' => 2 },
  'Defense +3' => { 'Cost' =>  80, 'Damage' => 0, 'Armor' => 3 },
}

BOSS = $stdin.reduce({}) {|stats, line|
  key, val = line.chop.split(': ')
  stats.merge(key => val.to_i)
}.freeze

def play(weapon, armor, rings)
  boss   = BOSS.dup
  player = { 'Hit Points' => 100, 'Damage' => weapon['Damage'], 'Armor' => 0 }
  cost   = weapon['Cost']

  if armor
    player['Armor'] += armor['Armor']
    cost += armor['Cost']
  end

  if rings.any?
    player['Damage'] += rings.map {|r| r['Damage'] }.reduce(:+)
    player['Armor'] += rings.map {|r| r['Armor'] }.reduce(:+)
    cost += rings.map {|r| r['Cost'] }.reduce(:+)
  end

  player_damage = player['Damage'] - boss['Armor']
  boss_damage = boss['Damage'] - player['Armor']

  while boss['Hit Points'] > 0 && player['Hit Points'] > 0
    boss['Hit Points'] -= player_damage
    player['Hit Points'] -= boss_damage
  end

  if boss['Hit Points'] <= 0 && player['Hit Points'] > 0
    cost
  else
    Float::INFINITY
  end
end

possible_weapons = WEAPONS.keys
possible_armor   = [nil] + ARMOR.keys
possible_rings   = [[]] + RINGS.keys.combination(1).to_a + RINGS.keys.combination(2).to_a
min_cost         = Float::INFINITY

possible_weapons.each do |weapon_name|
  possible_armor.each do |armor_name|
    possible_rings.each do |ring_names|
      weapon   = WEAPONS[weapon_name]
      armor    = ARMOR[armor_name]
      rings    = RINGS.values_at(*ring_names)
      cost     = play(weapon, armor, rings)
      min_cost = [min_cost, cost].min
    end
  end
end

puts min_cost
