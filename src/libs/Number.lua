--
-- Author: Mr.Chen
-- Date: 2015-02-12 13:48:36
--
Number = class("Number", function()
	return cc.Node:create()
end)


function Number:ctor(num ,type)
	cclog("Number:cotr")
	local node = cc.Node:create()

	local  t = Atlas.number[type]
	local size = Atlas.createSprite(t[1]):getContentSize()

	local x ,w ,h = 0,size.width,size.height

	-- cclog("Number:ctor(num = %d,type = %d)",num,type)
	while true do
		local child = Atlas.createSprite(t[num%10+1])
		node:addChild(child)
		child:setPositionX(x)
		x= x-w
		num = math.floor(num/10)
		if num ==0 then
			break
		end
	end

	self:addChild(node)
	node:setPositionX(-(x+w)/2)
end

return Number