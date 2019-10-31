local class = require 'middleclass'
require 'mapAndLighting'
require 'miscSettings'

actor = class('actor') -- actor class

function actor:initialize(x, y, viewRadius) -- all actors will have (x,y) co-ordinates
self.x = x
self.y = y
self.viewRadius = 8
end

player = class('player', actor) -- player subclass

function player:initialize(x, y)
actor.initialize(self, x, y, 8)
end
