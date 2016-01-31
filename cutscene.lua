cutscene = {}

function cutscene.load()
  video = love.graphics.newVideo(string, true)
  video:play()
  cutscene.seconds = 0
end

function cutscene.start()
  
end

function cutscene.keypressed(key)
  if key == "escape" then
    endvideo()
  end
end

function cutscene.update(dt)
  --[[cutscene.seconds = video:tell()
  if cutscene.seconds >= video:getDuration("seconds") then
    endvideo()
  end]]--
end

function cutscene.draw()
  --love.graphics.draw(video, 0, 0)
end

function endvideo()
  game.goToStage()
end