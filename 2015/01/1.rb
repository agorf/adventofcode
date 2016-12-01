puts $stdin.each_char.reduce(0) {|sum, c| sum + (c == '(' ? 1 : -1) }
