require "Player/player_jumpState"
require "Player/player_walkState"
require "attack"
require "animations"
require "animationManager"
player = {}

local entryState, loadSpriteData

function player.load()
  player.maxSpeed = 200
  player.invTime = 2
  player.gravity = 1100
  player.width = 64
  player.height = 128
  player.jump_time = 5.0
  player_jumpState.load()
  attack.load()
end

function player.start()
  player.speedx = 0
  player.speedy = 0
  player.dir = 1
  player.x = 100
  player.y = 100
  player.dir = 1
  player.state = player_walkState
  timer_jump = 0
player.offset = {
    x=19,
    y=6
  }
  player.hitbox = {
    width = 29,
    height = 123
  }
  player.walk = loadSpriteData("/Assets/player_walk.png",8,8,1,true)
  player.jumpS = loadSpriteData("/Assets/player_jump.png",5,5,0.3,false)
  player.curr_sprite = player.walk
  attack.start()
end

function loadSpriteData(filename,quant,col,time,doRepeat)
  local img = love.graphics.newImage(filename)
  local aw = img:getWidth()
  local ah = img:getHeight()
  local ew = aw/col
  local eh = ah/math.floor(quant/col)
  local data = {
    sheet=img,
    quads=animations.loadQuads(quant,col,ew,eh,aw,ah),
    aComp=animationManager_new(quant,time,doRepeat)
  }
  return data
end

function player.update(dt)
  --player.y = player.y + player.speedy*dt
  player.speedy = player.speedy + player.gravity*dt
  if(love.keyboard.isDown("right")) then
    player.speedx = player.maxSpeed
  elseif(love.keyboard.isDown("left")) then
    player.speedx = -player.maxSpeed
  else
    player.speedx = 0
  end
  player.state.update(dt)
end

function player.draw()
  if(player.x == nil) or (player.y == nil) then
    player.x = 100
    player.y = 600
  end
  local c = mapManager.camera
  local s = player.curr_sprite
  love.graphics.setColor(255,255,255)
  if player.speedx<0 then player.dir = -1
  elseif player.speedx>0 then player.dir = 1 end
  love.graphics.draw(s.sheet,s.quads[s.aComp.curr_frame],player.x-c.pos_x+player.width/2,player.y-c.pos_y+player.height/2,0,player.dir,1,player.width/2,player.height/2)
  --love.graphics.rectangle("line",player.x-c.pos_x,player.y-c.pos_y,player.width,player.height)
  attack.draw()
end

function player.jump()
  --... do something maybe
  entryState(player_jumpState)
end
function player.reachFloor()
  player.speedy = 0
  if player.state ~= player_walkState then
    entryState(player_walkState)
  end
end

function player.keypressed(key)
  player.state.keypressed(key)
end

function player.keyreleased(key)
  
end

function entryState(state)
  player.state.exit()
  player.state = state
  player.state.start()
end