require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"

enemie_human = {}

local entryState

function enemie_human.load()
  
  enemie_human.x = 500
  enemie_human.y = 200
  enemie_human.width = 64
  enemie_human.height = 128
  enemie_human.speedx = 0
  enemie_human.speedy = 0
  enemie_human.sight = 180
  
  enemie_human.gravity = 1100
  
  enemie_human.name = "human"
  enemie_human.is_jumper = false
  
  enemie_human.maxSpeed = 50
  enemie_human.invTime = 2
  enemie_human.gravity = 1100
  enemie_jumpState.load(300)
  
  enemie_human.state = enemie_walkState
  enemie_human.jump_time = 0.3
  enemie_human.timer_jump = 0

  enemie_human.dir_time = 0.8
  enemie_human.timer_dir = 0
  
  
  end

function enemie_human.start()
  enemie_human.x = 400
  enemie_human.y = 418

  enemie_human.state = enemie_walkState
end


function enemie_human.update(dt)
  
  enemie_human.speedy = enemie_human.speedy + enemie_human.gravity*dt
  enemie_human.timer_dir = enemie_human.timer_dir + dt
  
  if math.abs(player.x - enemie_human.x) <= enemie_human.sight then
    
    if enemie_human.timer_dir > enemie_human.dir_time then
      enemie_human.timer_dir = 0
      
      if player.x > enemie_human.x then
        enemie_human.dir = 1
      else 
        enemie_human.dir = -1
      end
    end
    
    if enemie_human.is_jumper then
      if (player.y + player.height + 20) < enemie_human.y + enemie_human.height then
         -- enemie_human.speedy = -700
        enemie_human.timer_jump = enemie_human.timer_jump + dt
        if enemie_human.timer_jump > enemie_human.jump_time then
          enemie_human.jump()
        end
      else
        enemie_human.timer_jump = 0.0
      end
    end

  else
    if enemie_human.timer_dir > enemie_human.dir_time then
      enemie_human.timer_dir = 0
      enemie_human.dir = 0
    end
  end
  
  if  enemie_human.dir == 1 then
    enemie_human.speedx = enemie_human.maxSpeed
  elseif  enemie_human.dir == -1 then 
    enemie_human.speedx = -enemie_human.maxSpeed
  else
    enemie_human.speedx = 0
  end

  enemie_human.state.update(enemie_human, dt)
end


function enemie_human.draw()
  local c = mapManager.camera

  love.graphics.setColor(255,0,255)
  love.graphics.rectangle("fill",enemie_human.x-c.pos_x,enemie_human.y-c.pos_y,enemie_human.width,enemie_human.height)
  love.graphics.setColor(255,255,255)
  love.graphics.print(enemie_human.name, (enemie_human.x + enemie_human.width/2) - c.pos_x, (enemie_human.y + enemie_human.height/2) - c.pos_y)
  
end

function enemie_human.jump()
  --... do something maybe
  entryState(enemie_jumpState)
end

function enemie_human.reachFloor()
  enemie_human.speedy = 0
  if enemie_human.state ~= enemie_walkState then
    entryState(enemie_walkState)
  end
end


function entryState(state)
  enemie_human.state.exit(enemie)
  enemie_human.state = state
  enemie_human.state.start(enemie)
end