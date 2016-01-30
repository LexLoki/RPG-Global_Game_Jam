require "MapManager/tile"
require "MapManager/tile_solid"
require "MapManager/tile_hazard"
require "MapManager/tile_free"
require "MapManager/tile_oneway"
require "mathUtils"

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
local loadTile, loadQuadTile

function mapManager.load()
  mapManager.data = {}
  mapManager.sheet = love.graphics.newImage("/MapManager/Tiles_64x64.png")
  mapManager.sheetWidth = mapManager.sheet:getWidth()
  mapManager.sheetHeight = mapManager.sheet:getHeight()
  --loadTile("floor",2)
  loadQuadTile(1)
  loadQuadTile(2,0,0)
  loadQuadTile(2,1,1)
  loadQuadTile(3,6,0)
end

function mapManager.hazardCallback(callback)
  tile.hitHazardCallback = callback
end
function mapManager.touchedFloorCallback(callback)
  tile.touchedFloorCallback = callback
end

function loadQuadTile(id,x,y)
  if x ~= nil then
    table.insert(mapManager.data,{
      quad=love.graphics.newQuad(x*64,y*64,64,64,mapManager.sheetWidth,mapManager.sheetHeight),
      class = tile_types[id]
    })
  else
    table.insert(mapManager.data,{class=tile_types[id]})
  end
end

function loadTile(string, id)
  table.insert(mapManager.data,{img=love.graphics.newImage("/Assets/Tiles/" .. string .. ".png"),class=tile_types[id]})
end

function evaluateField(code,i,j)
  mapManager.solid[i][j] = mapManager.data[code]
end

function mapManager.start(filename)
  local file = io.open("MapManager/stage_1.txt")
  local lines = file:lines()
  mapManager.solid = {}
  local i = 1
  local j
  for line in lines do
    mapManager.solid[i] = {}
    local words = line:gmatch("%S+")
    j = 1
    local line = {}
    for word in words do
      evaluateField(tonumber(word),i,j)
      j = j+1
    end
    i = i+1
  end
  mapManager.camera = {
    pos_x = 0,
    pos_y = 0
  }
  mapManager.width = j*tileSize
  mapManager.height = i*tileSize
end

function mapManager.update(dt)
  local w = love.graphics.getWidth()
end

function mapManager.draw()
  --print("DRAW")
  for i,v in ipairs(mapManager.solid) do
    for j,w in ipairs(v) do
      if w.quad ~= nil then
        love.graphics.draw(mapManager.sheet,w.quad,(j-1)*32,(i-1)*32,0,0.5,0.5)
      end
      --love.graphics.draw(w.img,(i-1)*32,(j-1)*32,0,0.5,0.5)
    end
  end
end

function mapManager.handleContact(dt,player)
  local s = math.sign(player.speedx)
  local front = player.x + player.width/2 + player.width/2*s
  local dx = front + player.speedx*dt
  local x_coord = math.floor(dx/tileSize)+1
  if dx<0 then player.x = 0
  elseif mapManager.handleHorizontalContact(player,x_coord) then
    player.x = player.x + (dx - front)
  else
    --player.x = (x_coord-1-s)*tileSize
  end
  
  s = math.sign(player.speedy)
  front = player.y + player.height/2 + player.height/2*s
  local dy = front + player.speedy*dt
  local y_coord = math.floor(dy/tileSize)+1
  if mapManager.handleVerticalContact(player,y_coord) then
    player.y = player.y + (dy - front)
  else
    --player.y = (y_coord-1-s)*tileSize
  end
end

function mapManager.handleHorizontalContact(player,tx)
  for i=math.floor(player.y/tileSize)+1,math.floor((player.y+player.height)/tileSize)+1 do
    if i > 0 and i <= table.getn(mapManager.solid)
     and  tx > 0 and tx <= table.getn(mapManager.solid[i]) then
      if not mapManager.solid[i][tx].class.handleHorizontalContact(player) then
        return false
      end
    else
              return false
    end  
  end
  return true
end

function mapManager.handleVerticalContact(player,ty)
  local y = (ty-1)*tileSize
  for j=math.floor(player.x/tileSize)+1,math.floor((player.x+player.width)/tileSize)+1 do
    if ty > 0 and ty <=  table.getn(mapManager.solid)
     and  j > 0 and j <=  table.getn(mapManager.solid[ty])then
      if not mapManager.solid[ty][j].class.handleVerticalContact(player,{x=(j-1)*tileSize,y=y,width=tileSize,height=tileSize}) then
        return false
      end 
    end
  end
  return true
end