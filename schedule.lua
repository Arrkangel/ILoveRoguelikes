schedule={}
schedule.list={}
schedule.idx=1

function schedule.addActor(act)
	table.insert(schedule.list,act)
end

function schedule.run()
	local act=schedule.list[schedule.idx]
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