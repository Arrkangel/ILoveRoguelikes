require("grid")
local function newTile(glyph,opaque,passable)
	local t={}
	t.glyph=glyph
	t.opaque=opaque
	t.passable=passable
	return t
end

tile={}

tile.wall=newTile(grid.createGlyph("#",128,57,21),true,false)
tile.floor=newTile(grid.createGlyph(".",75,75,75),false,true)
tile.nothing=newTile(grid.createGlyph(" ",0,0,0),true,false)