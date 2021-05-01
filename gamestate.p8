game_screen = {}
start_screen = {}

function print_center(s,c,y)
	x = (128-#s*4)/2
	y = y or 64
	print(s,x,y,c)
end

start_screen.update = function()
	if btn(❎) then
		current_screen = game_screen
	end
end

start_screen.draw = function()
	rectfill(0,0,127,127,8)
	print_center("press ❎ to start",7)
end

game_screen.update = function()
	if btn(🅾️) then
		current_screen = start_screen
	end
end

game_screen.draw = function()
	rectfill(0,0,127,127,10)
	print_center("you are in the game screen!",8)
	print_center("press 🅾️ to return",8,72)
end

function _init()
	current_screen = start_screen
end

function _draw()
	current_screen.draw()
end

function _update()
	current_screen.update()
end
