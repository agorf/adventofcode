puts $stdin.each_char.inject(0) {|sum, c|
  sum + (c == '(' ? 1 : -1)
}
