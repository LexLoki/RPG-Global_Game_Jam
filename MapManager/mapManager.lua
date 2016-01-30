require "tile"
require "tile_solid"
require "tile_hazard"
require "tile_free"
require "tile_oneway"

mapManager = {}

--[[
Tabela de valores, por exemplo:
1 = livre
2 = chaoAreia
3 = chaoMadeira
4 = paredeAco
]]

--[[
1 = livre
2 = solid
3 = oneway
4 = hazard
]]
local tile_types = {
  tile_free,
  tile_solid,
  tile_oneway,
  tile_hazard
}

local tileSize = 32
local evaluateField
local loadTile

function mapManager.load()
  mapManager.data = {}
  loadTile("floor",2)
end

function mapManager.hazardCallback(callback)
  tile.touchedFloorCallback = callback
end
function mapManager.touchedFloorCallback(callback)
  tile.hitHazardCallback = callback
end

function loadTile(string, id)
  table.insert(mapManager.data,{img=love.graphics.newImage("/Assets/Tiles/" .. string .. ".png"),class=tile_types[id]})
end


function evaluateField(code,i,j)
  mapManager.solid[i][j] = mapManager.data[code]
end

function mapManager.start(filename)
  local file = io.open(filename)
  local lines = file:lines()
  mapManager.solid = {}
  for i,line in ipairs(lines) do
    local words = line:gmatch()
    for j,word in ipairs(words) do
      evaluateField(word,i,j)
    end
  end
  mapManager.camera = {
    pos_x = 0,
    pos_y = 0
    }
end

function mapManager.update(dt)
  local w = love.graphics.getWidth()
  local xv = 
end

function mapManager.draw()
  for i,v in ipairs(mapManager.solid) do
    for j,w in ipairs(v) do
      love.graphics.draw(w.img,(i-1)*32,(j-1)*32)
    end
  end
end

function mapManager.handleContact(dt,player)
  local s = math.sign(player.speed.x)
  local dx = player.x + player.width/2 + player.width/2*s + player.speed.x*dt
  local x_coord = math.floor(dx/tileSize)+1
  if mapManager.handleHorizontalContact(player,x_coord) then
    player.x = dx
  else
    player.x = (x_coord-1-s)*tileSize
  end
  s = math.sign(player.speed.y)
  local dy = player.y + player.height/2 + player.height/2*s + player.speed.y*dt
  local y_coord = math.floor(dy/tileSize)+1
  if mapManager.handleVerticalContact(player,y_coord) then
    player.y = dy
  else
    player.y = (y_coord-1-s)*tileSize
  end
end

function mapManager.handleHorizontalContact(player,tx)
  for i=math.floor(player.y)+1,math.floor(player.y+player.height)+1 do
    if not mapManager.solid[i][tx].handleHorizontalContact() then
      return false
    end
  end
  return true
end

function mapManager.handleVerticalContact(player,ty)
  for j=math.floor(player.x)+1,math.floor(player.x+player.width)+1 do
    if not mapManager.solid[ty][j].handleVerticalContact() then
      return false
    end
  end
  return true
end