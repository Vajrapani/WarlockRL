require 'miscSettingsAndFunctions'
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

for x=1, mapWidth do -- actor map, "" means empty and not a player or monster is occupying it
  for y=1, mapHeight do
  actorMap[x] = actorMap[x] or {}
    actorMap[x][y] = ""
  end
end

function drawMap()
  for x=1, mapWidth do
    for y=1, mapHeight do
      --if isVisible[x][y] == 1 then
      if actorMap[x][y] == "actor" then love.graphics.print({{NormaliseRGB(220, 50, 47)}, ""}, x * gridMultiplier , y * gridMultiplier)
      else love.graphics.print({{NormaliseRGB(220, 50, 47)}, map[x][y]}, x * gridMultiplier , y * gridMultiplier) -- 2 less than size of font
    --end
  end
  end
end
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
      --isVisible[i][j] = 0 -- 0 = not visible, populate table first
      local x = i - (Warlock.x / gridMultiplier)
      local y = j - (Warlock.y / gridMultiplier)
      local l = math.floor((x*x) + (y*y))

      if (l < Warlock.viewRadius) --[[and map[i][j] ~= "#"]] then
        isVisible[i][j] = 1 -- 1 = visible
    end
  end
end
end -- FOV()

-- testMap function where tileCollision happens
function testMap(x, y) -- should prolly make this less verbose
  local futureX = (Warlock.x/ gridMultiplier) + x
  local futureY = (Warlock.y / gridMultiplier) + y

	if map[futureX][futureY] == "#" then
		return false
  elseif actorMap[futureX][futureY] == "actor" then
    return false -- combat function after this ?
  end
  return true
end


--[[function isMonster(x, y)
  local futureX = (Warlock.x/ gridMultiplier) + x
  local futureY = (Warlock.y / gridMultiplier) + y

  for actor in ipairs(actors) do
  if futureX == (actors[actor].x / gridMultiplier) and futureY == (actors[actor].y / gridMultiplier) then
  return true
  end -- if
  end -- for loop

end -- isMonster()
]]
