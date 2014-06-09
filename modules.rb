module HowManyMethods
	def how_many_methods?
		"I have #{self.methods.count} methods."
	end

	def HowManyMethods.extended klass
		puts "Goodbye #{klass}"
	end

	# => Goodbye A

	def HowManyMethods.included klass
		puts "Hello #{klass}"
	end

	# => Hello A

end

class A
	include HowManyMethods # => include goes for any instance not class itself
	extend HowManyMethods # => extend operates on the eigen class
	def b
		:c 
	end
end

a = A.new
aa = A.new.extend HowManyMethods

puts a.how_many_methods? # => wont work
puts aa.how_many_methods? # => will work

# puts A.new.how_many_methods?
# puts A.how_many_methods?

A.new.extend HowManyMethods  # => Goodbye

puts A.ancestors.inspect

# Kernel is a module too, which is why we get methods such as put_as, get_as, warn etc. They are injected into Object so that each time we create one we use those methods to print out information 


