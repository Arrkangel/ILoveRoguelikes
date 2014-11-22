item={}


local function addComponent(self,component)
	self[#self+1]=component
	component.owner=self
end
local function removeComponent(self,component)
	for i,v in ipairs(self) do
		if v==component then
			table.remove(self,i)
		end
	end
	component.owner=nil
end




function item.newItem(name,glyph)
	local i={}
	i.name=name
	i.gyph=gyph
end
