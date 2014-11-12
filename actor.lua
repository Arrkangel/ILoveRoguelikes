require("point")
actor={}
actor.nextID=1


function actor.newActor(name,glyph,x,y,runTurn)
	local act={}
	act.name=name
	act.glyph=glyph
	act.pos=point.newPoint(x,y)
	act.runTurn=runTurn
	actor[actor.nextID]=act
	actor.nextID=actor.nextID+1
	return act
end