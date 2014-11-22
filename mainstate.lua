require("gamestate")
require("grid")
require("actors")
require("player")
require("world")
require("schedule")
mainstate={}

grid.init(50,50)
world.init(50,50)

local function testBlockTurn(self)
	
	self:move(0,1)
	return true
end
local block=actors.newActor("Block",grid.createGlyph("B",0,255,0),10,1,testBlockTurn)
schedule.addActor(block)


function mainstate.handleInput(key,isprepeat)



	player.lastKey=key
end


function mainstate.update(dt)
	--nifty game stuff goes here
	grid.clear()
	schedule.run()
end
function mainstate.draw()
	--so much nifty stuff
	world.toGrid()

	grid.setGlyph(player.pos.x,player.pos.y,player.glyph)
	block:draw()



	grid.draw()


	--love.graphics.print("I'm a state! Awesome!",0,0)
end
