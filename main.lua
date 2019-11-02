local class = require 'middleclass'
local Gamestate = require 'gamestate'
require 'miscSettingsAndFunctions' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'actorAndPlayerClasses' -- actor superclass and player subclass
require 'monsterClass'
require 'goblin'
astar = require 'astar'

-- ** GLOBALS **
actors = {} -- table gets populated by the actor class as new ones are created
game = {}
menu = {}
turncount = 0


function menu:draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(InconsolataBold)
  love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
    end
end


function game:enter()
  makeMap()
  drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
  Warlock = player:new(Place()) -- Warlock is the player char
  monster1 = goblin:new(Place())
  monster2 = goblin:new(Place())
  monster2 = goblin:new(Place())
  FOV()
end

function game:draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(InconsolataBold)
  drawMap()
  drawActors()
  UserInterface()
end

function game:keypressed(key)
if key == "kp1" or "kp2" or "kp3" or "kp4" or "kp5" or "kp6" or "kp7" or "kp8" or "kp9" then -- only numpad
  Warlock.input = key
  allActorsDoActions()
end
end-- keypressed()

function love.load()
love.window.setTitle("WarlockRL")
Gamestate.registerEvents()
Gamestate.switch(menu)
end
