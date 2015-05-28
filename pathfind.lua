require("world")

pathfind={}
local dirX={-1, 0, 1,-1,1,-1,0,1}
local dirY={-1,-1,-1, 0,0, 1,1,1}

local function newNode(x,y,parent,move)
	local node={}
	node.x=x
	node.y=y
	node.parent=parent
	node.move=move
	node.g=move
	if parent then
		node.g=parent.g+move
	end
	return node
end

local function getH(x1,y1,x2,y2)
	return 10*(math.abs(x1-x2)+math.abs(y1-y2))
end

function pathfind.to(x1,y1,x2,y2)
	--local startTime=love.timer.getTime()

	local open={}
	local closed={}
	open[#open+1]=newNode(x1,y1,nil,0)
	local attempts=0
	local maxattempts=10000
	local success=false
	local fnode=nil
	while attempts<maxattempts do
		--print(attempts)
		--print(#open)
		attempts=attempts+1
		if #open==0 then
			break
		end
		local lowest=open[1]
		local lowf=open[1].g + getH(open[1].x,open[1].y,x2,y2)--+ heuristic
		local idx=1
		for i,v in ipairs(open) do

			if (v.g+getH(v.x,v.y,x2,y2)) <lowf then
				--print("low")
				lowf=v.g
				lowest=v
				idx=i
			end
		end
		table.remove(open,idx)
		closed[#closed+1]=lowest
		if lowest.x==x2 and lowest.y==y2 then
			--we made it!
			sucess=true
			fnode=lowest
			break
		end
		for d=1,8 do
			local nx=lowest.x+dirX[d]
			local ny=lowest.y+dirY[d]
			local oidx=0
			local cidx=0
			for i,v in ipairs(open) do
				if v.x==nx and v.y==ny then
					oidx=i
					break
				end
			end
			for i,v in ipairs(closed) do
				if v.x==nx and v.y==ny then
					cidx=i
				end
			end
			local move=10

			if d==1 or d==3 or d==6 or d==8 then
				move=14
			end

			local n=newNode(nx,ny,lowest,move)

			local free=world.isPassable(nx,ny)

			if free and cidx==0 and oidx==0 then
				open[#open+1]=n
			elseif oidx>=1 then
				local on=open[oidx]
				if n.g<on.g then
					table.remove(open,oidx)
					open[#open+1]=n
				end
			end
		end
	end

	local path={}
	local building=true
	local curnode=fnode
	while building do
		path[#path+1]=curnode
		if curnode.parent==nil then
			building=false
		else
			curnode=curnode.parent
		end
	end
	--local endTime=love.timer.getTime()
	--print("path found in "..1000*(endTime-startTime).." milliseconds")
	return path
end










