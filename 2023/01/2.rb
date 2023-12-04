#!/usr/bin/env ruby

NUMBERS =
  %w[one two three four five six seven eight nine].
    each_with_index.each_with_object({}) do |(word, index), result|
      result[word] = (index + 1).to_s
    end.freeze

REPL = {
  'oneight' => '18',
  'twone' => '21',
  'threeight' => '38',
  'fiveight' => '58',
  'eightwo' => '82',
  'eighthree' => '83',
  'nineight' => '98'
}.freeze
REPL_RE = Regexp.union(REPL.keys)

SCAN_RE = Regexp.union(/\d/, *NUMBERS.keys)

total =
  $stdin.each_line.reduce(0) do |sum, line|
    digits = line.gsub(REPL_RE, REPL).scan(SCAN_RE)
    number = [
      NUMBERS.fetch(digits[0], digits[0]),
      NUMBERS.fetch(digits[-1], digits[-1])
    ].join.to_i
    sum + number
  end

puts total
