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
  if(key == 'return') then
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
end
function menu.draw()
  
end