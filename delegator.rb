# require 'delegate'
require 'forwardable'

class Car
	attr_reader :price

	def initialize price
		@price = price
	end

end

class VATCalculator
	extend Forwardable

	def_delegators :@car, :price

	def initialize car
		@car = car
	end

	def new_price
		price * 1.23
	end

end

# calculator = VATCalculator.new Car.new 1500
# calculator.price
# calculator.new_price

# ---------------------------------------------------------

# class VATCalculator < SimpleDelegator 

# 	def new_price
# 		price * 1.23
# 	end

# end

# car_with_taxes = VATCalculator.new Car.new 1500
# car_with_taxes.class => VATCalculator
# car_with_taxes.new_price => 1845.0

