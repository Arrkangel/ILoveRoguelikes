require("actors")
require("grid")
require("schedule")



local function playerTurn(self)
	if not self.lastKey then
		return false
	end
	local key=self.lastKey
	if key=="kp8" or key=="k" then
		self:move(0,-1)
	end
	if key=="kp2" or key=="j" then
		self:move(0,1)
	end
	if key=="kp4" or key=="h" then
		self:move(-1,0)
	end
	if key=="kp6" or key=="l" then
		self:move(1,0)
	end
	if key=="kp7" or key=="y" then
		self:move(-1,-1)
	end
	 if key=="kp9" or key=="u" then
	 	self:move(1,-1)
	 end
	 if key=="kp3" or key=="n"  then
	 	self:move(1,1)
	 end
	 if key=="kp1" or key=="b" then
	 	self:move(-1,1)
	 end
	 self.lastKey=nil
	 return true
end

player=actors.newActor("player",grid.createGlyph("@",255,255,255),3,3,playerTurn)
player.lastKey=nil
schedule.addActor(player)
