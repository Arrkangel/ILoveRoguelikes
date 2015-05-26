require("grid")
local function newTile(glyph,remglyph,opaque,passable)
	local t={}
	t.glyph=glyph
	t.remglyph=remglyph
	t.opaque=opaque
	t.passable=passable
	return t
end

tile={}

tile.wall=newTile(grid.createGlyph("#",128,57,21),grid.createGlyph("#",77,34,13),true,false)
tile.floor=newTile(grid.createGlyph(".",75,75,75),grid.createGlyph(".",25,25,25),false,true)
tile.nothing=newTile(grid.createGlyph(" ",0,0,0),grid.createGlyph(" ",0,0,0),true,false)