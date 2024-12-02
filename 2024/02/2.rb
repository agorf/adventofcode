#!/usr/bin/env ruby

def safe_report?(report)
  increasing = nil

  report.each_cons(2) do |a, b|
    return false unless (1..3).cover?((a - b).abs)
    return false unless increasing.nil? || increasing == (a > b)

    increasing ||= a > b
  end

  true
end

def safe_report_with_dampener?(report)
  report.each_index.map do |i|
    variant = report.dup.tap { |v| v.delete_at(i) }

    return true if safe_report?(variant)
  end

  false
end

result =
  $stdin.each_line.reduce(0) do |count, line|
    report = line.chomp.split(' ').map(&:to_i)
    count + (safe_report_with_dampener?(report) ? 1 : 0)
  end

puts result
