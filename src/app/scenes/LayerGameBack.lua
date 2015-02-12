--
-- Author: Mr.Chen
-- Date: 2015-02-10 20:19:21
--LayerGameBack.lua 


LayerGameBack = class("LayerGameBack", function ()
	return cc.Layer:create()
end)

function LayerGameBack:ctor()
	local bg = Atlas.createSprite(Atlas.bg)
	bg:setPosition(display.cx,display.cy)
	self:addChild(bg)
end

return LayerGameBack