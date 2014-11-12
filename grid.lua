--istead of objects rendering themselves, etc through loves functions
--it will all happen through this instead
--unless I plan on doing a non-ascii UI, which would have to be rendered seperately


grid={}
function grid.init(width,height)
	grid.width=width
	grid.height=height

	--[[grid test code
	for x=0,grid.width-1 do
		for y=0,grid.width-1 do
			if x==0 or y==0 or x==width-1 or y==width-1 then
				grid.setGlyph(x,y,grid.createGlyph("#",128,57,21))
			else
				grid.setGlyph(x,y,grid.createGlyph(".",75,75,75))
			end
		end
	end
	grid.setGlyph(3,3,grid.createGlyph("@",255,255,255))
	grid.setGlyph(3,6,grid.createGlyph("g",17,100,22))
	grid.setGlyph(7,3,grid.createGlyph("r",125,125,125))
	grid.setGlyph(5,5,grid.createGlyph("D",126,21,24))
	]]--



end
function grid.clear()
	local blank=grid.createGlyph(" ",0,0,0)
	for x=0,grid.width-1 do
		for y=0,grid.height-1 do
			grid.setGlyph(x,y,blank)
		end
	end
end

function grid.createGlyph(char,r,g,b)
	local glyph={}
	glyph.char=char
	glyph.r=r
	glyph.g=g
	glyph.b=b

	return glyph
end


function grid.setGlyph(x,y,glyph)
	grid[y*grid.width+x]=glyph
end



function grid.draw()
	for x=0,grid.width-1 do
		for y=0,grid.height-1 do
			local glyph=grid[y*grid.width+x]
			if glyph==nil then
				glyph=grid.createGlyph(" ",255,255,255)
			end
			love.graphics.setColor(glyph.r,glyph.g,glyph.b)
			love.graphics.print(glyph.char,x*11,y*12)
		end
	end
end

