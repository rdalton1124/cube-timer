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
	def scramble_NNN(layers, num_turns) 
		layer_names = Array.new() 
		max_turn = layers / 2 
		for side in CUBE_SIDES
			for num in 1...max_turn
				if num == 1 
					str = side
				elsif num == 2
					str = side + "w"
				else 
					str = num.to_s + side + "w"
				end 
				layer_names.push(str) 
			end 
		end 
		if max_turn > 2
			layer_names.insert((max_turn * 3) - 1, max_turn.to_s + "Fw") 
			layer_names.push(max_turn.to_s + "Rw") 
			layer_names.push(max_turn.to_s + "Uw") 
			if layers % 2 == 1 
				layer_names.push(max_turn.to_s + "Lw")
				layer_names.push(max_turn.to_s + "Dw") 
				layer_names.push(max_turn.to_s + "Bw") 
			end 
		elsif layers >= 4 
			layer_names.push("Rw") 
			layer_names.push("Uw") 
			layer_names.push("Fw")
			if layers % 2 == 1 
				layer_names.push("Lw") 
				layer_names.push("Dw") 
				layer_names.push("Bw") 
			end 
		end 
		
		for nam in layer_names 
			puts nam
		end  
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

def main() 
	scrmbl = Scramble.new() 
	scrmbl.scramble_NNN(6, 70)
end
main() 
