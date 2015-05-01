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
local function attack(self,user,target)

	for i,v in ipairs(self) do
		v:attack(user,target)
	end


end
local function defend(self,user,target)
	for i,v in ipairs(self) do
		v:defend(user,target)
	end


end
local function quaff(self,user,target)
	for i,v in ipairs(self) do
		v:quaff(user,target)
	end


end
local function eat(self,user,target)
	for i,v in ipairs(self) do
		v:eat(user,target)
	end

end
local function zap(self,user,target)
	for i,v in ipairs(self) do
		v:zap(user,target)
	end

end


function item.newItem(name,glyph)
	local i={}
	i.name=name
	i.gyph=gyph
	i.addComponent=addComponent
	i.removeComponent=removeComponent
	i.attack=attack
	i.defend=defend
	i.quaff=quaff
	i.eat=eat
	i.zap=zap
	return i
end


