menu={}
function menu.load(callback)
  menu.callback = callback
  menu.buttonWidth = 500
  menu.buttonHeight = 150
  menu.buttonColor = {255,0,0}
  menu.selectedColor = {0,255,255}
  menu.buttonXPos = 500
  menu.buttons = {
    {yPos=100, dir = -1 },
    {yPos=300, dir = -1},
    {yPos=500, dir = 1 }
  }
  menu.time = 1
end

function menu.start()
  pressionado = 0
  pausado = true
  for but in menu.buttons do
    but.x = but.xPos
    but.y = but.yPos
  end
  menu.isAnimating = false
  menu.pressionado = 1
end

function menu.update(dt)
  
  if menu.isAnimating then
    for b in menu.buttons do
      menu.timer = menu.timer - dt
      b.x = b.x + menu.vel*dt
      if menu.timer < 0 then
        --CALLBACK GO TO STAGE
      end
    end
  end
end

function menu.startAnimation()
  menu.isAnimating = true
  menu.timer = menu.time
  menu.goTo = menu.buttons[menu.pressionado].dir == 1 and love.graphics.getWidth() or -menu.buttonWidth
  menu.vel = (menu.goTo - menu.buttonXPos)/menu.time
end

function menu.keypressed(key)
  if(key == 'return') and pressionado == 1 then
    menu.callback(game)
    menu.startAnimation()
  elseif(key == "down") then
    menu.pressionado = menu.pressionado%#menu.buttons+1
  elseif(key == "up") then
    local q = #menu.buttons
    menu.pressionado = (menu.pressionado-2+q)%q+1
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
  for i, v in ipairs(menu.buttons) do
    local c = i == menu.pressionado and menu.selectedColor or menu.buttonColor
    love.graphics.rectangle("fill",v.x,v.y,menu.buttonWidth,menu.buttonHeight)
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