local class = require 'middleclass'
require 'miscSettingsAndFunctions'

Weapon = class('Weapon')

function Weapon:initialize(name, damageModifier)
    self.name = name
    self.damageModifier = damageModifier
end

Feyblade = class('Feyblade', Weapon)

function Feyblade:initialize()
damageModifier = 1
name = "Feystriker"
Weapon:initialize(name, damageModifier)
end
