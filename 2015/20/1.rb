require 'prime'

# Source: http://stackoverflow.com/a/3398195
def factors_of(n)
  return [1] if n == 1

  primes, powers = n.prime_division.transpose
  exponents = powers.map {|i| (0..i).to_a }

  exponents.shift.product(*exponents).map do |powers|
    primes.zip(powers).map {|prime, power| prime ** power }.reduce(:*)
  end
end

def presents_for(house)
  factors_of(house).map {|n| n * 10 }.reduce(:+)
end

input = $stdin.gets.to_i

puts (1..Float::INFINITY).find {|i| presents_for(i) > input }
