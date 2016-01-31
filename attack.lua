attack = {}

function attack.load()
  attack.width = 50
  attack.height = 50
  attack.damage = false
  attack.ing = false
  timer_punch = 0
end
function attack.start()
  attack.x = 0
  attack.y = 0
  attack.width = 50
  attack.height = 50
  attack.damage = false
  attack.ing = false
  timer_punch = 0
end
function attack.update(dt)
  attack.x = player.x + player.width/2
  attack.y = player.y + player.height/2
  timer_punch = timer_punch + dt
  if (timer_punch >= 3.5) then
    attack.ing = true
    timer_punch = 0
  end
--[[if(CheckBoxCollision(attack.x,attack.y,attack.width,attack.height,enemie.x,enemie.y,64,96)) and attack.ing then
    attack.damage = true 
  end]]
end
function attack.draw()
  local c = mapManager.camera
  love.graphics.rectangle("line", attack.x-c.pos_x, attack.y-c.pos_y, attack.width, attack.height)
  love.graphics.print(tostring(attack.ing), 200, 300)
end
function attack.keypressed(key)
  
end

function attack.keyreleased(key)
  
end
function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end