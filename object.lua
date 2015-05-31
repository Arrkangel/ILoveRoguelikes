--similar to Actors, except these will be stationary (for the most part I hope) and no have a place in the schedule
--They will be reactive where actors are...active (get it?)
--objects should rarely be destroyed, so hopefully I can use a single table to hold all passable/opaque data

object={}
object.width=0
object.height=0
object.objMap={}
object.passMap={}
object.opaqMap={}



function object.init()
	object.width=world.width
	object.height=world.height
end

--I thought I would need this function, but I probably dont
--[[local function rebuildMap()
	for i,v in pairs(object.objMap) do
		object.passMap[i]=v.passable or object.passMap[i]
		object.opaqMap[i]=v.opaque or object.opaqMap[i]
	end
end
]]--


function object.add(object,x,y)
	local key=y*object.width+x
	local t=object.objMap[key]
	if not t then
		object.objMap[key]={}
		t=object.objMap[key]
	end
	t[#t+1]=object
	object.passMap[key]=object.passMap[key] or object.passable
	object.opaqMap[key]=object.opaqMap[key] or object.opaque
end




