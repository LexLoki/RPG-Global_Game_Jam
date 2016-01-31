viscont = {}

function viscont.load()
  viscont.font = love.graphics.newFont("ComicBook.otf", 20)
end

function viscont.update(dt)
end

function viscont.draw()
  love.graphics.setFont(viscont.font)
  love.graphics.setColor(255,0,0)
  love.graphics.circle("fill", 1020, 100, 40, 200)
  love.graphics.setColor(128,55,128)
  love.graphics.arc("fill", 1020, 100, 40, 0, 0.8*math.pi*timer_jump, 200)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("line", 1020, 100, 40, 2000)
  love.graphics.setColor(0,0,255)
  love.graphics.print(" PULO", 980, 145)
  love.graphics.setColor(255,0,0)
  love.graphics.circle("fill", 1150, 100, 40, 200)
  love.graphics.setColor(128,55,128)
  love.graphics.arc("fill", 1150, 100, 40, 0, 0.8*math.pi*timer_jump, 200)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("line", 1150, 100, 40, 2000)
  love.graphics.setColor(0,0,255)
  love.graphics.print(" SOCO", 1110, 145)
end