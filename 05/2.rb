count = $stdin.reduce(0) do |count, line|
  if line =~ /([a-z]{2}).*\1/ && line =~ /([a-z])[a-z]\1/
    count + 1
  else
    count
  end
end

puts count
