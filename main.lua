local class = require 'middleclass'
require 'miscSettings' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'actorAndPlayerClasses' -- actor superclass and player subclass
require 'monsterClass'
astar = require 'astar'

actors = {} -- table gets populated by the actor class as new ones are created

function love.load()
drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
Warlock = player:new(Place()) -- Warlock is the player char
monster1 = monster:new(Place())
end

function love.update(dt)
  FOV()
end

function love.draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(Inconsolata)
  drawMap()
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "@"}, Warlock.x, Warlock.y)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "N"}, monster1.x, monster1.y)
end


function love.keypressed(key)
if key == "kp1" or "kp2" or "kp3" or "kp4" or "kp5" or "kp6" or "kp7" or "kp8" or "kp9" then -- only numpad
  Warlock.input = key
  for actor in ipairs(actors) do

            if actors[actor]:takeAction() == true then
                break
            end
        end
  end -- end of if key statement
end -- keypressed()
