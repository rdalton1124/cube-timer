require 'shoes.rb' 
require 'io/console' 

def main() 
	Shoes.app(title: "Timer Test")  do
		@timer_going = false 
		@time_banner = banner "test"
		@time_banner.align = "center"	
		@time_banner.size = 64
		@start_time = 0
		keypress do |key|
			if key == ' '
				if @timer_going 
				@time_banner.text = format_as_time((Time.now - @start_time).round(2))
					 
				else 
					@start_time = start_timer(@time_banner) 
				end 
				@timer_going = !@timer_going
			end
		end 
	end
end 
def format_as_time(num_seconds) 
	if num_seconds > 3600 	
	
	else
		return ((num_seconds / 60).floor).to_s + ":" + (num_seconds % 60).to_s
	end 
end 
def get_input() 
	STDIN.echo = false
	STDIN.raw!
	return STDIN.getc.chr 
end 
def start_timer(banner)
	banner.text = "pressed" 
	return Time.now
end
def end_timer(banner) 
	banner.text = "test"
end 

main() 
