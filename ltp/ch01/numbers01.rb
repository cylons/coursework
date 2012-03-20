
# Hours in a year

DaysInYear =  365.25
HoursInDay = 24
MinutesInHour = 60
SecondsInMinute = 60
MyAge = 53
puts 'Hours in day '  + (DaysInYear * HoursInDay).to_s

# Minutes in a decade


puts 'Minutes in Decade ' + (10  * DaysInYear * HoursInDay * MinutesInHour).to_s


# My age in seconds  approx.
puts 'My Age in seconds ' + (MyAge * DaysInYear * HoursInDay * MinutesInHour * SecondsInMinute).to_s

# No of chocolates I expect to eat approx

AvChocksPerDay = 3
YearsLeft = 45
puts 'Chocolates to be eaten ' + (YearsLeft * DaysInYear * AvChocksPerDay).to_s

# Persons age in years if they have lived for 1031 million seconds
puts 'Age is ' + (1031_000_000.0 / (DaysInYear * HoursInDay * MinutesInHour * SecondsInMinute)).to_s

