bye_count = 0
loop do
  phrase = gets.chomp
  if phrase.upcase != phrase
     bye_count = 0
     puts "HUH?!  SPEAK UP, SONNY!"
  else 
     if phrase == "BYE"
         if bye_count >= 2 
             break
	 else
           bye_count = bye_count + 1
	   puts "HUH?!  SPEAK UP, SONNY!"
	 end
     else
        bye_count = 0
        puts "NO, NOT SINCE #{ (1930 + rand(20))} "
     end
 end

end

