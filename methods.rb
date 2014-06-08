class Product
	attr_reader :name, :price, :category

	def initialize name, price, category
		@name = name
		@price = price
		@category = category
	end

	# def total_for quantity
	# 	price * quantity
	# end

	define_method :total_for do |quantity|
		price * quantity
	end

	# Product.method_defined? :total_for  # => true
	# product = Product.new "Tomato", 0.25, :fruit
	# product.total_for 5  # => 1.25

	undef_method :total_for  # simply unlinks method definition, but it stays there in memory 
	remove_method :total_for  # implementation is completely stripped off

	alias_method :query_for_quantity, :total_for  # allows you to call one method by another name (syntax is :new_method/:alias_method, :old_method/:target_method)

	# product = Product.new "Tomato", 0.25, :fruit
	# product.query_for_quantity 4  # => 1.0
	# product.total_for 4  # => 1.0 

	# Product.method_defined? :total_for  # => false
	# even if I create now instance of product and call method its going to throw an exception

end


# product = Product.new "Tomato", 0.25, :fruit
# product.method :total_for
# method = product.method :total_for
# method.methods 



# ---------------------------------------------------

class Service
	def initialize name, price, man_hour
		@name = name
		@price = price
		@man_hour = man_hour
	end

	def total_for quantity
		price + man_hour * quantity
	end

end

# product = Product.new "Tomato", 0.25, :fruit
# service = Service.new "Shirt ironing", 0.37, 1.00
# product.respond_to? :total_for  # => true
# service.respond_to? :total_for  # => true

# service.respond_to? :price  # => false
# product.respond_to? :price  # => true

# Product.method_defined? :total_for  # => true











