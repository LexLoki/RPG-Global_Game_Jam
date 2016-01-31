require "mathUtils"

player_walkState = {}


function player_walkState.load()
  
end

function player_walkState.start()
  player.curr_sprite = player.walk
end

function player_walkState.exit()
  
end

function player_walkState.update(dt)
  timer_jump = timer_jump + dt
  if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
    player.speedx = player.maxSpeed*math.absSign(player.speedx)*2
  end
  if (timer_jump >= 5.0) then
    timer_jump = 0
    player.jump()
  end
end
function player_walkState.draw()
  
end

function player_walkState.keypressed(key)
  
end
function player_walkState.keyreleased(key)
  
end