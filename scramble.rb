class Scramble
	CUBE_SIDES = ['D', 'L', 'B', 'F', 'R', 'U'] 
	CUBE_TURNS = [' ', '\'', '2'] 
	
	MEGAMINX_SIDES = ['R', 'D'] 
	MEGAMINX_TURNS = ["++", "--"]
	
	def initialize 
		@prng = Random.new()
	end 
	
	def print_menu() 
		puts "Choose a scramble to generate" 
		puts "[2] 2x2"
		puts "[3] 3x3"
		puts "[4] 4x4"
		puts "[5] 5x5" 
		puts "[6] 6x6" 
		puts "[7] 7x7"
		puts "[S] Skewb" 
		puts "[Q] Square-1" 
		puts "[P] Pyraminx" 
		puts "[M] Megaminx"    
	end
	def get_input() 
		
	end  
	def scramble_three_by_three() 
		last = 6
		scrmbl = String.new() 
		for i in 1..20 do
			current = @prng.rand(6)
			while current == last || current + last == 5 do
				current = @prng.rand(6)
			end 

			last = current
			scrmbl += (CUBE_SIDES.at(current))
			scrmbl += (CUBE_TURNS.at(@prng.rand(3)))
			scrmbl += " "	
		end
		return scrmbl 
	end
	def scramble_megaminx() 
		for i in 1..7 
			for j in 1..10 
				print MEGAMINX_SIDES.at((j + 1) % 2) 
				print MEGAMINX_TURNS.at(@prng.rand(2))
				print " "
			end 
			print 'U'
			if (@prng.rand(2) == 1)
				puts "\'"
			else 
				puts ""
			end 
		end		
	end 
end
