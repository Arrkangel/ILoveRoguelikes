io.stdout:setvbuf("no")

require("gamestate")
require("mainstate")

function love.load()
	love.window.setTitle("ILoveRoguelikes")
	love.window.setMode(50*11,50*12)
	font=love.graphics.newFont("Topaz-8.ttf",12)
	
	font:setFilter("nearest","nearest",0)
	love.graphics.setFont(font)

	love.graphics.setBackgroundColor(15,15,15)

	gamestate.pushState(mainstate)

	
end

function love.keypressed(key,isrepeat)
	gamestate.sendInput(key,isrepeat)
end


function love.update(dt)
	gamestate.update(dt)
end


function love.draw()
	--grid.draw()
	gamestate.draw()

end