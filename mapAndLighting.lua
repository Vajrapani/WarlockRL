require 'miscSettingsAndFunctions'
local bresenham = require 'bresenham'
--[[
# = wall
. = ground

0 = not visible
1 = visible
]]

map = {} -- map table
isVisible = {} -- lighting table
actorMap = {}
mapGen = false -- while this is false, the map should gen
mapWidth = 35 -- x
mapHeight = 35 -- y

function makeMap()
for x=0, mapWidth+1 do -- makes a map full of walls, before a map generator iterates through it
  for y=0, mapHeight+1 do -- REMEMBER : a '0' row and column is made, along with an extra one at the max val
    map[x] = map[x] or {}
    map[x][y] = "#"
  end
end
end --

for x=0, mapWidth+1 do -- sets the map to be all initially not visible.
  for y=0, mapHeight+1 do
    isVisible[x] = isVisible[x] or {}
    isVisible[x][y] = 0
  end
end

for x=1, mapWidth do -- actor map, "" means empty and not a player or monster is occupying it
  for y=1, mapHeight do
  actorMap[x] = actorMap[x] or {}
    actorMap[x][y] = ""
  end
end

function drawMap()
  for x=1, mapWidth do
    for y=1, mapHeight do
      if isVisible[x][y] == 1 then
      if actorMap[x][y] == "actor" then love.graphics.print({{NormaliseRGB(220, 50, 47)}, ""}, x * gridMultiplier , y * gridMultiplier)
      else love.graphics.print({{NormaliseRGB(181, 137, 0)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) -- 2 less than size of font
    end
  end
    if isVisible[x][y] == 2 then love.graphics.print({{NormaliseRGB(88, 110, 117)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) end
    if isVisible[x][y] == 3 and map[x][y] == "#" then love.graphics.print({{NormaliseRGB(220, 50, 47)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) end
    if isVisible[x][y] == 3 and map[x][y] == "." then love.graphics.print({{NormaliseRGB(88, 110, 117)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) end
end -- end of 1st for
end -- end of 2nd for
end -- drawMap

-- Drunk Walk Algorithm. Replace/Refactor at some point

maxDrunkSteps = (math.floor((mapWidth + mapHeight)/2) * 30) -- number of times the algorithm takes drunk steps

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

-- FOV algorithm, could be made better/more accurate

function FOV()
  for i=1, mapWidth do
    for j=1, mapHeight do
      if isVisible[i][j] == 1 then isVisible[i][j] = 2 end
      local x = i - (Warlock.x / gridMultiplier)
      local y = j - (Warlock.y / gridMultiplier)
      local l = math.floor(math.sqrt((x*x) + (y*y)))
        if l < Warlock.viewRadius then
        if bresenham.los(i, j, Warlock.x/gridMultiplier, Warlock.y/gridMultiplier, function(x, y)
        if (map[x][y] == "#") then return false end return true end) == true then isVisible[i][j] = 1 end

        if map[i][j] == "#" then if checkAdjacent(i, j) == true then isVisible[i][j] = 2 end end

    end
  end
end
rememberedTiles()
end -- FOV()
-- change the wall lighting colour to 3 if you want them to be red again

-- greys out seen tiles
function rememberedTiles()
  for i=1, mapWidth do
    for j=1, mapHeight do
      local x = i - (Warlock.x / gridMultiplier)
      local y = j - (Warlock.y / gridMultiplier)
      local l = math.floor(math.sqrt((x*x) + (y*y)))

      if l > (Warlock.viewRadius) and isVisible[i][j] ~= 0  then isVisible[i][j] = 2 end
    end
  end
end
--

-- checks if walls in the player's view radius are adjacent to a floor tile
--[[
function LightUpAdjacentWalls()
  for i=2, mapWidth-1 do
    for j=2, mapHeight-1 do
      local x = i - (Warlock.x / gridMultiplier)
      local y = j - (Warlock.y / gridMultiplier)
      local l = math.floor(math.sqrt((x*x) + (y*y)))

      if l < (Warlock.viewRadius/2) then
        if map[i][j] == "#" and checkAdjacent(i, j) == true then isVisible[i][j] = 3 end
      end
    end
  end
end -- LightUpAdjacentWalls()
--
]]
function checkAdjacent(x, y)

local right = isVisible[x+1][y+0]
local left = isVisible[x-1][y-0]
local down = isVisible[x+0][y+1]
local up = isVisible[x+0][y-1] -- 4 directions
local lowerRight = isVisible[x+1][y+1]
local lowerLeft = isVisible[x-1][y+1]
local upperRight = isVisible[x+1][y-1]
local upperLeft = isVisible[x-1][y-1]

if right == 1 or left == 1 or down == 1 or up == 1 or lowerRight == 1 or lowerLeft == 1 or upperRight == 1 or upperLeft == 1 then return true else return false end
end

-- testMap function where tileCollision happens
function testMap(x, y) -- should prolly make this less verbose
  local futureX = (Warlock.x/ gridMultiplier) + x
  local futureY = (Warlock.y / gridMultiplier) + y

	if map[futureX][futureY] == "#" then
		return false
  elseif actorMap[futureX][futureY] == "actor" then
    AttackAction:attack(Warlock.name, Warlock.damage, futureX * gridMultiplier, futureY * gridMultiplier)
    return false -- combat function after this ?
  end
  return true
end
