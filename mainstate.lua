require("gamestate")
require("grid")
require("actors")
require("player")
require("world")
require("schedule")
require("simpleitem")
require("inventory")
require("fov")
require("aimstate")
require("pathfind")

mainstate={}


function mainstate.init()
	grid.init(51,51)
	--world.initFile("testlevel.txt")
	--world.init(50,50)
	world.initGen(100,100)
	world.saveWorldAs("testlevel3.txt")
	player.init()
	fov.init()
	aimstate.init()
	--[[local sx,sy=world.randomTile(tile.floor)
	pathtest=pathfind.to(sx,sy,player.pos.x,player.pos.y)
	pathtestGlyph=grid.createGlyph("P",10,255,10)
	]]--

end

local function testBlockTurn(self)
	if actors.stateCheck(self) then
		return true
	end

	self:move(-1,0,true)
	return true
end
--local block=actors.newActor("Block",grid.createGlyph("B",1,255,1),10,1,testBlockTurn,stats.newSheet(10,10,10,10,10,10))
--schedule.addActor(block)

local sword=item.newItem("weapon",0,2)
inventory.equip(sword)


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
	local pos=player.pos
	local x1=pos.x-25
	local y1=pos.y-25

	if x1<0 then
		x1=0
	end
	if y1<0 then
		y1=0
	end
		
	local x2=x1+51
	local y2=y1+51

	if x2>world.width then
		x2=world.width
	end
	if y2>world.height then
		y2=world.height
	end


	world.toGrid(x1,y1,x2,y2)

	--grid.setGlyph(player.pos.x,player.pos.y,player.glyph)
	--block:draw()
	actors.draw(x1,y1,x2,y2)
	

	--pathfinding test
	--[[for i,v in ipairs(pathtest) do
		grid.setGlyph(v.x-x1,v.y-y1,pathtestGlyph)
	end
	]]--

	player.draw(x1,y1,x2,y2)
	
	--grid.drawFrom(player.pos.x-25,player.pos.y-25)


	--love.graphics.print("I'm a state! Awesome!",0,0)
end
