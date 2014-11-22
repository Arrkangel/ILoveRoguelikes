--istead of objects rendering themselves, etc through loves functions
--it will all happen through this instead
--unless I plan on doing a non-ascii UI, which would have to be rendered seperately


grid={}
function grid.init(width,height)
	grid.width=width
	grid.height=height


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

