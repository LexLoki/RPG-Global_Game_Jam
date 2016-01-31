require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"

enemie_dog = {}

local entryState

function enemie_dog.load()
  
  enemie_dog.x = 800
  enemie_dog.y = 400
  enemie_dog.width = 64
  enemie_dog.height = 30
  enemie_dog.speedx = 0
  enemie_dog.speedy = 0
  enemie_dog.sight = 500
  
  enemie_dog.gravity = 1100
  
  enemie_dog.name = "dog"
  enemie_dog.is_jumper = true
  
  enemie_dog.dir = 0
  enemie_dog.maxSpeed = 100
  enemie_dog.invTime = 2
  enemie_dog.gravity = 1100
  enemie_jumpState.load(500)
  
  enemie_dog.state = enemie_walkState
  enemie_dog.jump_time = 0.3
  enemie_dog.timer_jump = 0
  
  enemie_dog.dir_time = 0.8
  enemie_dog.timer_dir = 0
  
  end

function enemie_dog.start()
  enemie_dog.x = 400
  enemie_dog.y = 418

  enemie_dog.state = enemie_walkState
end

function enemie_dog.update(dt)
  
  enemie_dog.speedy = enemie_dog.speedy + enemie_dog.gravity*dt
  enemie_dog.timer_dir = enemie_dog.timer_dir + dt
  
  if math.abs(player.x - enemie_dog.x) <= enemie_dog.sight then
    
    if enemie_dog.timer_dir > enemie_dog.dir_time then
      enemie_dog.timer_dir = 0
      
      if player.x > enemie_dog.x then
        enemie_dog.dir = 1
      else 
        enemie_dog.dir = -1
      end
    end
    
    if enemie_dog.is_jumper then
      if (player.y + player.height + 20) < enemie_dog.y + enemie_dog.height then
         -- enemie_dog.speedy = -700
        enemie_dog.timer_jump = enemie_dog.timer_jump + dt
        if enemie_dog.timer_jump > enemie_dog.jump_time then
          enemie_dog.jump()
        end
      else
        enemie_dog.timer_jump = 0.0
      end
    end

  else
    if enemie_dog.timer_dir > enemie_dog.dir_time then
      enemie_dog.timer_dir = 0
      enemie_dog.dir = 0
    end
  end
  
  if  enemie_dog.dir == 1 then
    enemie_dog.speedx = enemie_dog.maxSpeed
  elseif  enemie_dog.dir == -1 then 
    enemie_dog.speedx = -enemie_dog.maxSpeed
  else
    enemie_dog.speedx = 0
  end

  enemie_dog.state.update(enemie_dog, dt)
end


function enemie_dog.draw()
  local c = mapManager.camera

  love.graphics.setColor(255,0,255)
  love.graphics.rectangle("fill",enemie_dog.x-c.pos_x,enemie_dog.y-c.pos_y,enemie_dog.width,enemie_dog.height)
  love.graphics.setColor(255,255,255)
  love.graphics.print(enemie_dog.name, (enemie_dog.x + enemie_dog.width/2) - c.pos_x, (enemie_dog.y + enemie_dog.height/2) - c.pos_y)
  
end

function enemie_dog.jump()
  --... do something maybe
  entryState(enemie_jumpState)
end

function enemie_dog.reachFloor()
  enemie_dog.speedy = 0
  if enemie_dog.state ~= enemie_dog_walkState then
    entryState(enemie_walkState)
  end
end


function entryState(state)
  enemie_dog.state.exit(enemie_dog)
  enemie_dog.state = state
  enemie_dog.state.start(enemie_dog)
end