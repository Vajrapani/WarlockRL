local class = require 'middleclass'
require 'miscSettings' -- misc values and functions that are useful
require 'mapAndLighting' -- anything to do with the map and lighting/FOV
require 'classes' -- all classes

function love.load()
actors = {} -- first actor should always be the player (Warlock)
drunkWalk() -- Generates a cave-like map by using the drunk walk algorithm
Warlock = player:new(Place()) -- Warlock is the player char
table.insert(actors, Warlock) -- so actor[1] = {x = something, y = something , viewRadius = 8}
end

function love.update(dt)
  FOV()
end

function love.draw()
  love.graphics.setBackgroundColor(NormaliseRGB(0,43,54)) -- Solarized Base
  love.graphics.setFont(Inconsolata)
  drawMap()
  love.graphics.print({{NormaliseRGB(203, 75, 22)}, "@"}, Warlock.x, Warlock.y)
end

-- input handling, HIGH priority to clean up


function love.keypressed(key)
  if key == "8" or key == "kp8" then  -- go up
  if testMap(0, -1) == true then
  Warlock.y = Warlock.y - gridMultiplier
  end


elseif key == "4" or key == "kp4" then -- go left

  if testMap(-1, 0) == true then
  Warlock.x = Warlock.x - gridMultiplier
  end

elseif key == "5" or key == "kp5" then -- stay in place

  if testMap(0, 0) == true then
  --Warlock.x = Warlock.x - gridMultiplier
  end

elseif key == "7" or key == "kp7" then -- upper left diagonal

  if testMap(-1, -1) == true then
  Warlock.x = Warlock.x - gridMultiplier
  Warlock.y = Warlock.y - gridMultiplier
  end

elseif key == "2" or key == "kp2" then -- go down

  if testMap(0, 1) == true then
  Warlock.y = Warlock.y + gridMultiplier
  end

elseif key == "6" or key == "kp6" then -- go right

  if testMap(1, 0) == true then
  Warlock.x = Warlock.x + gridMultiplier
  end

elseif key == "9" or key == "kp9" then -- upper right diagonal

  if testMap(1, -1) == true then
  Warlock.x = Warlock.x + gridMultiplier
  Warlock.y = Warlock.y - gridMultiplier
  end

elseif key == "1" or key == "kp1" then -- lower left diagonal

  if testMap(-1, 1) == true then
  Warlock.x = Warlock.x - gridMultiplier
  Warlock.y = Warlock.y + gridMultiplier
  end

elseif key == "3" or key == "kp3" then -- lower right diagonal

  if testMap(1, 1) == true then
  Warlock.x = Warlock.x + gridMultiplier
  Warlock.y = Warlock.y + gridMultiplier
 end

end
end
