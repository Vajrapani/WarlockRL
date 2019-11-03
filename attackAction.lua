local class = require 'middleclass'
require 'miscSettingsAndFunctions'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(actor, damage, x, y)
  if actor ~= "Warlock" then
  Warlock.health = Warlock.health - damage
  Warlock.isInCombat = true
  end

  if actor == "Warlock" then
  for actor in ipairs(actors) do
  if actors[actor].x == x and actors[actor].y == y then
  actors[actor].health = actors[actor].health - Warlock.damage
  Warlock.isInCombat = true
  Warlock.soulPower = Warlock.soulPower + 1
  if actors[actor].health <= 0 then
    table.remove(actors, actor) ; actorMap[x / gridMultiplier][y / gridMultiplier] = ""
    Warlock.healthFlasks = Warlock.healthFlasks + 1
  end
  end -- if
  end -- for
end -- if
end -- AttackAction:attack(damage)
