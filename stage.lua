require "Player/player"

stage = {}

function stage.load()
  player.load()
end

function stage.update(dt)
  player.update(dt)
end

function stage.draw()
  player.draw()
end

function stage.start()
  player.start()
end

function stage.keypressed(key)
  player.keypressed(key)
end