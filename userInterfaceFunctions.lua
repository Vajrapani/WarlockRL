function UserInterface()
  love.graphics.setFont(InconsolataRegular)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "* W A R L O C K *"}, 37 * gridMultiplier, 1 * gridMultiplier)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "* Turncount : " .. turncount}, 37 * gridMultiplier, 5 * gridMultiplier)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "* Health : " .. Warlock.health .. " / " .. Warlock.maxHealth}, 37 * gridMultiplier, 3 * gridMultiplier)
  --love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Monster Health ] : " .. monster1.health}, 37 * gridMultiplier, 7 * gridMultiplier)
end
