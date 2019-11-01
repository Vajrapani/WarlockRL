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
self.nextToPlayer = nil
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
self:combat()
end -- getDecision()

function monster:requestPath() -- generate A* star path from current actor (x,y) to player (x,y)
path = astar:find(mapWidth, mapHeight, {x = self.x/gridMultiplier, y = self.y/gridMultiplier}, {x = Warlock.x/gridMultiplier, y = Warlock.y/gridMultiplier}, positionIsOpenFunc)
end

function monster:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "M"}, self.x, self.y)
end

function monster:pathfinding()
self:requestPath()

if path and path[2] ~= nil  then -- if a path exists, change the (x,y) vals of the monster to be the next step
actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
local futureX = path[2].x * gridMultiplier
local futureY = path[2].y * gridMultiplier
if actorMap[futureX / gridMultiplier][futureY / gridMultiplier] ~= "actor" then
self.x = futureX
self.y = futureY
self.nextToPlayer = false
elseif actorMap[futureX / gridMultiplier][futureY / gridMultiplier] == "actor" and futureX == Warlock.x and futureY == Warlock.y then self.nextToPlayer = true
end

actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
end -- if statement

end -- pathfinding()

function monster:combat()
if self.nextToPlayer == true then--
Warlock.health = Warlock.health - 10 -- replace this with AttackAction:attack
self:pathfinding()
end

end
