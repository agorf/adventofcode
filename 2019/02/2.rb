#!/usr/bin/env ruby

PROGRAM = $stdin.read.chomp.split(',').map(&:to_i).freeze

(0..99).each do |noun|
  (0..99).each do |verb|
    memory = PROGRAM.dup

    memory[1] = noun
    memory[2] = verb

    (0..).step(4) do |i|
      case memory[i]
      when 1
        memory[memory[i + 3]] = memory[memory[i + 1]] + memory[memory[i + 2]]
      when 2
        memory[memory[i + 3]] = memory[memory[i + 1]] * memory[memory[i + 2]]
      when 99
        break
      end
    end

    if memory[0] == 19690720
      puts 100 * noun + verb
      exit
    end
  end
end
