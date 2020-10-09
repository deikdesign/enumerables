require_relative './lib/enumerables.rb'

# puts '1-Test for My_each'
# enum = { a: 1, b: 2, c: 3, d: 4, e: 5 }
# block = proc { |key, val| puts "Key is : #{key} and value is #{val}" }
# print enum.my_each(&block)

# puts '2-Test for my_each_with_index'
# enum = { a: 1, b: 2, c: 3, d: 4, e: 5 }
# block = proc { |val, ind| puts "ind is : #{ind} and value is #{val}" }
# print enum.my_each_with_index(&block)

# puts '3-Test for my_select'
# block = proc { |num| num >= 2 }
# puts [1, 2, 3, 4].my_select(&block)

# puts '4-Test for my_all'
# puts [1, 2, 3, 4].my_all?(Numeric)

# puts '5-Test for my_any'
# puts [false, true].my_any?

# puts '6-Test for my_none'
# puts [1, 2, 3, 5].my_none? { |num| num < 1 }

# puts '7-Test for my_count'
# puts [1, 2, 3, 3, 4].my_count { |x| (x % 2).zero? }

# puts '8-Test for my_map'
# puts %w[h m a y].my_map { |x| x + '1' }

# puts '9-Test for my_inject'
# puts [1, 2, 3, 4, 5].my_inject { |sum, num| sum + num }

# puts '10-Test for multiply_els'
# puts multiply_els([2, 4, 5])

p [1,2,3,4].my_each