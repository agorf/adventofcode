KEYPAD = [
  [nil, nil,   1, nil, nil],
  [nil,   2,   3,   4, nil],
  [  5,   6,   7,   8,   9],
  [nil, 'A', 'B', 'C', nil],
  [nil, nil, 'D', nil, nil],
].freeze

key = [2, 0] # row, col
code = []

$stdin.each_char do |dir|
  case dir
  when 'U'
    val = [key[0] - 1, 0].max
    key[0] = val if KEYPAD[val][key[1]]
  when 'D'
    val = [key[0] + 1, 4].min
    key[0] = val if KEYPAD[val][key[1]]
  when 'L'
    val = [key[1] - 1, 0].max
    key[1] = val if KEYPAD[key[0]][val]
  when 'R'
    val = [key[1] + 1, 4].min
    key[1] = val if KEYPAD[key[0]][val]
  when "\n"
    code << KEYPAD[key[0]][key[1]]
  end
end

puts code.join
