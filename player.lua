--require("actors")
require("grid")
require("schedule")
require("stats")
require("point")
require("inventory")
require("gamestate")
require("fov")
require("aimstate")
player={}

function player.init()
	player.glyph=grid.createGlyph("@",255,255,255)
	local px,py=world.randomTile(tile.floor)
	player.pos=point.newPoint(px,py)
	player.sheet=stats.newSheet(10,10,100,10,10,10)


	player.lastKey=nil
	schedule.addActor(player)

	player.maps=fov.newMaps()
	player.viewRange=15

end

function player.runTurn(self)
	if player.sheet.hp<=0 then
		print("Player killed")
		gamestate.popState()
		return
	end

	if not player.lastKey then
		return false
	end
	local key=player.lastKey
	if key=="kp8" or key=="k" or key=="up" then
		player.move(0,-1)
	end
	if key=="kp2" or key=="j" or key=="down" then
		player.move(0,1)
	end
	if key=="kp4" or key=="h" or key=="left" then
		player.move(-1,0)
	end
	if key=="kp6" or key=="l" or key=="right" then
		player.move(1,0)
	end
	if key=="kp7" or key=="y" then
		player.move(-1,-1)
	end
	 if key=="kp9" or key=="u" then
	 	player.move(1,-1)
	 end
	 if key=="kp3" or key=="n"  then
	 	player.move(1,1)
	 end
	 if key=="kp1" or key=="b" then
	 	player.move(-1,1)
	 end
	 if key=="f" then
	 	aimstate.init()
	 	gamestate.pushState(aimstate)
	 	player.lastKey=nil
	 	return false
	 end

	 player.lastKey=nil
	 local startTime=love.timer.getTime()
	 fov.run(player.maps,player.pos.x,player.pos.y,player.viewRange)
	 local stopTime=love.timer.getTime()
	 --print(stopTime-startTime)

	 return true
end
function player.move(x,y)
	local testP=point.newPoint(x,y)
	testP:push(player.pos.x,player.pos.y)
	
	if world.isPassable(testP.x,testP.y) then
	
		if #actors.actorAt(testP.x,testP.y)==0 then
			player.pos:push(x,y)
		else
			player.meleeAttack(actors.actorAt(testP.x,testP.y)[1])
		end
	end
end

function player.draw(x1,y1,x2,y2)
	grid.setGlyph(player.pos.x-x1,player.pos.y-y1,player.glyph)
end

function player.updateStats()

end

function player.meleeAttack(target)
	target.sheet.hp=target.sheet.hp-inventory.slots["weapon"].atk
	print(target.name .. " hit! "..target.sheet.hp)
	

end
