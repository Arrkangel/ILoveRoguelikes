require("gamestate")
require("grid")
require("actor")
mainstate={}

grid.init(50,50)

player=actor.newActor("player",grid.createGlyph("@",255,255,255),3,3,nil)


function mainstate.handleInput(key,isprepeat)

	if key=="kp8" then
		player.pos:push(0,-1)
	end
	if key=="kp2" then
		player.pos:push(0,1)
	end
	if key=="kp4" then
		player.pos:push(-1,0)
	end
	if key=="kp6" then
		player.pos:push(1,0)
	end
	if key=="kp7" then
		player.pos:push(-1,-1)
	end
	 if key=="kp9" then
	 	player.pos:push(1,-1)
	 end
	 if key=="kp3" then
	 	player.pos:push(1,1)
	 end
	 if key=="kp1" then
	 	player.pos:push(-1,1)
	 end


end


function mainstate.update(dt)
	--nifty game stuff goes here
	grid.clear()
end
function mainstate.draw()
	--so much nifty stuff
	grid.setGlyph(player.pos.x,player.pos.y,player.glyph)
	grid.draw()
	--love.graphics.print("I'm a state! Awesome!",0,0)
end
