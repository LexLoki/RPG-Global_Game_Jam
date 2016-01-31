enemie_jumpState = {}


function enemie_jumpState.load()
  enemie_jumpState.jumpForce = -700
end

function enemie_jumpState.start()
  enemie.speedy = enemie_jumpState.jumpForce
end

function enemie_jumpState.exit()
  
end

function enemie_jumpState.update(dt)
end

function enemie_jumpState.draw()
  
end

function enemie_jumpState.keypressed(key)
end
function enemie_jumpState.keyreleased(key)
  
end