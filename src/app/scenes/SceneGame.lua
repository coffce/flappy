--
-- Author: Mr.Chen
-- Date: 2015-02-10 16:49:41
--
require("app.scenes.module")

SceneGame = class("SceneGame", function()
	return display.newPhysicsScene("SceneGame")
end)

function SceneGame:ctor()
	self:getPhysicsWorld():setGravity(cc.p(0,Config.gravity))
	if Config.debugPhysics then
		self:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
	end

	Audio.init()

	Atlas.init()

	self.layer= {}
	self.layer.game = LayerGame.new()
	self.layer.back = LayerGameBack.new():scale(1.5)
	self.layer.info = LayerGameInfo.new()

	self:addChild(self.layer.back)
	self:addChild(self.layer.game)
	self:addChild(self.layer.info)
end

return SceneGame