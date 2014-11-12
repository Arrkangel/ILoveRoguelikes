gamestate={}
gamestate.statestack={}

function gamestate.init()
	gamestate.statestack={}
end
function gamestate.pushState(state)
	table.insert(gamestate.statestack,state)
end
function gamestate.popState()
	return table.remove(gamestate.statestack)
end

function gamestate.getCurrent()
	return gamestate.statestack[table.maxn(gamestate.statestack)]
	
end

function gamestate.sendInput(key,isrepeat)
	gamestate.getCurrent().handleInput(key,isrepeat)
end


-- more complex state systems, allowing drawing over other states, or letting input get through to lower states,
--will be added eventually. I promise. Soon (tm)
function gamestate.update(dt)
	local cur=gamestate.getCurrent()
	if cur then
		cur.update(dt)
	end
end
function gamestate.draw()
	local cur=gamestate.getCurrent()
	if cur then
		cur.draw()
	end

end

