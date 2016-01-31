cutscene = {}

function cutscene.load()
  video = love.graphics.newVideo("Animatic-Tic-Toc-Man_.ogv", true)
  video:play()
end

function cutscene.start()
  
end

function cutscene.keypressed(key)
  if key == "escape" then
    endvideo()
  end
end

function cutscene.update(dt)
  if video:isPlaying() == false then
    endvideo()
  end
end

function cutscene.draw()
  love.graphics.draw(video, 0, 0)
end

function endvideo()
  game.goToStage()
end