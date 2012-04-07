num_bottles = 10

verse = <<END
#{ num_bottles.to_s} green bottles,
Hanging on the the wall,
#{ num_bottles.to_s} green bottles,
Hanging on the wall,
And if one green bottle, should accidently fall,
There'll br #{ (num_bottles -1 ).to_s} green bottles,
Hanging on the wall.
END

puts verse

num_bottles = 9

puts verse


