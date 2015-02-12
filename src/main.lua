
function cclog(...)
    if not Config.debug then
        return
    end
    local log = string.format(...)
    local func = debug.getinfo(2)
    print(string.format("%s:%d %s", func.source, func.currentline, log))
end


function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

package.path = package.path .. ";src/"
cc.FileUtils:getInstance():setPopupNotify(false)
require("app.MyApp").new():run()
