puts $stdin.count {|line|
  line =~ /([a-z]{2}).*\1/ && line =~ /([a-z])[a-z]\1/
}
