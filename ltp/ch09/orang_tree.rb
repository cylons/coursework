class Orange_tree
  attr_reader :height, :age, :noOfOranges

  def initialize
         @height = 1
	 @age = 0
         @orangeCount = 0
         @alive = true
  end

  
  def oneYearPasses

     @age += 1
     case
     when @age < 3
        @orangeCount = 0
     when (@age >= 3 && @age < 12)
        @orangeCount = 3 * @age
     when @age > 12
	@orangeCount = 0
	@alive = false
     end
     if @alive	
        @height += 0.25
     end
     puts "current height is #{@height}. "
     puts "age is #{@age}"
     puts "number of oranges is #{ @orangeCount}"
     if (not @alive)
       puts "Tree is dead."
    end
    end

   def countTheOranges
        @orangeCount
   end

   def pickAnOrange
       if @orangeCount > 1
          puts "That was nice" 
          @orangeCount -= 1
       else
          puts "There are no  oranges to pick, sorry"
       end
   end   
      
end

 
 myTree = Orange_tree.new


   5.times do
     myTree.oneYearPasses
     4.times do
         myTree.pickAnOrange
         puts "There are #{ myTree.countTheOranges} oranges left."
     end
   end
   
   9.times do
      myTree.oneYearPasses 
   end
 
myTree.pickAnOrange

