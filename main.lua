local class = require 'middleclass'
local Gamestate = require 'gamestate'
astar = require 'astar'
require 'miscSettingsAndFunctions' -- misc values and functions that are useful
require 'userInterfaceFunctions'
require 'mapAndLighting' -- anything to do with the map and lighting/FOV

require 'actorAndPlayerClasses' -- actor superclass and player subclass
require 'messageBox'
require 'monsterClass'
require 'goblin'

require 'gameText'
-- ** GLOBALS **
actors = {} -- table gets populated by the actor class as new ones are created
game = {}
menu = {}
weapon = {}
buttons = {"kp1", "kp2","kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "h"}
turncount = 0


function menu:draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(SourceCodeProBold)
  love.graphics.printf({{NormaliseRGB(203, 75, 22)}, "* W A R L O C K *"}, 0, 0 , love.graphics.getWidth(), "center")
  love.graphics.printf({{NormaliseRGB(203, 75, 22)},  OpeningLines}, 0, 30 , love.graphics.getWidth() - 10, "center")
  --love.graphics.print({{NormaliseRGB(203, 75, 22)}, "Press Enter to begin....."}, 10, 100)
end

function menu:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(game)
    end
end


function game:enter()
  makeMap()
  drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
  Feyblade = Feyblade:new()
  Warlock = player:new(Place()) -- Warlock is the player char
  monster1 = goblin:new(Place())
  monster2 = goblin:new(Place())
  monster2 = goblin:new(Place())
  MessageBox = MessageBox:new()
  FOV()
end

function game:draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(InconsolataBold)
  drawMap()
  drawActors()
  UserInterface()
  MessageBox:printToScreen()
end

function game:keypressed(key)
for i,button in ipairs(buttons) do
  if key == button then
  Warlock.input = key
  allActorsDoActions()
  end
end -- for
end-- keypressed()

function love.load()
love.window.setTitle("WarlockRL")
Gamestate.registerEvents()
Gamestate.switch(menu)
end
