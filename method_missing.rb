class B
	def name
		"Jose"
	end

	def method_missing method, *args, &block
		if method.to_s.include? "name"
			name
		else
			super method, *args, &block
		end
	end

end

puts B.new.name_method
puts B.new.whats_my_name
puts B.new.age
