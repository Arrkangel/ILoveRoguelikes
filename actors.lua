require("point")
require("world")
require("grid")
actors={}

function actors.actorAt(x,y)
	local ret={}
	for i,v in ipairs(actors) do
		if v.pos.x==x and v.pos.y==y then
			ret[#ret+1]=v
		end
	end
	return ret
end



function actors.newActor(name,glyph,x,y,runTurn)
	local act={}
	act.name=name
	act.glyph=glyph
	act.pos=point.newPoint(x,y)
	act.runTurn=runTurn

	
	
	act.move=function(self,x,y)
		local testP=point.newPoint(x,y)
		testP:push(self.pos.x,self.pos.y)
		
		if world.isPassable(testP.x,testP.y) then
			if #actors.actorAt(testP.x,testP.y)==0 then
				self.pos:push(x,y)
			end

			
		end
	end
	act.draw=function(self)
		grid.setGlyph(self.pos.x,self.pos.y,self.glyph)
	end

	actors[#actors+1]=act
	act.id=#actors

	return act
end

