require("grid")
require("tile")
require("dungen")
world={}



function world.tileAt(x,y)
	return world[y*world.width+x]
end


function world.init(width,height)
	world.width=width
	world.height=height
	for x=0,width-1 do
		for y=0,height-1 do
			local t=tile.floor
			if x==0 or x==width-1 or y==0 or y==height-1 then
				t=tile.wall
			end

			world[y*width+x]=t
		end
	end
end

function world.initFile(fileName)
	local file,err=love.filesystem.newFile(fileName,"r")
	print(err)
	
	local data={}
	
	
	for line in file:lines() do
		print(line)
		data[#data+1]=line
	end
	local width=0
	for i,v in ipairs(data) do
		local length=#v


		if length>width then
			width=length
		end
		

	end
	world.width=width
	world.height=#data
	for y,v in ipairs(data) do
		for x=1,#v do
			local c=v:sub(x,x)
			local t=tile.nothing
			if c=="X" then
				t=tile.wall
			elseif c=="." then
				t=tile.floor
			end
			world[(y-1)*width+(x-1)]=t
		end
	end

	file:close()
end

function world.initGen(width,height)
	local data=dungen.digGen(width,height)
	world.height=height
	world.width=width
	for x=0,width-1 do
		for y=0,height-1 do
			world[y*width+x]=data[y*width+x]
		end
	end

end


function world.saveWorldAs(fileName)
	local file,err =love.filesystem.newFile(fileName,"w")
	
	local dat={}
	for y=0,world.height-1 do
		local str=""
		for x=0,world.width-1 do
			local t=world[y*world.width+x]
			if t==tile.wall then
				str=str.."X"
			elseif t==tile.floor then
				str=str.."."
			else
				str=str.." "
			end
		end
		dat[#dat+1]=str
	end
	for i,v in ipairs(dat) do
		
		file:write(v)
		if i<#dat then
			file:write("\n")
		end
	end
	file:close()


end

function world.isPassable(x,y)
	return world[y*world.width+x].passable
end
function world.isOpaque(x,y)
	return world[y*world.width+x].opaque
end


function world.toGrid(x1,y1,x2,y2)
	for x=x1,x2-1 do
		for y=y1,y2-1 do
			local tile=world[y*world.width+x]
			if tile then
				if viewmap[y*world.width+x] then
					grid.setGlyph(x-x1,y-y1,world[y*world.width+x].glyph)
				elseif remmap[y*world.width+x] then
					grid.setGlyph(x-x1,y-y1,world[y*world.width+x].remglyph)
				end
				
			end
			
			
		end
	end
end

function world.randomTile(t)
	local attempt=0
	local maxattempts=10000
	local x=0
	local y=0
	while attempt<maxattempts do
		x=math.random(0,world.width-1)
		y=math.random(0,world.height-1)
		if world.tileAt(x,y)==t then
			return x,y

		end
		attempt=attempt+1
	end
end
