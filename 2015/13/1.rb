seat_prefs = {}

$stdin.each_line do |line|
  m = line.match(/(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)/)
  name1 = m[1]
  name2 = m[4]
  units = m[3].to_i
  units *= -1 if m[2] == 'lose'

  seat_prefs[name1] ||= {}
  seat_prefs[name1][name2] = units
end

names = seat_prefs.keys

puts names[1..-1].permutation(names.size - 1).map {|arrangement|
  pairs = ([names[0]] + arrangement).each_cons(2).to_a
  pairs << [arrangement.last, names[0]]
  pairs.map {|name1, name2|
    seat_prefs[name1][name2] + seat_prefs[name2][name1]
  }.reduce(:+)
}.max
