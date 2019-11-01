-- Changes RGB values to the format desired by Love2D. (255, 255 255) = (1, 1, 1)
function NormaliseRGB(r,g,b)
  return r/255, g/255, b/255
end
--

-- font stuff
fontSize = 16
gridMultiplier = fontSize - 2
InconsolataBold = love.graphics.newFont('Inconsolata-Bold.ttf', fontSize)
InconsolataRegular = love.graphics.newFont('Inconsolata-Regular.ttf', fontSize)
--

-- colours
solarizedBackground = NormaliseRGB(0,43,54)
solarizedRed = NormaliseRGB(220, 50, 47)
solarizedOrange = NormaliseRGB(203, 75, 22)
--

-- Place something in a random, empty x and y position

function Place() -- 500 tries to place the player the player in a random, empty (x,y) spot
for d=1, 100 do
local randomX = love.math.random(1,mapWidth)
local randomY = love.math.random(1, mapHeight)
if map[randomX][randomY] == "." then return randomX, randomY end
end
end -- Place()

-- returns true if an (x,y) position is walkable, false otherwise

function positionIsOpenFunc (x, y)
    -- should return true if the position is open to walk
    if map[x][y] == "." then -- . is ground, so it's walkable
    return true
    end
    return false
end --positionIsOpenFunc()


function UI()
  love.graphics.setFont(InconsolataRegular)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ W A R L O C K ]"}, 37 * gridMultiplier, 1 * gridMultiplier)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Turncount ] : " .. turncount}, 37 * gridMultiplier, 3 * gridMultiplier)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Warlock Health ] : " .. Warlock.health}, 37 * gridMultiplier, 5 * gridMultiplier)
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "[ Monster Health ] : " .. monster1.health}, 37 * gridMultiplier, 7 * gridMultiplier)
end
