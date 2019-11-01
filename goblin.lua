local class = require 'middleclass'
require 'mapAndLighting'
require 'miscSettingsAndFunctions'
require 'actorAndPlayerClasses'
require 'monsterClass'
astar = require 'astar'

goblin = class('goblin', monster)

function goblin:initialize(x, y)
monster.initialize(self, x, y)
self.nextToPlayer = nil
self.name = "goblin"
end

function goblin:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "g"}, self.x, self.y)
end

function goblin:combat()
if self.nextToPlayer == true then--
Warlock.health = Warlock.health - 10 -- replace this with AttackAction:attack when I make the action classes
self:pathfinding()
end
end -- goblin:combat()
