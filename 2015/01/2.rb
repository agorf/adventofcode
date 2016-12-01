sum = 0

puts $stdin.each_char.with_index(1).find {|c, i| (sum += c == '(' ? 1 : -1) == -1 }.last
