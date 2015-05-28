require("tile")

dungen={}


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
	if x2>map.width-2 then
		return false
	end
	if y2>map.height-2 then
		return false 
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



local function createRectangle(x1,y1,x2,y2,map,tile)
	for x=x1,x2 do
		for y=y1,y2 do
			map[y*map.width+x]=tile
		end
	end
end


function dungen.digGen(width,height)
	local map={}
	map.width=width
	map.height=height
	for x=0,width-1 do
		for y=0,height-1 do
			map[y*width+x]=tile.wall
		end
	end
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
			local length=math.random(2,14)
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
