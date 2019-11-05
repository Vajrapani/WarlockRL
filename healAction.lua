local class = require 'middleclass'
require 'miscSettingsAndFunctions'

HealAction = class('HealAction')

function HealAction:initialize()
    self.name = 'HealAction'
end

function HealAction:playerHeal()
if Warlock.healthFlasks >= 1 then
  Warlock.health = Warlock.health + love.math.random(10, 20)
  if Warlock.health > Warlock.maxHealth then Warlock.health = Warlock.maxHealth end
  Warlock.healthFlasks = Warlock.healthFlasks - 1
end
end
