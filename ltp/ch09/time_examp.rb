time = Time.new
time2 = time + 60


puts time

puts time2

born =  Time.mktime(1959, 4, 20, 9, 30)

big_birthday = born + 1000_000_000

puts "Sadly I was a billion seconds old at #{big_birthday}
        , which was over ten years ago."

puts "When were you born?. Please input date in the format DD/MM/YYYY"
inp_date  = gets.chomp.split('/').reverse

born = Time.mktime( *(inp_date))

 
now = Time.new()

age_in_years = now.year - born.year

birthday = Time.mktime(now.year, born.month, born.day)


if  now >= birthday
     age_in_years += 1 
end

puts "Spank! #{age_in_years} times."

