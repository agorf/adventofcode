count = 0

$stdin.each_line do |line|
  if line =~ /([aeiou].*){3,}/ && line =~ /([a-z])\1/ && line !~ /(ab|cd|pq|xy)/
    count += 1
  end
end

puts count
