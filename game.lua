require "dialog"
require "menu"
require "Player/player"
require "stage"
require "cutscene"
game = {}

function game.load()
  player.load()
  menu.load()
  stage.load()
  game.goToMenu()
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
  game.gameState.start()
end

function game.goToStage()
  game.changeState(stage)
end

function game.goToIntro()
  game.changeState(cutscene)
end

function game.goToMenu()
  game.changeState(menu)
end