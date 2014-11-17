require("point")
require("world")
actor={}
actor.nextID=1


function actor.newActor(name,glyph,x,y,runTurn)
	local act={}
	act.name=name
	act.glyph=glyph
	act.pos=point.newPoint(x,y)
	act.runTurn=runTurn

	act.action={}
	
	act.move=function(self,x,y)
		local testP=point.newPoint(x,y)
		testP:push(self.pos.x,self.pos.y)
		print(testP.x)
		print(testP.y)
		if world.isPassable(testP.x,testP.y) then
			self.pos:push(x,y)
		end
	end

	actor[actor.nextID]=act
	actor.nextID=actor.nextID+1

	return act
end