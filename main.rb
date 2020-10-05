require_relative './lib/enumerables.rb'

[1, 2, 3, 4].my_each { |num| puts num}

[1, 2, 3, 4].my_each_with_index { |val, ind| puts "for #{ind} index- value is #{val}"}

puts [1, 2, 3, 4].my_select { |num| num.even? }
