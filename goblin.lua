local class = require 'middleclass'
require 'mapAndLighting'
require 'miscSettingsAndFunctions'
require 'actorAndPlayerClasses'
require 'monsterClass'
require 'attackAction'
astar = require 'astar'

goblin = class('goblin', monster)

function goblin:initialize(x, y)
monster.initialize(self, x, y)
self.nextToPlayer = nil
self.name = "goblin"
self.health = 10
self.monsterLevel = 2
self.damage = (self.monsterLevel) * love.math.random(1, self.monsterLevel)
end

function goblin:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "g"}, self.x, self.y)
end

function goblin:combat()
if self.nextToPlayer == true then
AttackAction:attack(self.name, self.damage, nil, nil)
self:pathfinding()
end
end -- goblin:combat()
