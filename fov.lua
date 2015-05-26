--a terrible implementation of Shadowcasting
require("world")
require("point")
fov={}


mult={
            {1, 0, 0, -1, -1, 0, 0, 1},
            {0, 1, -1, 0, 0, -1, 1, 0},
            {0, 1, 1, 0, 0, -1, -1, 0},
            {1, 0, 0, 1, -1, 0, 0, -1}
    		}
viewmap={}
remmap={}
function fov.init()
	for x=0,world.width-1 do
		for y=0,world.height-1 do
			remmap[y*world.width+x]=false
		end
	end
end

local function light(x,y)
	viewmap[y*world.width+x]=true
	remmap[y*world.width+x]=true
end

local function clearView()
	for x=0,world.width-1 do
		for y=0,world.height-1 do
			viewmap[y*world.width+x]=false
		end
	end
end

local function radius(x,y)
	return math.sqrt(x*x+y*y)
end


local function castLight(cx,cy,row, start, fin,radius, xx, xy, yx, yy, depth)
	if start < fin then
		return
	end
	local radius_squared=radius*radius
	for j=row,radius do
		local dx=-j-1
		local dy=-j
		local blocked=false
		local newStartSlope=0.0
		while dx<=0 do
			dx=dx+1
			local x=cx+dx*xx+dy*xy
			local y=cy+dx*yx+dy*yy

			local lslope=(dx-0.5)/(dy+0.5)
			local rslope=(dx+0.5)/(dy-0.5)
			if start<rslope then
				goto continue
				elseif fin > lslope then
				break
			else
				if (dx*dx+dy*dy)<radius_squared then
					light(x,y)
				end
				if blocked then
					if world.isOpaque(x,y) then
						newStartSlope=rslope
						goto continue
					else
						blocked=false
						start=newStartSlope
					end
				else
					if world.isOpaque(x,y) and j<radius then
						blocked=true
						castLight(cx,cy,j+1,start,lslope,radius,xx,xy,yx,yy,depth+1)
						newStartSlope=rslope
					end
				end
			end
			::continue::
		end
		if blocked then break end
	end
end




function fov.run(x,y,dist)
	clearView()
	light(x,y)
	
	for oct=1,8 do
		castLight(x,y,1,1.0,0.0,dist,mult[1][oct],mult[2][oct],mult[3][oct],mult[4][oct],0)
	end
end

function fov.bresenham(x1, y1, x2, y2)
	local line={}
  	delta_x = x2 - x1
  	ix = delta_x > 0 and 1 or -1
  	delta_x = 2 * math.abs(delta_x)
 
  	delta_y = y2 - y1
  	iy = delta_y > 0 and 1 or -1
  	delta_y = 2 * math.abs(delta_y)
 
 	line[#line+1]=point.newPoint(x1,y1)
 
  	if delta_x >= delta_y then
  	  error = delta_y - delta_x / 2
 
  	  while x1 ~= x2 do
  	    if (error >= 0) and ((error ~= 0) or (ix > 0)) then
  	      error = error - delta_x
 	       y1 = y1 + iy
	      end
 
 	     error = error + delta_y
  	    x1 = x1 + ix
 
 	     line[#line+1]=point.newPoint(x1,y1)
 	   end
 	 else
 	   error = delta_x - delta_y / 2
 
  	  while y1 ~= y2 do
	      if (error >= 0) and ((error ~= 0) or (iy > 0)) then
    	    error = error - delta_y
    	    x1 = x1 + ix
    	  end
 
    	  error = error + delta_x
     	y1 = y1 + iy
 
    	line[#line+1]=point.newPoint(x1,y1)
    	end
 	end
 	return line
end

function fov.los(x1,y1,x2,y2)

	return fov.losline(fov.bresenham(x1,y1,x2,y2))
end
function fov.losline(line)
	for i,v in ipairs(line) do
		if world.isOpaque(v.x,v.y) then
			return false,v
		end
	end
	return true,nil
end






