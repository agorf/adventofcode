#!/usr/bin/env ruby

OPS = %w[+ * ||].freeze

def rpn(input)
  stack = []

  while (c = input.shift)
    case c
    when Integer
      stack.push(c)
    when '+'
      a, b = stack.pop(2)
      stack.push(a + b)
    when '*'
      a, b = stack.pop(2)
      stack.push(a * b)
    when '||'
      a, b = stack.pop(2)
      stack.push("#{b}#{a}".to_i)
    else
      raise 'Unexpected character' # Should never happen
    end
  end

  stack.first
end

def op_combos(numbers)
  if numbers.size == 2
    OPS.combination(1)
  else
    (numbers.size - 2).times.reduce(OPS.dup) do |result, _|
      result.product(OPS)
    end
  end
end

def possible_values(numbers)
  op_combos(numbers).map do |nested_ops|
    rpn(numbers.reverse + nested_ops.flatten)
  end
end

def count_value(test_value, numbers)
  if possible_values(numbers).include?(test_value)
    test_value
  else
    0
  end
end

puts(
  $stdin.each_line.reduce(0) do |sum, line|
    test_value, *numbers = line.chomp.scan(/\d+/).map(&:to_i)
    sum + count_value(test_value, numbers)
  end
)
