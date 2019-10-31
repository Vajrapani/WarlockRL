require 'miscSettings'
--[[
# = wall
. = ground

0 = not visible
1 = visible
]]

map = {} -- map table
isVisible = {} -- lighting table
mapGen = false -- while this is false, the map should gen
mapWidth = 30 -- x
mapHeight = 30 -- y

for x=1, mapWidth do -- makes a map full of walls, before a map generator iterates through it
  for y=1, mapHeight do
    map[x] = map[x] or {}
    map[x][y] = "#"
  end
end

for x=1, mapWidth do -- sets the map to be all initially not visible.
  for y=1, mapHeight do
    isVisible[x] = isVisible[x] or {}
    isVisible[x][y] = "0"
  end
end

function drawMap()
  for x=1, mapWidth do
    for y=1, mapHeight do
      --if isVisible[x][y] == 0 then
      love.graphics.print({{NormaliseRGB(220, 50, 47)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) -- 2 less than size of font
    --end
  end
end
end -- drawMap

-- Drunk Walk Algorithm. Replace/Refactor at some point

maxDrunkSteps = (math.floor((mapWidth + mapHeight)/2) * 20) -- number of times the algorithm takes drunk steps

drunkX = love.math.random(1, (mapWidth - 3))
drunkY = love.math.random(1, (mapHeight - 3)) -- initial (x,y) position that the drunk walk algorithm starts on

function drunkWalk()

if mapGen == false then
map[drunkX][drunkY] = "."
for d=1, maxDrunkSteps do
  drunkX = drunkX + love.math.random(-1, 1)
  drunkY = drunkY + love.math.random(-1, 1)
  if drunkX >= (mapWidth-3) then
  drunkX = drunkX - 2
elseif drunkY >= (mapHeight-3) then
  drunkY = drunkY - 2
elseif drunkX <= 3 then
  drunkX = drunkX + 2
elseif drunkY <= 3 then
  drunkY = drunkY + 2
  end
  map[drunkX][drunkY] = "."
end
mapGen = true
end
end -- drunkWalk()
