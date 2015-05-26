require("tile")

<<<<<<< Updated upstream
dungen={}
=======
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
	bsp.room=nil
	return bsp
end
local function splitBSP(bsp,dir,pos)
	if not dir then
		local vertTest=false
		local horizTest=false
>>>>>>> Stashed changes


local function mapAt(map,x,y)
	return map[y*map.width+x]
end
local function setTile(map,x,y,t)
	map[y*map.width+x]=t
end

local function testRectangle(x1,y1,x2,y2,map)
	if x1<1 then
		return false
	end
	if y1<1 then
		return false
	end
<<<<<<< Updated upstream
	if x2>map.width-2 then
		return false
	end
	if y2>map.height-2 then
		return false 
=======
	return bsp.a,bsp.b
	

end

function dungen.recursiveSplit(bsp,depth,t,bBSP)
	
	local vertTest=false
	local horizTest=false
		if bsp.width-5>=5 then
		vertTest=true
	end
	if bsp.height-5>=5 then
		horizTest=true
>>>>>>> Stashed changes
	end

	for x=x1,x2 do
		for y=y1,y2 do
			if mapAt(map,x,y)==tile.floor then
				return false
			end
		end
	end
	return true
end

<<<<<<< Updated upstream

=======
	
	
	if dir=="vert" then
		pos=math.random(5,bsp.width-5)
	else
		pos=math.random(5,bsp.height-5)
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
	if not t[bsp.a.depth] then
		t[bsp.a.depth]={}
	end
	local depthTable=t[bsp.a.depth]
	if not depthTable[bsp] then
		depthTable[bsp]={}
	end
	local bspTable=depthTable[bsp]
	bspTable[#bspTable+1]=bsp.a
	bspTable[#bspTable+1]=bsp.b
	if bsp.a.depth>=depth then
		bBSP[#bBSP+1]=bsp.a
		bBSP[#bBSP+1]=bsp.b
		return
	else
		dungen.recursiveSplit(bsp.a,depth,t,bBSP)
		dungen.recursiveSplit(bsp.b,depth,t,bBSP)
	end

end
local function createRoom(x1,y1,x2,y2,bsp)
	local r={}
	r.x1=x1
	r.y1=y1
	r.x2=x2
	r.y2=y2
	r.bsp=bsp
	bsp.room=r
	return r
end


local function createRooms(t,r,map)
	for i,bsp in ipairs(t) do
		local x1=math.random(bsp.x+1,bsp.x+bsp.width-5)
		local y1=math.random(bsp.y+1,bsp.y+bsp.height-5)
		local x2=math.random(x1+1,bsp.x+bsp.width-1)
		local y2=math.random(y1+1,bsp.y+bsp.height-1)
		r[#r+1]=createRoom(x1,y1,x2,y2,bsp)
		
	end
end

local function connectRooms(t,maxDepth)

	
		

>>>>>>> Stashed changes

local function createRectangle(x1,y1,x2,y2,map,tile)
	for x=x1,x2 do
		for y=y1,y2 do
			map[y*map.width+x]=tile
		end
	end
end


function dungen.digGen(width,height)
	local map={}
<<<<<<< Updated upstream
	map.width=width
	map.height=height
=======
	local baseBSP=createBSP(0,0,width-1,height-1,0,nil)
	local t={} --empty table for storing bsp's
	local bBSP={} --for storing bottom-level BSP's
	local maxDepth=3
	dungen.recursiveSplit(baseBSP,maxDepth,t,bBSP)

	local rooms={} --empty table for storing rooms created by final bsp's
	createRooms(bBSP,rooms)
	
>>>>>>> Stashed changes
	for x=0,width-1 do
		for y=0,height-1 do
			map[y*width+x]=tile.wall
		end
	end
<<<<<<< Updated upstream
	createRectangle(25,25,30,30,map,tile.floor)
	local attempts=0
	local maxattempts=5000
	while attempts<maxattempts do
		attempts=attempts+1
		local found=false
		local xt=0
		local yt=0
		local dirs={}
		while not found do
			xt=math.random(0,width-1)
			yt=math.random(0,height-1)
			if mapAt(map,xt,yt)==tile.floor then
				if mapAt(map,xt-1,yt)==tile.wall then
					dirs[#dirs+1]="left"
				end
				if mapAt(map,xt+1,yt)==tile.wall then
					dirs[#dirs+1]="right"
				end
				if mapAt(map,xt,yt-1)==tile.wall then
					dirs[#dirs+1]="up"
				end
				if mapAt(map,xt,yt+1)==tile.wall then
					dirs[#dirs+1]="down"
				end
				if #dirs>0 then
					found=true
					--print(#dirs)
				end

			end
		end
		--room or corridor?
		if math.random()<0.10 then
			--print("corridor")
			--corridor
			local length=math.random(4,10)
			local pushLoop=math.random()<0.75
			local dir=dirs[math.random(1,#dirs)]
			if dir=="up" then
				if pushLoop then
					local i=length
					local push=true
					while push do
						if mapAt(map,xt,yt-i-1)==tile.floor then
							length=i
							push=false
						end
						i=i+1
						if i>10 then
							push=false
						end
					end
				end

				if testRectangle(xt-1,yt-length,xt+1,yt-1,map) then
					
					createRectangle(xt,yt-length,xt,yt-1,map,tile.floor)
				else
					goto continue
				end
			elseif dir=="down" then

				if pushLoop then
					local i=length
					local push=true
					while push do
						if mapAt(map,xt,yt+i+1)==tile.floor then
							length=i
							push=false
						end
						i=i+1
						if i>10 then
							push=false
						end
					end
				end

				
				if testRectangle(xt-1,yt+1,xt+1,yt+length,map) then
					
					createRectangle(xt,yt+1,xt,yt+length,map,tile.floor)
				else
					goto continue
				end
			elseif dir=="right" then
=======
	--[[for i,v in ipairs(bBSP) do
		for x=v.x+1,v.x+v.width-1 do
			for y=v.y+1,v.y+v.height-1 do
				map[y*width+x]=tile.floor
			end
		end
	end
	]]--
	
	for i,r in ipairs(rooms) do
		for x=r.x1,r.x2 do
			for y=r.y1,r.y2 do
				map[y*width+x]=tile.floor
			end
		end
	end
	
	return map
>>>>>>> Stashed changes

				if pushLoop then
					local i=length
					local push=true
					while push do
						if mapAt(map,xt+i+1,yt)==tile.floor then
							length=i
							push=false
						end
						i=i+1
						if i>10 then
							push=false
						end
					end
				end
				
				if testRectangle(xt+1,yt-1,xt+length,yt+1,map) then
					
					createRectangle(xt+1,yt,xt+length,yt,map,tile.floor)
				else
					goto continue
				end
			elseif dir=="left" then

				if pushLoop then
					local i=length
					local push=true
					while push do
						if mapAt(map,xt-i-1,yt)==tile.floor then
							length=i
							push=false
						end
						i=i+1
						if i>10 then
							push=false
						end
					end
				end
				
				if testRectangle(xt-length,yt-1,xt-1,yt+1,map) then
					
					createRectangle(xt-length,yt,xt-1,yt,map,tile.floor)
				else
					goto continue
				end
			end	

		else
			--room
			local rw=math.random(2,6)
			local rh=math.random(2,6)
			local dir=dirs[math.random(1,#dirs)]
			if dir=="up" then
				local rx1=xt-rw
				local ry1=yt-2-rh*2
				local rx2=xt+rw
				local ry2=yt-2
				if testRectangle(rx1-1,ry1-1,rx2+1,ry2+1,map) then
					createRectangle(rx1,ry1,rx2,ry2,map,tile.floor)
					setTile(map,xt,yt-1,tile.floor)
				else
					goto continue
				end
			elseif dir=="down" then
				local rx1=xt-rw
				local ry1=yt+2
				local rx2=xt+rw
				local ry2=yt+2+rh*2
				if testRectangle(rx1-1,ry1-1,rx2+1,ry2+1,map) then
					createRectangle(rx1,ry1,rx2,ry2,map,tile.floor)
					setTile(map,xt,yt+1,tile.floor)
				else
					goto continue
				end
			elseif dir=="right" then
				local rx1=xt+2
				local ry1=yt-rh
				local rx2=xt+2+rw*width-2
				local ry2=yt+rh
				if testRectangle(rx1-1,ry1-1,rx2+1,ry2+1,map) then
					createRectangle(rx1,ry1,rx2,ry2,map,tile.floor)
					setTile(map,xt+1,yt,tile.floor)
				else
					goto continue
				end
			elseif dir=="left" then
				local rx1=xt-2-rw*2
				local ry1=yt-rh
				local rx2=xt-2
				local ry2=yt+rh				
				if testRectangle(rx1-1,ry1-1,rx2+1,ry2+1,map) then
					createRectangle(rx1,ry1,rx2,ry2,map,tile.floor)
					setTile(map,xt-1,yt,tile.floor)
				else
					goto continue
				end
			end

		end

	::continue::
	end

	return map
end
