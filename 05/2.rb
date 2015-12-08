count = 0

$stdin.each_line do |line|
  if line =~ /([a-z]{2}).*\1/ && line =~ /([a-z])[a-z]\1/
    count += 1
  end
end

puts count
