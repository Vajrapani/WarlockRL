-- Changes RGB values to the format desired by Love2D. (255, 255 255) = (1, 1, 1)
function NormaliseRGB(r,g,b)
  return r/255, g/255, b/255
end
--

-- font stuff
fontSize = 16
gridMultiplier = fontSize - 2
Inconsolata = love.graphics.newFont('Inconsolata-Bold.ttf', fontSize)
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
