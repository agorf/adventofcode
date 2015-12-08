sum = 0

$stdin.each_char.with_index(1) do |c, i|
  sum += c == '(' ? 1 : -1

  if sum == -1
    puts i
    break
  end
end
