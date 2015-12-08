require 'set'

x = y = 0
history = Set.new
history << [x, y]

$stdin.each_char do |c|
  case c
  when '^'
    y += 1
  when '>'
    x += 1
  when 'v'
    y -= 1
  when '<'
    x -= 1
  end

  history << [x, y]
end

puts history.size
