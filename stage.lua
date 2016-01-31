require "Player/player"
require "MapManager/mapManager"
require "enemie/enemie_human"
require "enemie/enemie_dog"

stage = {}

function stage.load()
  player.load()
  mapManager.load()
 -- mapManager.touchedFloorCallback(player.reachFloor)
  
  -- Loop para atualizar Enemies da Lista
  enemie_human.load()
  enemie_dog.load()
end

function stage.update(dt)
  if not stage.isPaused then
    mapManager.update(dt,player)
    player.update(dt)
    mapManager.handleContact(dt,player)
    
    
   -- Loop para atualizar Enemies da Lista
    enemie_human.update(dt)
    enemie_dog.update(dt)
    mapManager.handleContact(dt,enemie_dog)
    mapManager.handleContact(dt,enemie_human)

  end
end

function stage.draw()
  love.graphics.setColor(255,255,255)
  mapManager.draw()
  
  -- Loop para atualizar Enemies da Lista
  enemie_dog.draw()
  enemie_human.draw()
  
  player.draw()
  if stage.isPaused then
    stage.pauseDraw()
  end
end

function stage.pauseDraw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  love.graphics.setColor(0,0,0,100)
  love.graphics.rectangle("fill",0,0,w,h)
  love.graphics.setColor(255,255,255)
  --love.graphics.draw(game.pauseImg,0,0,0,w/game.pauseImg:getWidth(),h/game.pauseImg:getHeight())
end

function stage.start()
  player.start()
  mapManager.start()
  stage.isPaused = false
end

function stage.keypressed(key)
  if key == "escape" then
    stage.isPaused = not stage.isPaused
  elseif not stage.isPaused then
    player.keypressed(key)
    if key == "a" then
      game.goToGameOver()
      end
  end
end
