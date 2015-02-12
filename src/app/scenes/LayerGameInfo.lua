--
-- Author: Mr.Chen
-- Date: 2015-02-10 20:21:58
--LayerGameInfo.lua 
LayerGameInfo = class("LayerGameInfo", function()
	return cc.Layer:create()
end)

function LayerGameInfo:ctor()
	local child= {}
	self.child = child
	child.tutorial = Atlas.createSprite(Atlas.tutorial)
	child.tutorial:setPosition(display.cx,display.cy-10)
	self:addChild(child.tutorial)

	child.ready=Atlas.createSprite(Atlas.ready)
	child.ready:setPosition(display.cx,display.cy+100)
	self:addChild(child.ready)

	child.gameover = Atlas.createSprite(Atlas.gameover)
	child.gameover:setPosition(display.cx,display.cy+100)
	self:addChild(child.gameover)
end

function LayerGameInfo:ready()
	self.child.tutorial:setVisible(true)
	self.child.ready:setVisible(true)
	self.child.gameover:setVisible(false)
	self:removeIcon()
	self:removeLives()
	self:removeScore()
	self:removeTopScore()
end


function LayerGameInfo:play()
	cclog("play()执行了一次")
	self.child.tutorial:setVisible(false)
	self.child.ready:setVisible(false)
	self:addIcon()
	self:addLives()
	self:addScore()
	self:addTopScore()
end

function LayerGameInfo:over()
	self.child.gameover:setVisible(true)
end

function LayerGameInfo:removeIcon()
	if self.icon then
		self:removeChild(self.icon)
		self.icon = nil
	end
end

function LayerGameInfo:addIcon()
	self.icon = Atlas.createSprite(icon):scale(1.5)
	self.icon:setPosition(display.width-66,display.height-40)
	self:addChild(self.icon)
end

function LayerGameInfo:updateIcon()
	self:removeIcon()
	self:addIcon()
end

function LayerGameInfo:removeLives()
	if self.lives then
		self:removeChild(self.lives)
		self.lives = nil
	end
end

function LayerGameInfo:addLives()
	self.lives = Number.new(Game.lives,2)
	self.lives:setPosition(display.width-40,display.height-40)
	self:addChild(self.lives)
end

function LayerGameInfo:removeScore()
	if self.score then
		self:removeChild(self.score)
		self.score = nil
	end
end

function LayerGameInfo:addScore()
	cclog("Game.socre=%d",Game.score)
	self.score= Number.new(Game.score,1)
	self.score:setPosition(display.cx,display.height-50)
	self:addChild(self.score)
end

function LayerGameInfo:updateScore()
	self:removeScore()
	self:addScore()
end

function LayerGameInfo:updateLives()
	self:removeLives()
	self:addLives()
end


function LayerGameInfo:removeTopScore()
	if self.topscore then
		self:removeChild(self.topscore)
		self.topscore= nil
	end
end


function LayerGameInfo:addTopScore()
	self.topscore = cc.Label:createWithTTF("top score:"..Game.topscore,"04b08.TTF",32)
	self.topscore:setColor(cc.c3b(0xff,0xff,0xff))
	self.topscore:setAnchorPoint(0,1)
	self.topscore:setPosition(20,display.height-20)
	self:addChild(self.topscore)
end

function LayerGameInfo:updateTopScore()
	self:removeTopScore()
	self:addTopScore()
end

return LayerGameInfo