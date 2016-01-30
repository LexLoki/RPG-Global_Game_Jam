require "player_jumpState"
require "player_walkState"

player = {}

local entryState

function player.load()
  player.maxSpeed = 100
  player.jumpForce = 1000
  player.invTime = 2
end

function player.start()
  player.speed = {x=0, y=0}
  player.x = 0
  player.y = 0
end

function player.update(dt)
  
end

function player.draw()
  
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