local class = require 'middleclass'
require 'miscSettings' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'classes' -- all classes

function love.load()
drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
Warlock = player:new(Place()) -- Warlock is the player char
end

function love.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(Inconsolata)
  drawMap()
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "@"}, Warlock.x * gridMultiplier, Warlock.y * gridMultiplier)
end
