require 'digest/md5'

secret_key = $stdin.read.chomp

puts (1..Float::INFINITY).find {|i|
  Digest::MD5.hexdigest(secret_key + i.to_s) =~ /\A0{5}/
}
