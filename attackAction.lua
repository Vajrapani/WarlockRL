local class = require 'middleclass'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(damage)
for actor in ipairs(actors) do
if actors[actor].nextToPlayer == true then
  Warlock.health = Warlock.health - damage
end -- if
end -- for
end -- AttackAction:attack(damage)
