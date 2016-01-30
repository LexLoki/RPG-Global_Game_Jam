menu={}
function menu.load(callback)
  menu.callback = callback
end

function menu.start()
  pressionado = 0
  pausado = true
end

function menu.update(dt)
  
end
function menu.keypressed(key)
  if(key == 'return') and pressionado == 1 then
    menu.callback(game)
  end
  
  if(key == "down") then
    if pressionado == 0 then
      pressionado = 1
    elseif pressionado == 1 then
      pressionado = 2
    elseif pressionado == 2 then
      pressionado = 3
    else
      pressionado = 1
    end
  end
  
  if(key == "up") then
    if pressionado == 0 then
      pressionado = 3
    elseif pressionado == 3 then
      pressionado = 2
    elseif pressionado == 2 then
      pressionado = 1
    else
      pressionado = 3
    end
  end
end
function menu.draw()
  local x, y = love.mouse.getPosition()
  love.graphics.rectangle("fill", 500, 100, 500, 150)
  love.graphics.setColor(255, 0, 0)
  if pressionado == 1 then 
    love.graphics.setColor(0, 255, 255)
  end
  love.graphics.rectangle("fill", 500, 300, 500, 150)
  love.graphics.setColor(255, 0, 0)
  if pressionado == 2 then
    love.graphics.setColor(0, 255, 255)
  end
  love.graphics.rectangle("fill", 500, 500, 500, 150)
  love.graphics.setColor(255, 0, 0)
  if pressionado == 3 then
    love.graphics.setColor(0, 255, 255)
  end
end