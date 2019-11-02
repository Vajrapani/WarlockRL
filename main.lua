local class = require 'middleclass'
require 'miscSettingsAndFunctions' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'actorAndPlayerClasses' -- actor superclass and player subclass
require 'monsterClass'
require 'goblin'
astar = require 'astar'

actors = {} -- table gets populated by the actor class as new ones are created
turncount = 0

function love.load()
love.window.setTitle("WarlockRL")
drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
Warlock = player:new(Place()) -- Warlock is the player char
monster1 = goblin:new(Place())
monster2 = goblin:new(Place())
monster2 = goblin:new(Place())
FOV()
end

function love.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(InconsolataBold)
  drawMap()
  for actor in ipairs(actors) do -- print out all active actors
    if actors[actor].id == 1 then actors[actor]:printToScreen()
    elseif actors[actor].id > 1 then
    if isVisible[actors[actor].x / gridMultiplier][actors[actor].y / gridMultiplier] == 1 then
      actors[actor]:printToScreen()
    end
    end
  end
  UI()
end


function love.keypressed(key)
if key == "kp1" or "kp2" or "kp3" or "kp4" or "kp5" or "kp6" or "kp7" or "kp8" or "kp9" then -- only numpad
  Warlock.input = key
  --if Warlock:getDecision() ~= false then
  for actor in ipairs(actors) do

            if actors[actor]:takeAction() == true then
                break
            end
        end
  end -- end of if key statement
--end
end-- keypressed()
