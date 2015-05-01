schedule={}
schedule.list={}
schedule.idx=1
schedule.destroy={}

function schedule.addActor(act)
	table.insert(schedule.list,act)
end

function schedule.run()
	local act=schedule.list[schedule.idx]
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
	if not act.runTurn then
		schedule.idx=schedule.idx+1
		if schedule.idx>table.maxn(schedule.list) then

			schedule.idx=1
		end
		return
	end

	local r=act:runTurn()
	if r==true then
		schedule.idx=schedule.idx+1
		if schedule.idx>table.maxn(schedule.list) then
			
			schedule.idx=1
		end
	end
	



end

function schedule.flagDestroy(actor)
	table.insert(schedule.destroy,actor)
end
