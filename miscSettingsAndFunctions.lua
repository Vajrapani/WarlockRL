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
SourceCodeProRegular = love.graphics.newFont('SourceCodePro-Regular.ttf', fontSize)
SourceCodeProBold = love.graphics.newFont('SourceCodePro-Bold.ttf', fontSize)
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

function drawActors()
  for actor in ipairs(actors) do -- print out all active actors
    if actors[actor].id == 1 then actors[actor]:printToScreen()
    elseif actors[actor].id > 1 then
    if isVisible[actors[actor].x / gridMultiplier][actors[actor].y / gridMultiplier] == 1 then
      actors[actor]:printToScreen()
    end
    end
  end
end

function allActorsDoActions()
  for actor in ipairs(actors) do

            if actors[actor]:takeAction() == true then
                break
            end
        end
  end --
