weights      = $stdin.map(&:to_i)
group_weight = weights.reduce(:+) / 3 # since all groups have the same weight
min_qe       = Float::INFINITY

(1..Float::INFINITY).each do |i|
  weights.combination(i).each do |combo|
    if combo.reduce(:+) == group_weight
      min_qe = [min_qe, combo.reduce(:*)].min
    end
  end

  break if min_qe < Float::INFINITY
end

puts min_qe
