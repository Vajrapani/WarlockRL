local class = require 'middleclass'
require 'mapAndLighting'
require 'miscSettingsAndFunctions'
require 'actorAndPlayerClasses'
astar = require 'astar'

tempX = {}
tempY = {}

monster = class('monster', actor)

function monster:initialize(x, y)
actor.initialize(self, x, y)
end

function monster:takeAction()
self.energy = self.energy + 1

if self.energy >= self.energyThreshold then
self:getDecision()
self.energy = self.energy - 1
end
end -- takeAction()

function monster:getDecision() -- currently monster will just move towards player
self:pathfinding()
end -- getDecision()

function monster:requestPath() -- generate A* star path from current actor (x,y) to player (x,y)
path = astar:find(mapWidth, mapHeight, {x = self.x/gridMultiplier, y = self.y/gridMultiplier}, {x = Warlock.x/gridMultiplier, y = Warlock.y/gridMultiplier}, positionIsOpenFunc)
end

function monster:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "D"}, self.x, self.y)
end

function monster:pathfinding()
self:requestPath()

if path and path[2] ~= nil  then -- if a path exists, change the (x,y) vals of the monster to be the next step
self.x = path[2].x * gridMultiplier
self.y = path[2].y * gridMultiplier
end

end -- pathfinding()
