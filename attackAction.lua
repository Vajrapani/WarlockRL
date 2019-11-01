local class = require 'middleclass'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(actor, damage)
  if actor ~= "Warlock" then
  Warlock.health = Warlock.health - damage
  end
end -- AttackAction:attack(damage)
