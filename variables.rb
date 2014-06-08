class A
	MyConst = 3
	@@a = "My Class Variable"
	@b = "My Class Instance Variable"
	@@v = 1
	def initialize b,c
		@b = b
		@c = c
	end

	def get_my_constant
		MyConst
		# or self.class.const_get :MyConst so a.get_my_constant will work now
	end

	# A.const_get :MyConst  # => 3
	# a.const_get :MyConst  # => doesnt work (only works with classes)

	def set_my_constant value
		self.class.const_set :MyConst, value
	end

	def set name, value
		instance_variable_set "@{name.to_s}".to_sym, value

		puts all_variables
	end

	# :@b
	# a = A.new 3, :four
	# a.set :b, "three"

	def all_variables
		self.class.instance_variable_get @@v

		i_variables = instance_variables.map do |variable|
			"#{variable} is #{instance_variable_get(variable )}"
		end.join("\n")

		# class variables are only available in the class and NOT in the instance of a class

		c_variables = self.class.class_variables.map do |variable|
			"#{variable} is #{self.class.class_variable_get(variable )}"
		end.join("\n")

		# class instance variables are with one @ that are outside of initialize 

		ci_variables = self.class.instance_variables.map do |variable|
			"#{variable} is #{self.class.instance_variable_get(variable )}"
		end.join("\n")

		[i_variables, c_variables, ci_variables ].join "\n\n" 

		# puts a.all_variables
	end

	# a.all_variables
	# puts a.all_variables
	# a.set :virus, "Got you!"
	# line above violates encapsulation of class

end 

# A.new 3, :four
# A.b wont work cause we dont have a setter, but...
# a = A.new 3, :four

# This will work:
# a.instance_variable_set :@b, :three 
# and now b is :three

# also this is getter without getter:
# a.instance_variable_get :@b

# -------------------------------------


class B
	@v = 1
end

class C < B
end

# C.class_variable_get :@v wont work
# C.class_variable_get :@@v wont work either
# C.instance_variable_get :@v  # => nil


class B
	@@v = 2
end

# C.class_variable_get :@@v  # => 2

# i.e. class variables are available in between class hierarchies
# whereas class instance variables are not













