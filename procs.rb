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
			yield self
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
		yield @builder
		# or block.call
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


post = Post.new do |builder|
	builder.title "Hello!"
	builder.tags "first", "hello"
	builder.body do |body|
		body.paragraph "This is my first post"
		body.horizontal_rule
		body.image "my_image.jpg", "Beautiful kitty"
	end
end

# each block is run in the context of whoever is calling it
# so if you call it in instance of post all of this will be run in the instance of post
# thats why we are calling yield method inside initializer
# and thats why we are running a new post builder instance so we can interact with it rather than just the post

puts post.attributes

puts post.render













