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
    values = data.values

    if values.include?('red')
      0
    else
      values.map {|x| sum(x) }.reduce(:+)
    end
  end
end

input = JSON.parse($stdin.read.chomp)

puts sum(input)
