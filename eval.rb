require "ostruct"

class PostBuilder

	def initialize
		@body = []
	end

	def title string
		@title = string
	end

	def tags *tags
		@tags = tags
	end

	def body &block
		if block_given?
			@body << "----------------------------"
			self.instance_eval "puts '*************'"
			self.instance_eval &block
			@body << "----------------------------"
		else
			warn "you havent provided a block"
		end

	end

	# or def body
	#      yield
	#    end

	# or def body &block
	#      block.call
	#    end

	def paragraph string
		@body << string + "\n"
	end

	def horizontal_rule
		@body << "* * *"
	end

	def image url, description = ""
		@body << "![#{url}](#{description})"
	end

	def attributes
		OpenStruct.new(title: @title, body: @body.join("\n"), tags: @tags )
		# obj.title or obj.body or obj.tags 
	end

end



class Post
	def initialize &block
		@builder = PostBuilder.new
		@builder.instance_eval &block
	end

	def attributes
		@builder.attributes
	end

	def render
		[
		attributes.title,
		attributes.tags.join(", "),
		attributes.body 
		].join("\n")
	end

end


# post = Post.new do |builder|
# 	builder.title "Hello!"
# 	builder.tags "first", "hello"
# 	builder.body do |body|
# 		body.paragraph "This is my first post"
# 		body.horizontal_rule
# 		body.image "my_image.jpg", "Beautiful kitty"
# 	end
# end

post = Post.new do
	title "Hello!"
	tags "first", "hello"
	body do
		paragraph "This is my first post"
		horizontal_rule
		image "my_image.jpg", "Beautiful kitty"
	end
end

# each block is run in the context of whoever is calling it
# so if you call it in instance of post all of this will be run in the instance of post
# thats why we are calling yield method inside initializer
# and thats why we are running a new post builder instance so we can interact with it rather than just the post

puts post.attributes

puts post.render

# ----------------------------------------------------------

class ClassCreator
	def initialize
		@klass = Class.new
		@attributes = []	
		end

		def attribute name
			@attributes << name
		end

		def initialize_attributes
			@attributes.map do |attribute|
				%(@#{attribute} = #{attribute})
			end.join "\n"
		end

		def attributes_as_arguments
			@attributes.join ", "
		end

		def create

			@klass.class_eval <<EOF
			def initialize #{attributes_as_arguments}
				#{initialize_attributes}
			end

			def self.get_binding
				binding 
			end

			EOF

			@attributes.each do |attribute|
				eval %(attr_reader :#{attribute}), @klass.get_binding
				# needs to pass in public method to get access to private variable 
			end

			@klass
		end

		def self.create *args, &block
			@creator = new

			@creator.instance_eval &block
			# or @creator.instance_exec @creator, &block # => but then we need to bring back the builder down below
			# instance_exec takes argument here (@creator) and passes it to the block being executed
			@creator.create
		end

end



Post = ClassCreator.create do
	attribute :title
	attribute :tags
	attribute :body
end

puts Post.new(
	"Hi, Title!",
	%w{first hello class_eval},
	"We did it!"
	).inspect












