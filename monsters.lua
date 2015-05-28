

monsters={}
monsters.glyph={}
monsters.glyph.test=grid.createGlyph("g",10,255,10)


function monsters.newMonster(type,x,y)
	--eventually this function will look into a database and generate a monster of "type" from there...eventually
	--for now, create test monster
	local mTurn=function(self)
		local stime=love.timer.getTime()
		if not actors.stateCheck(self) then
			if not self.maps then
				self.maps=fov.newMaps()
			end
			local sx=self.pos.x
			local sy=self.pos.y
			local px=player.pos.x
			local py=player.pos.y
			--[[if (px-sx)*(px-sx)+(py-sy)*(py-sy)>100 then
				return true
			end
			if fov.los(sx,sy,px,py) then
				local path=pathfind.to(px,py,sx,sy)
				local mx=path[2].x
				local my=path[2].y
				self:move(mx-sx,my-sy,true)
			end
			]]--
			fov.run(self.maps,sx,sy,15)
			if fov.canSee(self.maps,px,py) then
				local path=pathfind.to(px,py,sx,sy)
				local mx=path[2].x
				local my=path[2].y
				self:move(mx-sx,my-sy,true)
			end
			
		end
		local etime=love.timer.getTime()
		--print("test monster turn: "..(etime-stime))
		return true
	end
	local mon=actors.newActor("TestMonster",monsters.glyph.test,x,y,mTurn,stats.newSheet(10,10,10,10,10,10))
	schedule.addActor(mon)

end