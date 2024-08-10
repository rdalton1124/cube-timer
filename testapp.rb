require 'shoes'
WIDTH = 120
def main()
	Shoes.app do
		top = Array.new(9, white) 
		front = Array.new(9, green) 
		bottom = Array.new(9, blue) 
		back = Array.new(9, yellow) 
		right = Array.new(9, red) 
		left = Array.new(9, orange) 
		L_turn(left, top, bottom, front, back, 1) 
		R_turn(right, top, bottom, front, back, 1) 
		side333(WIDTH, 0, 2 * WIDTH, WIDTH, top) 
		side333(WIDTH, WIDTH, 2 * WIDTH, 2* WIDTH, front)
		side333(2 * WIDTH, WIDTH, 3 * WIDTH, 2 * WIDTH, right)
		side333(3 * WIDTH, WIDTH, 4 * WIDTH, 2 * WIDTH, back)
		side333(WIDTH, 2 * WIDTH, 2 * WIDTH, 3 * WIDTH, bottom) 
		side333(0, WIDTH, WIDTH, 2 * WIDTH, left)
	end
end
def turn(source, dest, indices) 
	for i in indices 
		dest[i] = source.at(i) 
	end 
end
def L_turn(left, top, bottom, front, back, numTurns) 
	temp = [bottom.at(0), bottom.at(1), bottom.at(2)] 
	turn(front, bottom, [0, 1, 2]) 
	turn(top, front, [0, 1, 2]) 	
	turn(back, top, [0, 1, 2]) 
	back[0] = temp[0] 
	back[1] = temp[1] 
	back[2] = temp[2]
end 
def R_turn(right, top, bottom, front, back, numTurns) 
	temp = [top.at(6), top.at(7), top.at(8)] 
	turn(front, top, [6, 7, 8]) 
	turn(bottom, front, [6, 7, 8]) 
	turn(back, bottom, [6, 7, 8]) 
	back[6] = temp[0] 
	back[7] = temp[1]
	back[8] = temp[2]
end 
def U_turn(up, left, right, front, back, numTurns) 
end 
def D_turn(down, left, right, front, back, numTurns) 
end 
def F_turn(front, up, down, left, right, numTurns) 
end 
def B_turn(back, up, down, left, right, numTurns) 
end 
def rotate_face(face, numRotates) 
end 
def side333(left, top, right, bottom, colors) 
	piece_width = (right - left) / 3
	piece_height = (bottom - top) / 3 
	if (colors[4] == yellow) 
		 
	end 
	for i in 1..3
		for j in 1..3 
			fill colors[(i - 1) * 3 + (j - 1)] 
			rect(
				left: left + piece_width * i, 
				top: top + piece_height * j, 
				width: piece_width
			)
		end 
	end 
end 
main()
