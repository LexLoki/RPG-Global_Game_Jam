require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"

enemie = {}

local entryState

function enemie.load()
  
  enemie.x = 400
  enemie.y = 400
  enemie.width = 64
  enemie.height = 96
  enemie.speedx = 0
  enemie.speedy = 0
  enemie.sight = 200
  
  enemie.gravity = 1100
  
  enemie.name = "eu"
  enemietype = 3
  
  enemie.maxSpeed = 80
  enemie.invTime = 2
  enemie.gravity = 1100
  enemie_jumpState.load()
  
  enemie.dir = 1
  enemie.state = enemie_walkState
  enemie.jump_time = 5.0
  timer_jump = 0

  
  end

function enemie.start()
  enemie.x = 400
  enemie.y = 418

  enemie.dir = 1
  enemie.state = enemie_walkState
  enemie.jump_time = 5.0
  timer_jump = 0

end

function enemie.update(dt)
  enemie.check(enemietype)
  
  if enemietype == 3 then
      enemie.speedy = enemie.speedy + enemie.gravity*dt
  end
  
  if math.abs(player.x - enemie.x) <= enemie.sight then
    
    if player.x > enemie.x then
      enemie.speedx = enemie.maxSpeed
    else 
      enemie.speedx = -enemie.maxSpeed
    end
  
    if enemietype == 3 then
      
      if (player.y + player.height + 20) < enemie.y + enemie.height then
         -- enemie.speedy = -700
         enemie.jump();
      end
    end

  else
        enemie.speedx = 0
  end
  
  enemie.state.update(dt)
end


function enemie.draw()
  love.graphics.setColor(255,0,255)
  love.graphics.rectangle("fill", enemie.x, enemie.y, enemie.width, enemie.height)
  love.graphics.setColor(255,255,255)
  love.graphics.print(enemie.name .. " " .. enemietype, enemie.x + enemie.width/2, enemie.y + enemie.height/2)
  
end

function enemie.check(enemietype)
  if enemietype == 1 then
    enemie.maxSpeed = 120
    enemie.sight = 200
  elseif enemietype == 2 then
    enemie.maxSpeed = 80 
    enemie.sight = 300
  elseif enemietype == 3 then 
    enemie.maxSpeed = 80 
    enemie.sight = 180
  end
end

function enemie.jump()
  --... do something maybe
  entryState(enemie_jumpState)
end
function enemie.reachFloor()
  enemie.speedy = 0
  if enemie.state ~= enemie_walkState then
    entryState(enemie_walkState)
  end
end


function entryState(state)
  enemie.state.exit()
    enemie.state = state
    enemie.state.start()
end