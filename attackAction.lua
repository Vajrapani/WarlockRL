local class = require 'middleclass'
require 'miscSettingsAndFunctions'
require 'messageBox'
require 'mapAndLighting'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(actor, damage, x, y)
  if actor ~= "Warlock" then
  Warlock.health = Warlock.health - damage
  Warlock.isInCombat = true
  MessageBox:insertIntoLog("The " .. actor .. " strikes you!")
  end

  if actor == "Warlock" then
  for actor in ipairs(actors) do
  if actors[actor].x == x and actors[actor].y == y then
  actors[actor].health = actors[actor].health - Warlock.damage
  Warlock.isInCombat = true
  if Warlock.soulPower < Warlock.soulPowerLimit then Warlock.soulPower = Warlock.soulPower + 1 end
  MessageBox:insertIntoLog("Thoth's unstable magic blasts the " .. actors[actor].name .. ", and siphons its soul!")
  if actors[actor].health <= 0 then
    MessageBox:insertIntoLog("You kill the " .. actors[actor].name .. " and capture its soul in a flask!")
    actorMap[x / gridMultiplier][y / gridMultiplier] = "" ; table.remove(actors, actor)
    Warlock.healthFlasks = Warlock.healthFlasks + 1
  end
  end -- if
  end -- for
end -- if
end -- AttackAction:attack(damage)

function AttackAction:sealOfTheWorld()
for actor in ipairs(actors) do
  local x = actors[actor].x
  local y = actors[actor].y
  if actors[actor].name ~= "Warlock" then
    if isVisible[x / gridMultiplier][y / gridMultiplier] == 1 then
        actorMap[x / gridMultiplier][y / gridMultiplier] = "" ; actors[actor] = nil
        Warlock.healthFlasks = Warlock.healthFlasks + 1
    end
end -- if
end -- for
MessageBox:insertIntoLog("You activate the Seal of The World.....")
MessageBox:insertIntoLog("Thoth enacts his judgement! EMBRACE OBLIVION")
MessageBox:insertIntoLog("You capture the souls of the enemies torn asunder.")
end -- AttackAction:sealOfTheWorld()
