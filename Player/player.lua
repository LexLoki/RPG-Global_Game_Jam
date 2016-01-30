require "Player/player_jumpState"
require "Player/player_walkState"

player = {}

local entryState

function player.load()
  player.maxSpeed = 100
  player.jumpForce = 1000
  player.invTime = 2
end

function player.start()
  player.speedx = 100
  player.speedy = 100
  player.x = 100
  player.y = 600
  player.dir = 1
end

function player.update(dt)
  if(love.keyboard.isDown("right")) then
    player.dir = 1
    player.x = player.x + (player.speedx)*player.dir*dt
  end
  if(love.keyboard.isDown("left")) then
    player.dir = -1
    player.x = player.x + (player.speedx)*player.dir*dt
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
  
end

function player.keyreleased(key)
  
end

function entryState(state)
  player.curr_state.exit()
  player.curr_state = state
  player.curr_state.start()
end