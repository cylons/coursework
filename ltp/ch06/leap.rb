def is_leap ( year) 
    if year % 400 == 0
        return true
    end
    if year % 100 == 0
        return false
    end
    if year % 4 == 0
        return true
   end
   return false
end


def is_leap2( year)
   if year % 400 == 0  or (year % 100 != 0 and year % 4 == 0)
             return true
   else
   	    return false
   end
end


puts "Input start year"
start_year = gets.chomp.to_i


puts "Input end year"
end_year = gets.chomp.to_i


for test_year in start_year..end_year
    
   if is_leap(test_year)
   puts " #{test_year} is leap year"
   else 
   puts " #{test_year} is not leap year"
   end

end 
puts "----------"
puts " using is_leap2"
puts " "

for test_year in start_year..end_year
    
   if is_leap2(test_year)
   puts " #{test_year} is leap year"
   else 
   puts " #{test_year} is not leap year"
   end

end 

