puts $stdin.count {|line|
  line =~ /([aeiou].*){3,}/ && line =~ /([a-z])\1/ && line !~ /(ab|cd|pq|xy)/
}
