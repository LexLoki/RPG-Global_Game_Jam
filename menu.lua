menu={}
function menu.load()
  menu.buttonWidth = 500
  menu.buttonHeight = 150
  menu.buttonColor = {255,0,0,255}
  menu.selectedColor = {0,255,255,255}
  menu.buttonXPos = 500
  menu.buttons = {
    {yPos=100, dir = -1 },
    {yPos=300, dir = -1},
    {yPos=500, dir = 1 }
  }
  menu.time = 1
end

function menu.start()
  for i,but in ipairs(menu.buttons) do
    but.x = menu.buttonXPos
    but.y = but.yPos
  end
  menu.isAnimating = false
  menu.pressionado = 1
end

function menu.update(dt)
  if menu.isAnimating then
    for i,b in ipairs(menu.buttons) do
      menu.timer = menu.timer - dt
      b.x = b.x + menu.vel*dt
      if menu.timer < 0 then
        game.goToStage()
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
  if(key == 'return') then
    menu.startAnimation()
  elseif(key == "down") then
    menu.pressionado = menu.pressionado%#menu.buttons+1
  elseif(key == "up") then
    local q = #menu.buttons
    menu.pressionado = (menu.pressionado-2+q)%q+1
  end
end

function menu.draw()
  for i, v in ipairs(menu.buttons) do
    local c = i == menu.pressionado and menu.selectedColor or menu.buttonColor
    love.graphics.setColor(c)
    love.graphics.rectangle("fill",v.x,v.y,menu.buttonWidth,menu.buttonHeight)
  end
  love.graphics.setColor(255,255,255)
end