function love.conf(t)
  -- Debug
  t.console          = true

  -- Basic window properties
  t.window.title     = 'Love Casper'
  t.window.width     = 800
  t.window.minwidth  = 800
  t.window.height    = 600
  t.window.minheight = 600
  t.window.resizable = true

  -- Unwanted modules
  t.modules.joystick = false
  t.modules.physics  = false
end
