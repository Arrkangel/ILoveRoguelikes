--should it make points, or just edit them? probably both...yeah
point={}



local function push(self,x,y)
	self.x=self.x+x
	self.y=self.y+y
end


function point.newPoint(x,y)
	local p={}
	p.x=x
	p.y=y
	p.push=push
	return p
end
function point.add(p1,p2)
	local pn={}
	pn.x=p1.x+p2.x
	pn.y=p1.y+p2.y
	return pn
end
function point.dist(p1,p2)
	return math.sqrt((p1.x-p2.x)^2 + (p1.y-p2.y)^2) 
end
