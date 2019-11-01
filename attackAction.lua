local class = require 'middleclass'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(actor, damage, x, y)
  if actor ~= "Warlock" then
  Warlock.health = Warlock.health - damage
  end

  if actor == "Warlock" then
  for actor in ipairs(actors) do
  if actors[actor].x == x and actors[actor].y == y then
  actors[actor].health = actors[actor].health - Warlock.damage
  end -- if
  end -- for
end -- if
end -- AttackAction:attack(damage)
