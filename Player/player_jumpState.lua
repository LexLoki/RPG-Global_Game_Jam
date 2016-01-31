player_jumpState = {}


function player_jumpState.load()
  player_jumpState.jumpForce = -700
end

function player_jumpState.start()
  audio.playPlayerJump()
  player.speedy = player_jumpState.jumpForce
  player.fastJump = math.abs(player.speedx)>player.maxSpeed
  player.curr_sprite = player.jumpS
  animationManager_restart(player.curr_sprite.aComp)
end

function player_jumpState.exit()
  
end

function player_jumpState.update(dt)
  print(player.fastJump)
  if player.fastJump then
    player.speedx = player.maxSpeed*math.absSign(player.speedx)*2
  end
  attack.update_damage(dt)
  animationManager_update(dt,player.curr_sprite.aComp)
end

function player_jumpState.draw()
  
end

function player_jumpState.keypressed(key)
end

function player_jumpState.keyreleased(key)
  
end