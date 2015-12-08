require 'set'

x = [0, 0]
y = [0, 0]
history = Set.new
history << [0, 0]

$stdin.each_char.with_index do |c, i|
  j = i % 2

  case c
  when '^'
    y[j] += 1
  when '>'
    x[j] += 1
  when 'v'
    y[j] -= 1
  when '<'
    x[j] -= 1
  end

  history << [x[j], y[j]]
end

puts history.size
