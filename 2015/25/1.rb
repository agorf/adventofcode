row, col = $stdin.gets.scan(/\d+/).map(&:to_i)
prev_val = 20151125

(1..Float::INFINITY).each do |i|
  i.downto(0) do |j|
    val = (prev_val * 252533) % 33554393

    if j == row - 1 && i - j == col - 1
      puts val
      exit
    end

    prev_val = val
  end
end
