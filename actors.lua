require("point")
require("world")
require("grid")
require("action")
actors={}

function actors.actorAt(x,y)
	local ret={}
	for i,v in ipairs(actors) do
		if v.pos.x==x and v.pos.y==y then
			if not v.active then
				goto continue
			end
			ret[#ret+1]=v
		end
		::continue::
	end
	return ret
end
function actors.checkDead(actor)
	return actor.sheet.hp<=0
end

function actors.deactivate(actor)
	actor.active=false
	schedule.flagDestroy(actor)
end

function actors.stateCheck(actor)
	--check that nothing should remove this actor from the game
	local rem=false;
	rem=actors.checkDead(actor)
	if rem then
		print(actor.name .. " died!")
		actors.deactivate(actor)
	end
	return rem
end





function actors.newActor(name,glyph,x,y,runTurn,sheet)
	local act={}
	act.name=name
	act.glyph=glyph
	act.pos=point.newPoint(x,y)
	act.runTurn=runTurn
	act.sheet=sheet

	act.active=true

	act.move=action.move

	act.draw=function(self)
		grid.setGlyph(self.pos.x,self.pos.y,self.glyph)
	end

	act.attack=action.attack

	actors[#actors+1]=act
	act.id=#actors


	act.equip={}


	return act
end

function actors.draw(x1,y1,x2,y2)
	for x=x1,x2-1 do
		for y=y1,y2-1 do
			if player.maps.viewmap[y*world.width+x] then
				local ret=actors.actorAt(x,y)
				for i,v in ipairs(ret) do
					grid.setGlyph(x-x1,y-y1,v.glyph)
				end
			--print(x..","..y)
			end
			
		end
	end
end
