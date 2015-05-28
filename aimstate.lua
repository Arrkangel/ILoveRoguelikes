require("gamestate")
require("fov")
require("point")

require("grid")

aimstate={}
aimstate.target=point.newPoint(0,0)
aimstate.line={}
aimstate.blockPoint={}
aimstate.blocked=true
aimstate.emptyGlyph=grid.createGlyph("X",10,255,10)
aimstate.blockedGlyph=grid.createGlyph("X",255,10,10)

local function rebuildLine()
	aimstate.line=fov.bresenham(player.pos.x,player.pos.y,aimstate.target.x,aimstate.target.y)
	aimstate.blocked,aimstate.blockPoint=fov.losline(aimstate.line)
	table.remove(aimstate.line,1)
end


function aimstate.init()
	aimstate.target=point.newPoint(player.pos.x,player.pos.y)
end



function aimstate.update(dt)



end
function aimstate.handleInput(key,isrepeat)
	if key=="kp8" or key=="k" then
		aimstate.target:push(0,-1)
	end
	if key=="kp2" or key=="j" then
		aimstate.target:push(0,1)
	end
	if key=="kp4" or key=="h" then
		aimstate.target:push(-1,0)
	end
	if key=="kp6" or key=="l" then
		aimstate.target:push(1,0)
	end
	if key=="kp7" or key=="y" then
		aimstate.target:push(-1,-1)
	end
	 if key=="kp9" or key=="u" then
	 	aimstate.target:push(1,-1)
	 end
	 if key=="kp3" or key=="n"  then
	 	aimstate.target:push(1,1)
	 end
	 if key=="kp1" or key=="b" then
	 	aimstate.target:push(-1,1)
	 end
	 if key=="return" then
	 	--complte action
	 	gamestate.popState()
	 end
	 if key=="escape" then
	 	gamestate.popState()
	 end

	 rebuildLine()

end
function aimstate.draw()
	mainstate.draw()
	local pos=player.pos
	local x1=pos.x-25
	local y1=pos.y-25

	if x1<0 then
		x1=0
	end
	if y1<0 then
		y1=0
	end

	for i,v in ipairs(aimstate.line) do
		
		if player.maps.viewmap[v.y*world.width+v.x] then
			grid.setGlyph(v.x-x1,v.y-y1,aimstate.emptyGlyph)
		else
			grid.setGlyph(v.x-x1,v.y-y1,aimstate.blockedGlyph)
		end
		
	end
	if not aimstate.blocked then
		grid.setGlyph(aimstate.blockPoint.x-x1,aimstate.blockPoint.y-y1,aimstate.blockedGlyph)
	end
	



end
