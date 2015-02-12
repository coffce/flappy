
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 1

-- display FPS stats on screen
DEBUG_FPS = true

-- dump memory info every 10 seconds
DEBUG_MEM = false

-- load deprecated API
LOAD_DEPRECATED_API = false

-- load shortcodes API
LOAD_SHORTCODES_API = true

-- screen orientation
CONFIG_SCREEN_ORIENTATION = "landscape"

-- design resolution
CONFIG_SCREEN_WIDTH  = 960
CONFIG_SCREEN_HEIGHT = 640

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT"


Config = Config or {
    -- displayStats = true,
    -- debugPhysics = true,
    debug = true,
    width = 960,
    height = 640,
    groundHeight = 50,
    pipeDistance = 150,
    pipeInterval = 260,
    pipeCount = 3,
    ghostRadius = 20,
    birdRadius = 20,
    birdLives = 1,
    birdWingVy = {320,360,280},
    scroll = 3,
    gravity = -500,
}
