
require("config")
require("cocos.init")
require("framework.init")


local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)

end

function MyApp:run()
	--避免内存泄漏
	collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    math.randomseed(os.time())


    local serpent = require("libs.serpent")
   	dump, dump1 = serpent.block, serpent.line

    cc.FileUtils:getInstance():addSearchPath("res/")
    ccDirector = cc.Director:getInstance()
   	--获取用户存取数据的值
	ccUserDefault = cc.UserDefault:getInstance()
    self:enterScene("MainScene")
end

return MyApp
