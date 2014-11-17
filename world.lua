require("grid")
require("tile")
world={}




function world.init(width,height)
	world.width=width
	world.height=height
	for x=0,width-1 do
		for y=0,height do
			local t=tile.floor
			if x==0 or x==width-1 or y==0 or y==height-1 then
				t=tile.wall
			end

			world[y*width+x]=t
		end
	end
end

function world.isPassable(x,y)
	return world[y*world.width+x].passable
end
function world.isOpaque(x,y)
	return world[y*world.width+x].opaque
end


function world.toGrid()
	for x=0,world.width-1 do
		for y=0,world.height-1 do
			grid.setGlyph(x,y,world[y*world.width+x].glyph)
			
		end
	end
end
