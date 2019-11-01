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
self.damage = 1
self.health = 10
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
