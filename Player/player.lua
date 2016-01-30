require "Player/player_jumpState"
require "Player/player_walkState"

player = {}

local entryState

function player.load()
  player.maxSpeed = 200
  player.invTime = 2
  player.gravity = 1100
  player_jumpState.load()
end

function player.start()
  player.speedx = 0
  player.speedy = 0
  player.x = 100
  player.y = 100
  player.width = 64
  player.height = 128
  player.dir = 1
  player.state = player_walkState
  player.jump_time = 5.0
  timer_jump = 0
end

function player.update(dt)
  --player.y = player.y + player.speedy*dt
  player.speedy = player.speedy + player.gravity*dt
  if(love.keyboard.isDown("right")) then
    player.speedx = player.maxSpeed
  elseif(love.keyboard.isDown("left")) then
    player.speedx = -player.maxSpeed
  else
    player.speedx = 0
  end
  player.state.update(dt)
end

function player.draw()
  if(player.x == nil) or (player.y == nil) then
    player.x = 100
    player.y = 600
  end
  love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
end

function player.jump()
  --... do something maybe
  entryState(player_jumpState)
end
function player.reachFloor()
  player.speedy = 0
  if player.state ~= player_walkState then
    entryState(player_walkState)
  end
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