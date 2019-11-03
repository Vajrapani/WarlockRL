local class = require 'middleclass'
require 'miscSettingsAndFunctions'

Weapon = class('Weapon')

function Weapon:initialize(name, damageModifier)
    self.name = name
    self.damageModifier = damageModifier
end

Feyblade = class('Feyblade', Weapon)

function Feyblade:initialize()
damageModifier = 10
name = "+" .. damageModifier .. " Feyblade"
Weapon:initialize(name, damageModifier)
end
