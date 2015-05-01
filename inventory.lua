--player inventory, monsters will be seperate I think
inventory={}
inventory.slots={}
inventory.space={}
function inventory.equip(item)
	if inventory.slots[item.type] then
		inventory.space[#inventory.space+1]=inventory.slots[item.type]
	end
	inventory.slots[item.type]=item
end
