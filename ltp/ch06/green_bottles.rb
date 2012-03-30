def print_bottles( num )
  puts "#{ num.to_s } Green Bottles:- Hanging on the wall,"
  end


def verse (num)
  print_bottles(num)
  print_bottles(num)
  puts "And if 1 Green Bottle:- Should accidently fall,"
  print "There'll be "
  print_bottles(num - 1)
  puts "\n"
  end


  10.downto(1) do |n|
   verse(n)
  end



