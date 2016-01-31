enemie_jumpState = {}


function enemie_jumpState.load()
  enemie_jumpState.jumpForce = -700
end

function enemie_jumpState.start(entity)
  entity.speedy = enemie_jumpState.jumpForce
end

function enemie_jumpState.exit(entity)
  
end

function enemie_jumpState.update(entity, dt)
  
end
