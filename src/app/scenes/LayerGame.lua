--
-- Author: Mr.Chen
-- Date: 2015-02-10 11:48:15
--游戏层
local State ={
	READY =0,
	PLAY = 1,
	OVER = 2,
}

LayerGame = class("LayerGame", function ()
	return cc.Layer:create()
end)

function LayerGame:ctor()
	Game = {}
	Game.topscore = ccUserDefault:getIntegerForKey("topscore")
	cclog("Game.topscore= %d",Game.topscore)

	local function onNodeEvent(event)
		if event == "enter" then
			self:init()
			self:ready()
		elseif event =="exit" then
			self:unscheduleUpdate()
		end
	end
	self:registerScriptHandler(onNodeEvent)
end

--初始化游戏场景
function LayerGame:init()
	self:addEdgeBox()
	self:addPipe()
	self:addGround()
	self:addMenu()
	self:addListener()
end

function LayerGame:addEdgeBox()
	local edgeBox = cc.Sprite:create()
	edgeBox:setPosition(display.cx,display.cy+Config.groundHeight/2)

	local size =cc.size(display.width,display.height-Config.groundHeight)
	local body = cc.PhysicsBody:createEdgeBox(size)
	body:setContactTestBitmask(1)
	edgeBox:setPhysicsBody(body)
	self:addChild(edgeBox)
	self.edgeBox = edgeBox
end

--添加菜单
function LayerGame:addMenu()
	-- body
	local play = Atlas.createSprite(Atlas.play)
	local playItem = cc.MenuItemSprite:create(play,play)
	playItem:setPosition(display.cx,display.cy)

	local select = Atlas.createSprite(Atlas.select)
	local selectItem = cc.MenuItemSprite:create(select,select)
	selectItem:setPosition(display.cx-200,display.cy+20)

	local menu = cc.Menu:create(playItem,selectItem)
	menu:setPosition(0,0)
	self:addChild(menu)
	self.menu= {playItem = playItem, selectItem = selectItem}

	local function onTapPlay()
		self:ready()
	end
	playItem:registerScriptTapHandler(onTapPlay)

	local function onTapSelect()
		self:newBird((self.bird.type <3) and (self.bird.type+1) or 1)
	end
	selectItem:registerScriptTapHandler(onTapSelect)
end


function LayerGame:addPipe()
	local pipe = cc.Sprite:create()
	pipe:setPosition(0,Config.groundHeight)

	self:addChild(pipe)
	self.pipe = pipe
end

function LayerGame:newPipe()
	local x = display.width
	for i=1,Config.pipeCount do
		local pipe= Pipe.new()
		x = x + Config.pipeInterval
		pipe:setPosition(x,math.random(pipe.h1,pipe.h))
		self.pipe:addChild(pipe)
	end

	local ghost= Ghost.new():scale(1.5)
	ghost:setPosition(x+150,math.random(ghost.h1,ghost.h))
	self.pipe:addChild(ghost)
end

--addBird
function LayerGame:addBird(x,y,type)
	if self.bird then
		self:removeChild(self.bird)
	end
	self.bird= Bird.new(type):scale(1.5)
	self.bird:setPosition(x,y)
	self:addChild(self.bird)
end

function LayerGame:newBird(type)
	Audio.play(Audio.swoosh)
	local x = self.menu.selectItem:getPositionX()+4
	local y = self.menu.selectItem:getPositionY()
	self:addBird(x,y,type or math.random(3))
end

function LayerGame:addGround()
	local ground1 = Atlas.createSprite(Atlas.ground)
	local ground2 = Atlas.createSprite(Atlas.ground)

	ground1:setAnchorPoint(0,1)
	ground2:setAnchorPoint(0,1)

	ground1:setPosition(0,Config.groundHeight)
	ground2:setPosition(0,Config.groundHeight)

	self:addChild(ground1)
	self:addChild(ground2)

	self.ground={ground1,ground2}
end

