require "Player/player_jumpState"
require "Player/player_walkState"

player = {}

local entryState

function player.load()
  player.maxSpeed = 100
  player.jumpForce = -700
  player.invTime = 2
  gravity = 1100
end

function player.start()
  player.speedx = 100
  player.speedy = 100
  player.x = 100
  player.y = 100
  player.dir = 1
  player.state = player_walkState
end

function player.update(dt)
  player.y = player.y + player.speedy*dt --+ gravity*(dt)/2
  player.speedy = player.speedy + gravity*dt
  if(love.keyboard.isDown("right")) then
    player.dir = 1
    player.x = player.x + (player.speedx)*player.dir*dt
  end
  if(love.keyboard.isDown("left")) then
    player.dir = -1
    player.x = player.x + (player.speedx)*player.dir*dt
  end
  if player.y > 600 then
    player.y = 600
  end
end

function player.draw()
  if(player.x == nil) or (player.y == nil) then
    player.x = 100
    player.y = 600
  end
  love.graphics.rectangle("fill",player.x,player.y,64,96)
end

function player.jump()
  --... do something maybe
  entryState(player_jumpState)
end
function player.reachFloor()
  --.. do something maybe
  entryState(player_walkState)
end

function player.keypressed(key)
  player.state.keypressed(key)
end

function player.keyreleased(key)
  
end

function entryState(state)
  player.state.exit()
  player.state = state
  player.state.start()
end