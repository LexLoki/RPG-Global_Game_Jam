enemie = {}

function enemie.load()
  enemie.x = 400
  enemie.y = 418
  enemie.speed = 90
  enemie.sight = 200
end

function enemie.start()
  enemie.x = 400
  enemie.y = 418
  enemie.speed = 90
  enemie.sight = 200
end

function enemie.update(dt)
  enemie.check(enemietype)
  if math.abs(player.x - enemie.x) <= enemie.sight then
    if player.x > enemie.x then
      enemie.x = enemie.x + enemie.speed*dt
    else 
      enemie.x = enemie.x - enemie.speed*dt
    end
  end
end

function enemie.draw()
  love.graphics.setColor(255,0,255)
  love.graphics.rectangle("fill", enemie.x, enemie.y, 64, 96)
end

function enemie.check(enemietype)
  if enemietype == 1 then
    enemie.speed = 120
    enemie.sight = 200
  elseif enemietype == 2 then
    enemie.speed = 80 
    enemie.sight = 300
  elseif enemietype == 3 then 
    enemie.speed = 180
    enemie.sight = 380
  end
end