function LayerGame:addListener()
	local function onScheduleUpdate()
		self:update()

	end
	self:scheduleUpdateWithPriorityLua(onScheduleUpdate,0)

	local function onTouchBegan(touch,event)
		self:touch()
	end

	local touchListener= cc.EventListenerTouchOneByOne:create()
	touchListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	ccDirector:getEventDispatcher():addEventListenerWithSceneGraphPriority(touchListener, self)

	local function onContactBegin(contact)
		self:contact()
		cclog("碰撞了一次")
	end
	local contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    ccDirector:getEventDispatcher():addEventListenerWithSceneGraphPriority(contactListener, self)

end

--contact() 接触

function LayerGame:contact()
	cclog("LayerGame:contact()")
	if Game.state == State.PLAY then
		Audio.play(Audio.hit)
		self.bird:die()
		Game.lives = Game.lives -1
		scene.layer.info:updateLives()
		cclog("LayerGame:contact():%d",Game.lives)
		if Game.lives ==0 then
			self.over()
			self.menu.playItem:setVisible(true)
		end
	end
end



--touch ，触摸。
function LayerGame:touch()
	cclog("LayerGame:touch()")
	if Game.state==State.READY then
		self.bird:play()
		self:play()
	elseif Game.state == State.PLAY then
		self.bird:wing()
	end
end

--ready 
function LayerGame:ready()
	cclog("layerGame:ready()")
	Game.state = State.READY
	cclog("LayerGame:ready Config.birdLives:%d",Config.birdLives)
	Game.lives = Config.birdLives
	Game.score = 0
	self:removePipe()
	self:newBird()
	self.menu.selectItem:setVisible(true)
	self.menu.playItem:setVisible(false)
	scene.layer.info:ready()
end

--play

function LayerGame:play()
	cclog("LayerGame:play()")
	Game.state = State.PLAY
	self:newPipe()
	self.menu.selectItem:setVisible(false)
	scene.layer.info:play()
end


--over 结束游戏
function LayerGame:over()
	cclog("LayerGame:over()")
	Game.state = State.OVER
	cclog("Game.socre=%d",Game.score)
	if Game.topscore < Game.score then
		Game.topscore = Game.score
		ccUserDefault:setIntegerForKey("topscore", Game.topscore)
	end
	-- self.menu.playItem:setVisible(true)
	scene.layer.info:over()
end

--update
function LayerGame:update()
	if Game.state==State.PLAY then
		self.bird:update()
	elseif Game.state==State.OVER then
		return 
	end
	self:scrollGround()
	self:scrollPipe()
	self:checkPoint()
end

--scrollGround
function LayerGame:scrollGround()
	local ground1= self.ground[1]
	local ground2= self.ground[2]

	if ground2:getPositionX()== (ground1:getContentSize().width/2) then
		ground1:setPositionX(0)
	end

	local x1= ground1:getPositionX()-Config.scroll

	local x2= x1+ground1:getContentSize().width

	-- cclog("x1=%d,x2 = %d",x1,x2)

	ground1:setPositionX(x1)
	ground2:setPositionX(x2)
end

--scrollPipe
function LayerGame:scrollPipe()
	-- cclog("self.pipe:getChildren() size=%d",table.getn(self.pipe:getChildren()))
	for i,pipe in ipairs(self.pipe:getChildren()) do
		local x= pipe:getPositionX()
		if x>=-pipe.w then
			pipe:setPositionX(x-Config.scroll)
		else
			x= display.width
			pipe:setPosition(x,math.random(pipe.h1,pipe.h))
			pipe.pass = false
		end
	end
end

--point()
function LayerGame:point()
	cclog("LayerGame:point()")
	Audio.play(Audio.point)
	Game.score = Game.score + 1
	scene.layer.info:updateScore()
end


--checkPoint
function LayerGame:checkPoint()
	for i,pipe in ipairs(self.pipe:getChildren()) do
		if not pipe.pass then
			local pipeX = pipe:getPositionX()
			local birdX = self.bird:getPositionX()
			if pipeX+pipe.w<birdX then
				-- cclog("LayerGame:checkPoint() pipeX=%d,pipe.w=%d,birdX=%d",pipeX,pipe.w,birdX)
				pipe.pass =true
				self:point()
			end
		end
	end
end

function LayerGame:removePipe( )
	self.pipe:removeAllChildrenWithCleanup(true)
end

return LayerGame