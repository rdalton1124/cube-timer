require 'shoes'
require 'timer.rb' 
require 'display_scramble.rb' 


def main
	timer = Timer.new() 
	Shoes.app do 
		self.add_child(timer.setup())
	end 
end

main()
