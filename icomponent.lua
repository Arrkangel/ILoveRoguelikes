--item component, unlikely entities/actors will have a component system but gonna name it that way

icomponent={}


function icomponent.new(attack,defend,quaff,eat,zap)
	local comp={}
	comp.attack=attack
	comp.defend=defend
	comp.quaff=quaff
	comp.eat=eat
	comp.zap=zap
	comp.owner=nil
	

	return comp
end
