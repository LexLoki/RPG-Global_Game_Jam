function menu_load()
  pressionado = 0
  pausado = true
end
function menu_keypressed(key)
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
function menu_draw()
end
