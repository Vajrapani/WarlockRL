local class = require 'middleclass'
require 'miscSettingsAndFunctions'

HealAction = class('HealAction')

function HealAction:initialize()
    self.name = 'HealAction'
end

function HealAction:playerHeal()
if Warlock.healthFlasks >= 1 then
  Warlock.health = Warlock.health + 5
  Warlock.healthFlasks = Warlock.healthFlasks - 1
end
end
