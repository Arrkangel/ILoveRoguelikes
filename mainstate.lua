require("gamestate")
require("grid")
require("actor")
require("player")
require("world")
mainstate={}

grid.init(50,50)
world.init(50,50)


function mainstate.handleInput(key,isprepeat)

	if key=="kp8" or key=="k" then
		player:move(0,-1)
	end
	if key=="kp2" or key=="j" then
		player:move(0,1)
	end
	if key=="kp4" or key=="h" then
		player:move(-1,0)
	end
	if key=="kp6" or key=="l" then
		player:move(1,0)
	end
	if key=="kp7" or key=="y" then
		player:move(-1,-1)
	end
	 if key=="kp9" or key=="u" then
	 	player:move(1,-1)
	 end
	 if key=="kp3" or key=="n"  then
	 	player:move(1,1)
	 end
	 if key=="kp1" or key=="b" then
	 	player:move(-1,1)
	 end


end


function mainstate.update(dt)
	--nifty game stuff goes here
	grid.clear()
end
function mainstate.draw()
	--so much nifty stuff
	world.toGrid()

	grid.setGlyph(player.pos.x,player.pos.y,player.glyph)



	grid.draw()


	--love.graphics.print("I'm a state! Awesome!",0,0)
end
