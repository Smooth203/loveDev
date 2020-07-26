function love.conf(t)
    t.version = '11.3'
    t.console = false

    t.window.title = ''
    t.window.icon = nil
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = true
    t.window.minwidth = 800
    t.window.minheight = 600

    t.modules.audio = true              -- Enable the audio module
    t.modules.data = true               -- Enable the data module
    t.modules.event = true              -- Enable the event module
    t.modules.font = true               -- Enable the font module
    t.modules.graphics = true           -- Enable the graphics module
    t.modules.image = true              -- Enable the image module
    t.modules.joystick = true           -- Enable the joystick module
    t.modules.keyboard = true           -- Enable the keyboard module
    t.modules.math = true               -- Enable the math module
    t.modules.mouse = true              -- Enable the mouse module
    t.modules.physics = true            -- Enable the physics module
    t.modules.sound = true              -- Enable the sound module
    t.modules.system = true             -- Enable the system module
    t.modules.thread = true             -- Enable the thread module
    t.modules.touch = true              -- Enable the touch module
    t.modules.video = true              -- Enable the video module
end