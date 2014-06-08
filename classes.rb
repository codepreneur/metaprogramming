# with a its anonymous generic class, but with A its a proper class (i.e. A = Class.new)

a = class A
	def b
		:c 
	end
	self
end

puts a # => A (if self is replaced by 1 it returns 1)

# you can even replace self with conditional:
# if true
# 	self
# else
# 	4
# end

b = Class.new do
	def b
		:c 
	end
end

puts b 


class Product
	attr_accessor :name, :price
	def initialize name, price
		@name = name
		@price = price
	end

end

# NewProduct = Struct.new(:name,:price)
# new_product = NewProduct.new "Banana", 1.00
# new_product.name
# new_product.price

ProductWithMethod = Struct.new(:name,:price) do
	def total_for(quantity)
		price * quantity
	end
end

# ProductWithMethod.new("Apple", 0.15).total_for 4

product = OpenStruct.new(name:"Tomato",price:0.25)

# product.name = "Apple"
# product.price = 0.15
# product.to_h  # => {:name => "Apple", :price => 0.15}

# difference between OpenStruct and Struct is that you pass a hash of arguments into a constructor.
# Also you can manipulate as if it were a hash

# hence you can do this:
# product.category = :fruit

















