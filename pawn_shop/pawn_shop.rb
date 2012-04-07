stock_list = %{ ST01, Apple II, Circa 1977, 80, 0
		ST02, Baseball, Signed by Babe Ruth, 50, 0
		ST03, Oregon Trail Game, Circa 1974, 10, 0
		ST04, Louisville Slugger, Owned by Babe Ruth, 500, 0
		ST05, Superman Comics, Complete set, 100, 0
		ST06, IBM Keyboard, Model M, 15, 0
		ST07, Learn to Program Book, Author Chris Pine, 20, 0
		ST08, iPhone 5, Pre-release, 5000, 0}

#stock_arry = []

#stock_list.lines { |s|  arry = s.lstrip.chomp.split(/,\s*/)
#		h = { 'item' => arry[0], 'desc' => arry[1], 'price' =>  arry[2].to_i }
#		stock_arry.push h
#                }

#p stock_arry


class Stock_item

   attr_reader :stock_code, :desc_1, :desc_2
   attr_accessor  :price, :discount

   def initialize( stock_code, desc_1, desc_2, price, discount)

        @stock_code =  stock_code
	@desc_1 = desc_1
	@desc_2 = desc_2
	@price = price
	@discount = discount
   end

   def to_s
	" #{stock_code}:  #{desc_1}, #{desc_2}, #{price}"
   end  

end

class Shop

   def initialize (stock_list)
      @in_stock = Hash.new
      load_stock (stock_list)
   end

   def load_stock ( stock_arry)
	
     stock_arry.lines { |s|  arry = s.lstrip.chomp.split(/,\s*/)
        @in_stock[arry[0]] = Stock_item.new( arry[0], arry[1], arry[2], 
		arry[3].to_f, arry[4].to_f) }
   end

   def to_s
      puts " Stock No |   Item    | Price  "
      @in_stock.sort.each {| code, item| puts item}
   end
  
   def display
     
      puts " Stock No |   Item    | Price  "
      @in_stock.sort.each {| code, item| puts item}
      puts "-----------------------------------"
   end


   def buy_item (item, cart)
     if ( @in_stock.key?(item) ) 
        cart.add_purchase( @in_stock.delete( item))
 	puts " Item #{ item } added to cart."
     else
        puts " ERROR :-   #{ item} Not in stock "
     end
   end 

end

class Shopping_cart

  def initialize
   @purchases = Hash.new
   @total = 0;
  end

   def add_purchase( item)
      @purchases [ item.stock_code ] = item

   end

   def calc_total
      @total = 0
      @purchases.each {|code, item| @total +=  item.price}
   end  
      
   def display
      calc_total
      puts " Stock No |   Item    | Price  "
      @purchases.sort.each {|code, item| puts item}
      puts "Total is #{ @total}" 
      puts " --------------------   "
   end

end


my_shop = Shop.new(stock_list)

my_cart = Shopping_cart.new


welcome = <<HERE
   

   Welcome to My Shop

   A list of items is displayed. 
   Typing \"b ITEM\" adds the item to the shopping  cart.  e.g. \" b ST01\"
   Typing \"c\" checks you out.
HERE

puts welcome

my_shop.display




while ( 1) 
  

   command = gets
  instruction, param = command.chomp.split
  
  
  case instruction
   when "b"
     my_shop.buy_item( param, my_cart)
     puts " Added #{ param} to cart"
     my_cart.display
     my_shop.display
    when "c"
     puts " Items Purchased" 
     my_cart.display
     puts "Thank you"
     exit
    else 
     puts "Unknown command"
    end
end
    
     
     

