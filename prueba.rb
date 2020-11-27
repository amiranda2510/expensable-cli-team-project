require "io/console"

password = $stdin.noecho(&:gets).chomp
p password
