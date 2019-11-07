local class = require 'middleclass'
require 'miscSettingsAndFunctions'

MessageBox = class('MessageBox')

function MessageBox:initialize()
    self.messages = {}
end

function MessageBox:insertIntoLog(line)
table.insert(self.messages, "[ Turn : " .. turncount .. " ] " .. line)
end

-- message log should start at x = 1 * gridMultiplier and y = 36 * gridMultiplier
function MessageBox:printToScreen()
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Log ]"}, 1 * gridMultiplier, 36 * gridMultiplier)
love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Current Turn : ".. turncount .. " ] "}, 1 * gridMultiplier, 37 * gridMultiplier)
love.graphics.print({{NormaliseRGB(203, 75, 22)}, self.messages[#self.messages - 2]}, 1 * gridMultiplier, 38 * gridMultiplier)
love.graphics.print({{NormaliseRGB(203, 75, 22)}, self.messages[#self.messages - 1]}, 1 * gridMultiplier, 39 * gridMultiplier)
love.graphics.print({{NormaliseRGB(203, 75, 22)}, self.messages[#self.messages]}, 1 * gridMultiplier, 40 * gridMultiplier)
end
