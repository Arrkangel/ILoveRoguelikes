require("gamestate")
require("grid")

mainstate={}

grid.init(50,50)

function mainstate.update(dt)
	--nifty game stuff goes here

end
function mainstate.draw()
	--so much nifty stuff
	grid.draw()
	--love.graphics.print("I'm a state! Awesome!",0,0)
end
