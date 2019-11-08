local class = require 'middleclass'
require 'miscSettingsAndFunctions'

Weapon = class('Weapon')

function Weapon:initialize(name, damageModifier)
    self.name = name
    self.damageModifier = damageModifier
end

BookOfThoth = class('BookOfThoth', Weapon)

function BookOfThoth:initialize()
damageModifier = 0
name = "Book of Thoth"
Weapon:initialize(name, damageModifier)
end
