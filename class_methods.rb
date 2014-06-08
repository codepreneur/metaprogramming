class A
	def self.b  # self is eigen class of A
		:c 
	end

	def self.d
		:e
	end

	class << self
		def g
			:h
		end
	end

end

# this allows you to use b like this: A.b
# another way of doing this is class << self; def b; :c; end; end 
# in java these are referred as static methods

# a => a'

a = A.new
#defining method onto a singleton class of a, the eigen class
def a.my_own_method 

end

# Also since A is an object of its own, which is an instance of class it gets its own eigen class
# like this: A => A'

# when you type self you are actually registering a method onto an eigen class

# every single instance gets its own eigenclass. 
# its a hidden class noone notices 
