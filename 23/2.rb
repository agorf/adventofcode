LINE_REGEX = %r{
  (?<instruction>hlf|tpl|inc|jmp|ji[eo])
  \s
  (?:(?<register>[ab])|(?<offset1>[+-]\d+))
  (?:,\s(?<offset2>[+-]\d+))?
}x

program = $stdin.each_line.map(&:chomp)
registers = { 'a' => 1, 'b' => 0 }
i = 0

while i < program.size do
  line  = program[i]
  data  = line.match(LINE_REGEX)
  ioff = 1

  case data[:instruction]
  when 'hlf'
    registers[data[:register]] /= 2
  when 'tpl'
    registers[data[:register]] *= 3
  when 'inc'
    registers[data[:register]] += 1
  when 'jmp'
    ioff = data[:offset1].to_i
  when 'jie'
    if registers[data[:register]].even?
      ioff = data[:offset2].to_i
    end
  when 'jio'
    if registers[data[:register]] == 1
      ioff = data[:offset2].to_i
    end
  end

  i += ioff
end

puts registers['b']
