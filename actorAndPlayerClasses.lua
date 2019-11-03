local class = require 'middleclass'
require 'mapAndLighting'
require 'miscSettingsAndFunctions'
require 'healAction'

actor = class('actor') -- actor class
id = 1

function actor:initialize(x, y, viewRadius) -- all actors will have (x,y) co-ordinates
self.x = x * gridMultiplier
self.y = y * gridMultiplier
self.viewRadius = 8 -- 8, usually
self.energy = 0
self.energyThreshold = 1 -- increment -> do action -> decrement -> next actor
self.input = nil
self.id = id
self.health = nil
self.nextToPlayer = nil
self.name = nil
self.damage = nil

-- Add new actor to table of actors
    table.insert(actors, self)
    id = id + 1 -- players will always have id number 1
actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
end

player = class('player', actor) -- player subclass

function player:initialize(x, y)
actor.initialize(self, x, y)
self.name = "Warlock"
self.maxHealth = 20
self.health = 20
self.healthFlasks = 1
self.damage = 5
end

function player:takeAction()
self.energy = self.energy + 1

if self.energy >= self.energyThreshold then
self:getDecision()
FOV()
turncount = turncount + 1
self.energy = self.energy - 1
end
end -- takeAction()

function player:getDecision()
  if self.input == "kp1" then -- lower left diagonal
      if testMap(-1, 1) == true then
      actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
      Warlock.x = Warlock.x - gridMultiplier
      Warlock.y = Warlock.y + gridMultiplier
      actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
      end

  elseif self.input == "kp2" then -- go down
    if testMap(0, 1) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.y = Warlock.y + gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
    end

  elseif self.input == "kp3" then -- lower right diagonal
    if testMap(1, 1) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.x = Warlock.x + gridMultiplier
    Warlock.y = Warlock.y + gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
    end

  elseif self.input == "kp4" then -- left
    if testMap(-1, 0) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.x = Warlock.x - gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
    end

  elseif self.input == "kp5" then -- stay in place, pass a turn
    --if testMap(0, 0) == true then
    --end

  elseif self.input == "kp6" then -- right
    if testMap(1, 0) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.x = Warlock.x + gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
  end

  elseif self.input == "kp7" then -- upper left diagonal
    if testMap(-1, -1) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.x = Warlock.x - gridMultiplier
    Warlock.y = Warlock.y - gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
  end

  elseif self.input == "kp8" then -- up
    if testMap(0, -1) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.y = Warlock.y - gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
  end

  elseif self.input == "kp9" then -- upper right diagonal
    if testMap(1, -1) == true then
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = ""
    Warlock.x = Warlock.x + gridMultiplier
    Warlock.y = Warlock.y - gridMultiplier
    actorMap[self.x / gridMultiplier][self.y / gridMultiplier] = "actor"
  end

elseif self.input == "h" then
  HealAction:playerHeal()
else return false -- if player presses a button not on here, the turn doesn't progress
  end -- end of big if statement with the numpad buttons

  end -- getDecision()

function player:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "@"}, self.x, self.y)
end
