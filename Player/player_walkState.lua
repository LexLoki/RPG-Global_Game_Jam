player_walkState = {}


function player_walkState.load()
  
end

function player_walkState.start()
  
end

function player_walkState.exit()
  
end

function player_walkState.update(dt)
  timer_jump = timer_jump + dt
  if (timer_jump >= 5.0) then
    player.jump()
  end
  if(love.keyboard.isDown("shift")) then
    player.speedx = 1000
  end
end
function player_walkState.draw()
  
end

function player_walkState.keypressed(key)
  
end
function player_walkState.keyreleased(key)
  
end