local class = require 'middleclass'
require 'miscSettings' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'classes' -- all classes

actors = {} -- table gets populated by the actor class as new ones are created

function love.load()
drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
Warlock = player:new(Place()) -- Warlock is the player char
end

function love.update(dt)
  FOV()
end

function love.draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(Inconsolata)
  drawMap()
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "@"}, Warlock.x, Warlock.y)
end

-- input handling, HIGH priority to clean up


function love.keypressed(key)
if key == "kp1" or "kp2" or "kp3" or "kp4" or "kp5" or "kp6" or "kp7" or "kp8" or "kp9" then -- only numpad
  Warlock.input = key
  Warlock:takeAction()
  end
end
