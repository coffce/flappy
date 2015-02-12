--
-- Author: Mr.Chen
-- Date: 2015-02-10 11:31:35
--音频文件 
-- local sharedEngine = cc.SimpleAudioEngine:getInstance()
--定义音效文件表
Audio = Audio or {
    die = "sfx_die.ogg",
    hit = "sfx_hit.ogg",
    wing = "sfx_wing.ogg",
    -- wing ="sfx_bg.mp3",
    point = "sfx_point.ogg",
    swoosh = "sfx_swooshing.ogg",
}

--批量预加载音效文件 
function Audio.init()
    Audio.load(Audio.die)
    Audio.load(Audio.hit)
    Audio.load(Audio.wing)
    Audio.load(Audio.point)
    Audio.load(Audio.swoosh)
    -- for _,v in pairs(Audio) do
    -- 	-- Audio.load(v)
    --     -- cclog("Audio.init :%s",v)
    --     print("v:"..tostring(v))
    -- end
end

function Audio.load(name)
     local file = string.format("res/%s", name)
    -- cclog("Audio.load %s", file)
    audio.preloadSound(file)
    -- sharedEngine:preloadEffect(name)
end

--默认为isLoop为false ，只播放一次
function Audio.play(name,isLoop)
    local file = string.format("res/%s", name)
    -- local file = string.format("res/%s",name)
    -- cclog("Audio.play %s 播放一次", name)
   local i= audio.playSound(file,isLoop)
    -- sharedEngine:playEffect(name,false)
end

return Audio