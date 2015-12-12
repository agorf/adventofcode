require 'json'

def sum(data)
  case data
  when Numeric
    data
  when String
    0
  when Array
    data.map {|x| sum(x) }.reduce(:+)
  when Hash
    data.values.map {|x| sum(x) }.reduce(:+)
  end
end

input = JSON.parse($stdin.read.chop)

puts sum(input)
