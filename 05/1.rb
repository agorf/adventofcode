count = $stdin.each_line.reduce(0) do |count, line|
  if line =~ /([aeiou].*){3,}/ && line =~ /([a-z])\1/ && line !~ /(ab|cd|pq|xy)/
    count + 1
  else
    count
  end
end

puts count
