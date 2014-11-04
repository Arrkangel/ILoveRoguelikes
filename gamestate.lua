gamestate={}


function gamestate.init()
	gamestate.statestack={}
end
function gamestate.pushState(state)
	table.insert(gamestate.statestack,state)
end
function gamestate.popState()
	return table.remove(gamestate.statestack)
end

