pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function aabb(a,b)
	if a.x<b.x+b.w and 
		 a.x+a.w>b.x and
		 a.y<b.y+b.h and
		 a.y+a.h>b.y then
		return true
	end
	return false
end

function update_object(o)
	o.collision=false
end

function draw_object(o)
	rect(o.x,o.y,o.x+o.w,o.y+o.h,o.c)
	if o.collision then
		rectfill(o.x,o.y,o.x+o.w,o.y+o.h,o.c)
	end
end

function draw_player(p)
	draw_object(p)
end

function dummy() end

function update_player_collisions(p)
	p.collision=false
	for _,o in pairs(objects) do
		if p!=o then
			if aabb(p,o) then
				p.collision=true
				o.collision=true
			end
		end
	end
end

function update_player(self)
	self.collision=false
	
	if btn(➡️) then
		self.dx=1
	elseif btn(⬅️) then
		self.dx=-1
	else
		self.dx=0
	end
	
	if btn(⬆️) then
		self.dy=-1
	elseif btn(⬇️) then
		self.dy=1
	else
		self.dy=0
	end
	
	self.x+=self.dx
	self.y+=self.dy
	
	self:collides()
end

function make_object(x,y,w,h,c)
	return {
		x=x,
		y=y,
		w=w,
		h=h,
		c=c,
		dx=0,
		dy=0,
		update=update_object,
		collides=dummy,
		draw=draw_object,
		collision=false,
	}
end

function make_player(x,y)
	local p=make_object(x,y,10,10,8)
	p.update=update_player
	p.collides=update_player_collisions
	p.draw=draw_player
	return p
end

function _init()
	objects = {}
	
	add(objects,make_object(2,2,30,30,10))
	add(objects,make_object(95,2,30,30,11))
	add(objects,make_object(95,95,30,30,14))
	add(objects,make_object(2,95,30,30,9))
	add(objects,make_player(60,78))
end

function _update60()
	for _,o in pairs(objects) do
		o:update()
	end
end

function _draw()
	cls()
	rectfill(0,0,127,127,1)
	color(7)
	print("move the player",35,52)
	print("⬅️⬆️➡️⬇️",48,60)
	color()
	for _,o in pairs(objects) do
		o:draw()
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
