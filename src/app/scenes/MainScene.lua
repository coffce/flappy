require("app.scenes.SceneGame")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local label = cc.Label:createWithTTF("FlappyCoco","04b08.TTF",42)
    label:setColor(cc.c3b(0,0xff,0))
    label:setPosition(display.cx,display.cy+24)
    self:addChild(label)

    label = cc.Label:createWithTTF("FlappyBird quick-cocos","04b08.TTF",16)
    label:setColor(cc.c3b(0xff,0,0xff))
    label:setPosition(display.cx,display.cy-16)
    self:addChild(label)

    local function onNodeEvent(event)
    	if event == "enter" then
    		performWithDelay(self, self.load,0.5)
    	end
    end
    self:registerScriptHandler(onNodeEvent)
end

function MainScene:load()
	cclog("MainScene:load()")
	--预加载图片资源
	atlas=ccDirector:getTextureCache():addImage("atlas.png")
	atlas:setAntiAliasTexParameters()

    scene = SceneGame.new()
    ccDirector:replaceScene(cc.TransitionFade:create(1,scene))

    cclog("Happy Hacking")
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
