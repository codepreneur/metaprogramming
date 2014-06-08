class B
	def name
		"Jose"
	end

	def method_missing method, *args, &block
		super method, *args, &block
	end

end

puts B.new.age