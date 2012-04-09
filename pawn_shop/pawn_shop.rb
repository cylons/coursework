stock_list = %{ ST01, Apple II, Circa 1977                   , 80, 0
		ST02, Baseball, Signed by Babe Ruth          , 50, 0
		ST03, Oregon Trail Game, Circa 1974          , 10, 0
		ST04, Louisville Slugger, Owned by Babe Ruth , 500, 0
		ST05, Superman Comics, Complete set          , 100, 0
		ST06, IBM Keyboard, Model M                   , 15, 0
		ST07, Learn to Program Book, Author Chris Pine, 20, 0
		ST08, iPhone 5, Pre-release                   , 5000, 0}


Discount_list = %{ ST01, ST02 :  10
		   ST06, ST07 :  20	 }


 



class Stock_item

   attr_reader :stock_code, :desc_1, :desc_2
   attr_accessor  :price, :discount, :adjusted_price

   def initialize( stock_code, desc_1, desc_2, price, discount)

        @stock_code =  stock_code
	@desc_1 = desc_1
	@desc_2 = desc_2
	@price = Float(price)
	@discount = Float(discount)
        @adjusted_price = Float(price)
     
   end

    def show_available
        
     puts " #{stock_code}:      #{desc_1}, #{desc_2},       #{price}  "
    end
   def to_s
	" #{stock_code}:  #{desc_1}, #{desc_2},          #{price}      #{discount}    #{adjusted_price}"
   end  

end

class Discount_offer
	attr_reader :disc_items, :percentage_discount
      @disc_items = []
      @percentage_discount

#     initialise expects as parameters an array of the stock codes necessary to be present#     to apply the discount and a number which is the discount to be applied


      def initialize( item_list, percent_discount)
           @disc_items = item_list
           @percentage_discount = Float(percent_discount)
      end

end

Struct.new( "Bulk_discount", :number, :discount)
    

class Shop

   
    def initialize (stock_list)

      @in_stock = Hash.new
      @disc_list = []
      @bulk = Struct::Bulk_discount.new(2, 10) 

      load_stock (stock_list)
      load_discount(Discount_list)
      
   end

   def load_stock ( stock_arry)
	
     stock_arry.lines { |s|  arry = s.lstrip.chomp.split(/,\s*/)

        @in_stock[arry[0]] = Stock_item.new( *(arry))
         
		 }
   end

# After calling this subroutine the array @disc_list contains a list of discount objects
# that can be applied.
   def load_discount ( disc_arry)
       disc_arry.lines { |s| line = s.lstrip.chomp
       sep_line = line.partition(":")
       
       @disc_list <<  Discount_offer.new( sep_line[0].strip.split(/,\s*/), 
                                                               sep_line[2].strip) 
      }
   end    

   def export_discount
       return @disc_list, @bulk
   end      

   def to_s
      puts " Stock No         |   Item               | Price  "
      @in_stock.sort.each {| code, item| puts item}
   end
  
   def display
     
      puts " Stock No |   Item                           | Price  "
      @in_stock.sort.each {| code, item|  item.show_available}
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
   @cart_disc_list = []
   @cart_bulk_disc =  Struct::Bulk_discount.new(0,0)
   @discount = 0
    
  end

 # This gets the discount list from the shop
   def import_discount( shop)
      
    @cart_disc_list, tmp_bulk_disc = shop.export_discount
    @cart_bulk_disc.number =  tmp_bulk_disc.number

    @cart_bulk_disc.discount =  tmp_bulk_disc.discount
   end 


   def add_purchase( item)
      @purchases [ item.stock_code ] = item

   end

    def show_disc
       p @cart_disc_list
       p @cart_bulk_disc
    end

   def calc_total
      @total = 0
      @purchases.each {|code, item| @total +=  item.adjusted_price}
      if @purchases.length > @cart_bulk_disc.number
             @total -= @total*@cart_bulk_disc.discount/100
             puts " #{ @cart_bulk_disc.discount} per cent discount applied"
             puts " as you bought more than #{ @cart_bulk_disc.number} items. "
      end 
   end  

# This code makes me a bit queasy but it works.


    def apply_discount

      #Check if discount is applicable. Purchases is a hash with the stock item as
      # a key. disc_items is the list of items that have to be bought together
      # if the discount is to be applicable. For each of these the code checks to
      # see if the item is in the carts purcheses hash. If after this process
      # apply is still true then the relevant discount has to applied to each of the 
      # purchases in the current discount list.   
      apply = true
     
      @cart_disc_list.each { |d|  d.disc_items.each {|v| 
          
	  apply = (apply && @purchases.has_key?(v)) 
          }
          
          if (apply == true)
           # apply discount

	    d.disc_items.each { |w|  
            @purchases[w].discount = d.percentage_discount
            @purchases[w].adjusted_price -=  
                      (@purchases[w].price * @purchases[w].discount / 100 )  
         			 }
	  end
          apply = true
          }
    end
      
   def display
      calc_total
      puts " Stock No      |   Item                         | List Price | Discount | Adjusted Price  "
      @purchases.sort.each {|code, item| puts item}
      puts "                                                            Total is #{ @total}" 
      puts " --------------------   "
   end

end


my_shop = Shop.new(stock_list)

my_cart = Shopping_cart.new
my_cart.import_discount(my_shop)


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
     my_cart.apply_discount 
     my_cart.display
     puts "Thank you"
     exit
    when "d"
     my_cart.apply_discount
     my_cart.display
    else 
     puts "Unknown command"
    end
end
    
     
     

