require "dialog"
require "menu"
require "Player/player"
require "stage"
game = {}

function game.load()
  player.load()
  menu.load(game.changeState)
  stage.load()
  game.gameState = menu
end

function game.start()
  game.gameState.start()
end

function game.keypressed(key)
  game.gameState.keypressed(key)
end

function game.update(dt)
  game.gameState.update(dt)
end

function game.draw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  game.gameState.draw(h,w)
end


function game.changeState(x)
  game.gameState = x
  x.start()
end

function game.goToStage()
  game.changeState(stage)
end