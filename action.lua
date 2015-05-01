require("player")
action={}

function action.move(actor,x,y,attack)
	local testP=point.newPoint(x,y)
	testP:push(actor.pos.x,actor.pos.y)
	
	if world.isPassable(testP.x,testP.y) then
		if #actors.actorAt(testP.x,testP.y)==0 and not player.pos:equals(testP) then
			actor.pos:push(x,y)
		elseif attack then
			action.attack(actor,testP.x,testP.y)
		end
	end
end

function action.attack(actor,x,y)
	if player.pos:equalsNum(x,y) then
		player.sheet.hp=player.sheet.hp-1
		print("Player hit! "..player.sheet.hp)
	end
end


