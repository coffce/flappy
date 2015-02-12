--
-- Author: Mr.Chen
-- Date: 2015-02-10 14:08:08
-- 水管 柱子，上下柱子

Pipe = class("Pipe", function()
	return cc.Node:create()
end)


function Pipe:ctor()
	self.pass = false

	local upPipe = Atlas.createSprite(Atlas.pipe[1])
	local downPipe = Atlas.createSprite(Atlas.pipe[2])

	local upPipeBox = cc.PhysicsBody:createBox(upPipe:getContentSize())
	local downPipeBox = cc.PhysicsBody:createBox(downPipe:getContentSize())

	--是否受重力影响
	upPipeBox:setDynamic(false)
	downPipeBox:setDynamic(false)

	upPipeBox:setContactTestBitmask(1)
	downPipeBox:setContactTestBitmask(1)

	upPipe:setPhysicsBody(upPipeBox)
	downPipe:setPhysicsBody(downPipeBox)

	self:addChild(upPipe)
	self:addChild(downPipe)

	local size = upPipe:getContentSize()

	self.w,self.h,self.h1 = size.width,size.height/2,0

	-- cclog("pipe:ctor: self.w= %d,self.h=%d,self.h1=%d",self.w,self.h,self.h1)

	upPipe:setPosition(-self.w/2,-self.h +150)
	downPipe:setPosition(-self.w/2,self.h+Config.pipeDistance+150)

end

return Pipe