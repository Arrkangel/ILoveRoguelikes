schedule={}
schedule.list={}
schedule.idx=1
schedule.destroy={}



function schedule.addActor(act)
	table.insert(schedule.list,act)
end

function schedule.run()
	local r=true
	while r do
		for i,v in ipairs(schedule.destroy) do
			for x,y in ipairs(schedule.list) do
				if v==y then
					table.remove(schedule.list,x)
				end
			end
		end
		for k in pairs(schedule.destroy) do
			schedule.destroy[k]=nil
		end
		local act=schedule.list[schedule.idx]
		while not act do
			schedule.idx=schedule.idx+1
			if schedule.idx>#schedule.list then
				schedule.idx=1
			end
			act=schedule.list[schedule.idx]
		end
	

		r=act:runTurn()
		if r==true then
			schedule.idx=schedule.idx+1
			if schedule.idx>#schedule.list then
				local newTime=love.timer.getTime()

				schedule.idx=1
			end
		end
	end
	
end

function schedule.flagDestroy(actor)
	table.insert(schedule.destroy,actor)
end
