require "dialog"
game = {}

local testeFunction

function game.load()
  player.load()
end

function game.start()
  player.start()
end

function game.keypressed(dt)
  
end

function game.update(dt)
  player.update(dt)
end

function game.draw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  love.graphics.setColor(255,0,0)
  --love.graphics.rectangle("fill", w/4, h/4, w/2, h/2)
  testFunction()
  player.draw()
  love.graphics.setColor(255,255,255)
end

function testFunction()
  local floor = 600
  local pos = 100
  --love.graphics.rectangle("fill",pos,floor-32,32,32)
  pos = pos + 32 + 20
  --love.graphics.rectangle("fill",pos,floor-64,64,64)
  pos = pos + 64 + 20
  --love.graphics.rectangle("fill",player.x,player.y,64,96)
  pos = pos + 64 + 20
  --love.graphics.rectangle("fill",pos,floor-128,128,128)
end