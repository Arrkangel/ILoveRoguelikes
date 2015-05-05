require("tile")
require("util")
dungen={}

local function createBSP(x,y,width,height,depth,parent)
	local bsp={}
	bsp.x=x
	bsp.y=y
	bsp.width=width
	bsp.height=height
	bsp.parent=parent
	--print(type(bsp.height))
	bsp.a=nil
	bsp.b=nil
	bsp.depth=depth
	return bsp
end
local function splitBSP(bsp,dir,pos)
	if not dir then
		local vertTest=false
		local horizTest=false

		if bsp.width-3>=3 then
			vertTest=true
		end
		if bsp.height-3>=3 then
			horizTest=true
		end
		if vertTest and horizTest then
			if math.random()<0.5 then
				dir="horiz"
			else
				dir="vert"
			end
		elseif vertTest then
			dir="vert"
		elseif horizTest then
			dir="horiz"
		else
			return nil,nil
		end

	end
	if not pos then
		if dir=="vert" then
			pos=math.random(3,bsp.width-3)
		else
			pos=math.random(3,bsp.height-3)
		end

	end
	--print(dir)
	if dir=="vert" then
		bsp.a=createBSP(bsp.x,bsp.y,pos,bsp.height,bsp.depth+1,bsp)
		bsp.b=createBSP(bsp.x+pos+1,bsp.y,bsp.width-pos-1,bsp.height,bsp.depth+1,bsp)
		--print("splitVert")
	else
		bsp.a=createBSP(bsp.x,bsp.y,bsp.width,pos,bsp.depth+1,bsp)
		bsp.b=createBSP(bsp.x,bsp.y+pos+1,bsp.width,bsp.height-pos-1,bsp.depth+1,bsp)
		--print("splitHoriz")
	end
	return bsp.a,bsp.b
	

end

function dungen.rescursiveSplit(parent,depth,t)
	
	local vertTest=false
	local horizTest=false
		if bsp.width-3>=3 then
		vertTest=true
	end
	if bsp.height-3>=3 then
		horizTest=true
	end
	if vertTest and horizTest then
		if math.random()<0.5 then
			dir="horiz"
		else
			dir="vert"
		end
	elseif vertTest then
		dir="vert"
	elseif horizTest then
		dir="horiz"
	else
		return nil,nil
	end

	
	
	if dir=="vert" then
		pos=math.random(3,bsp.width-3)
	else
		pos=math.random(3,bsp.height-3)
	end

	
	--print(dir)
	if dir=="vert" then
		bsp.a=createBSP(bsp.x,bsp.y,pos,bsp.height,bsp.depth+1,bsp)
		bsp.b=createBSP(bsp.x+pos+1,bsp.y,bsp.width-pos-1,bsp.height,bsp.depth+1,bsp)
		--print("splitVert")
	else
		bsp.a=createBSP(bsp.x,bsp.y,bsp.width,pos,bsp.depth+1,bsp)
		bsp.b=createBSP(bsp.x,bsp.y+pos+1,bsp.width,bsp.height-pos-1,bsp.depth+1,bsp)
		--print("splitHoriz")
	end
	if bsp.a.depth>=depth then
		t[#t+1]bsp.a
		t[#t+1]bsp.b
		return
	else
		recursiveSplit(bsp.a,depth)
		recursiveSplit(bsp.b,depth)

end


function dungen.bspGen(width,height)
	local map={}
	local baseBSP=createBSP(0,0,width-1,height-1,1,nil)
	local a,b=splitBSP(baseBSP)
	
	for x=0,width-1 do
		for y=0,height-1 do
			map[y*width+x]=tile.wall
		end
	end

	
	
	return map


end
