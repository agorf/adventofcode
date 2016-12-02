KEYPAD = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
].freeze

key = [1, 1] # row, col
code = []

$stdin.each_char do |dir|
  case dir
  when 'U'
    key[0] = [key[0] - 1, 0].max
  when 'D'
    key[0] = [key[0] + 1, 2].min
  when 'L'
    key[1] = [key[1] - 1, 0].max
  when 'R'
    key[1] = [key[1] + 1, 2].min
  when "\n"
    code << KEYPAD[key[0]][key[1]]
  end
end

puts code.join
