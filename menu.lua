menu={}
function menu.load()
  menu.buttonWidth = 200
  menu.buttonHeight = 100
  menu.buttonColor = {255,0,0,255}
  menu.selectedColor = {0,255,255,255}
  menu.buttonXPos = 520
  menu.buttons = {
    {yPos = 400, dir = -1 },
    {yPos = 500, dir = -1},
    {yPos = 600, dir = 1 }
  }
  menu.time = 1
  title = love.graphics.newImage("LOGO_OFICAL.png")
end

function menu.start()
  audio.play(audio.menuMusic)
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
        audio.playMenuStart()
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
    if(menu.pressionado == 1) then
      audio.playMenuStart()
      menu.startAnimation()
    elseif menu.pressionado == 3 then
      audio.playMenuStart()
      love.event.push("quit")
    end
  elseif(key == "down") then
    menu.pressionado = menu.pressionado%#menu.buttons+1
  elseif(key == "up") then
    local q = #menu.buttons
    menu.pressionado = (menu.pressionado-2+q)%q+1
  end
end

function menu.draw()
  love.graphics.draw(title, 640, 200, 0, 1, 1, title:getWidth()/2, title:getHeight()/2)
  for i, v in ipairs(menu.buttons) do
    local c = i == menu.pressionado and menu.selectedColor or menu.buttonColor
    love.graphics.setColor(c)
    love.graphics.rectangle("fill",v.x,v.y,menu.buttonWidth,menu.buttonHeight)
  end
  love.graphics.setColor(255,255,255)
end