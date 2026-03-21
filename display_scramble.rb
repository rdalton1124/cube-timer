require 'shoes'
require 'scramble.rb'


WIDTH = 120
GAP = 5
 
UP = 0
FRONT = 1
DOWN = 2
BACK = 3
RIGHT = 4
LEFT = 5

def menu() 

end 
def main()
	Shoes.app do
		scrambler = Scramble.new() 
		scramble = scrambler.scramble_three_by_three() 
		
		background rosybrown

		u  = Array.new(9, white) 
		f = Array.new(9, green) 
		d = Array.new(9, blue) 
		b = Array.new(9, yellow) 
		r = Array.new(9, red) 
		l = Array.new(9, orange) 	
		cube = [u, f, d, b, r, l] 
		@p = para scramble
		button "new scramble" do 
			reset(cube) 
			scramble = scrambler.scramble_three_by_three() 
			do_scramble(cube, scramble) 
			blit() 
			@p.replace(scramble)
			draw(cube) 	
		end
	
		do_scramble(cube, scramble)
		draw(cube) 
	end
end
def reset(cube, numLayers=3) 
	size = numLayers * numLayers
	cube[UP] = Array.new(size, white) 
	cube[FRONT] = Array.new(size, green) 
	cube[DOWN] = Array.new(size, blue) 
	cube[BACK] = Array.new(size, yellow) 
	cube[RIGHT] = Array.new(size, red) 
	cube[LEFT] = Array.new(size, orange)
end 
def draw(cube, numLayers=3) 
	draw_side(WIDTH + GAP, 0, cube[UP], numLayers) 
	draw_side(WIDTH + GAP, WIDTH + GAP, cube[FRONT], numLayers)	
	draw_side(2 * (WIDTH + GAP), WIDTH + GAP, cube[RIGHT], numLayers)
	draw_side(3 * (WIDTH + GAP), WIDTH + GAP, cube[BACK], numLayers)		
	draw_side(WIDTH + GAP, 2 * (WIDTH + GAP), cube[DOWN], numLayers) 
	draw_side(0, WIDTH, cube[LEFT], numLayers)
end
def blit 
	fill rosybrown 
	stroke rosybrown
	rect( 
		top: 25, 
		left: 0, 
		width:1024
	)
	stroke black
end 
def do_scramble(cube, scramble, numLayers=3, numTurns=20) 
	for i in 0...numTurns
		num = 0
		
		case scramble[(i * 3) + 1] 
			when ' ' 
				num = 1 
			when '2' 
				num = 2
			when '\''	
				num = 3 
		end 	
		case scramble[i * 3]
			when "U" 
				U_turn(cube, num, numLayers)
			when "D"
				D_turn(cube, num, numLayers)
			when "F" 
				F_turn(cube, num, numLayers)
			when "B"
				B_turn(cube, num, numLayers)
			when "L"
				L_turn(cube, num, numLayers) 
			when "R"
				R_turn(cube, num, numLayers)
		end 			
	end
end 
def make_temp(cube, side, indices) 
	temp = Array.new()
	for i in indices 
		temp.push(cube[side][i]) 
	end
	return temp
end
def replace(source, dest, indices) 
	for i in indices 
		dest[i] = source[i]
	end 
end
def turn(cube, indices, faces) 
	temp = make_temp(cube, faces[0], indices)	
	replace(cube.at(faces[1]), cube.at(faces[0]), indices) 
	replace(cube.at(faces[2]), cube.at(faces[1]), indices) 
	replace(cube.at(faces[3]), cube.at(faces[2]), indices)
	for i in 0..2
		cube[faces[3]][indices[i]] = temp[i]
	end
end
def L_turn(cube, numTurns=1, numLayers=3) 
	for i in 1..numTurns
		temp = [cube[UP][0], cube[UP][1], cube[UP][2]]
		for j in 0..2 
			cube[UP][j] = cube[BACK][8 - j] 
			cube[BACK][8 - j] = cube[DOWN][j] 
			cube[DOWN][j] = cube[FRONT][j]
			cube[FRONT][j] = temp[j]
		end  
		rotate_face(cube[LEFT])
	end
end 
def R_turn(cube, numTurns=1, numLayers=3) 
	for i in 1..numTurns
		temp = [cube[UP][6], cube[UP][7], cube[UP][8]]
 
		for j in 6..8 
			cube[UP][j] = cube[FRONT][j]
			cube[FRONT][j] = cube[DOWN][j] 
			cube[DOWN][j] = cube[BACK][8 - j] 
			cube[BACK][8 - j] = temp[j - 6]
		end 
		rotate_face(cube[RIGHT]) 
	end	
end 

def U_turn(cube, numTurns=1, numLayers=3)
	indices = Array.new 
	for l in 0...numLayers 
		indices.push(l * numLayers) 
	end 
	for i in 1..numTurns
		turn(cube, indices, [FRONT, RIGHT, BACK, LEFT])
		rotate_face(cube[UP])
	end
end 
def D_turn(cube, numTurns=1, numLayers=3) 
	indices = Array.new
	for l in 1..numLayers
		indices.push((l * numLayers) - 1)
	end 
	for i in 1..numTurns
		turn(cube, indices, [FRONT, LEFT, BACK, RIGHT])
		rotate_face(cube[DOWN]) 
	end 
end 
def F_turn(cube, numTurns=1, numLayers=3) 
	for i in 1..numTurns
		temp = [cube[UP][2], cube[UP][5], cube[UP][8]]
		for i in 0..2
			cube[UP][2 + (3 * i)] = cube[LEFT][8 - i]
			cube[LEFT][8 - i] = cube[DOWN][(2 - i) * 3]
			cube[DOWN][(2 - i) * 3] = cube[RIGHT][i]
			cube[RIGHT][i] = temp[i]
		end 
		rotate_face(cube[FRONT])
	end 
end 
def B_turn(cube, numTurns=1, numLayers=3) 
	temp = Array.new
	last = (numLayers * numLayers) - 1
	alm = ((numLayers) * (numLayers - 1))
	for t in 1..numTurns
		for l in 0..2
			temp.push((cube[UP][numLayers * l]))
		end 
		for j in 0..2
			cube[UP][numLayers * j] = cube[RIGHT][alm + j]
			cube[RIGHT][alm + j] = cube[DOWN][(last - (numLayers * j))]
			cube[DOWN][(last - (numLayers * j))] = cube[LEFT][((numLayers - 1) - j)]
			cube[LEFT][((numLayers - 1) - j)] = temp[j]
		end 
		rotate_face(cube[BACK])
	end 
end 
def rotate_face(face)  
	temp =  Array.new() 
	for i in 0..8
		temp.append(face[i])
	end
	face[0] = temp[2]
	face[6] = temp[0]
	face[8] = temp[6]
	face[2] = temp[8] 
	
	face[1] = temp[5] 
	face[3] = temp[1] 
	face[7] = temp[3] 
	face[5] = temp[7]
end 
def draw_side(left, top, colors, numLayers=3) 
	piece_width = WIDTH / numLayers
	for i in 1..numLayers
		for j in 1..numLayers 
			'''if(colors[4] == blue) 
				fill colors[(i - 1) * numLayers + (j - 1)]
			else'''
				fill colors[(i - 1) * numLayers + (j - 1)] 
			'''end'''
			rect(
				left: left + piece_width * i, 
				top: top + piece_width * j, 
				width: piece_width
			)
		end 
	end 
end 

main() 
