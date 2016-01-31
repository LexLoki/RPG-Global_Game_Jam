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
  loadQuadTile(1) -- 1
  loadQuadTile(2,0,0) -- 2
  loadQuadTile(2,1,1) -- 3
  loadQuadTile(3,6,0) -- 4
end

--[[
function mapManager.hazardCallback(callback)
  tile.hitHazardCallback = callback
end
function mapManager.touchedFloorCallback(callback)
  tile.touchedFloorCallback = callback
end
]]

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
  file:close()
  mapManager.camera = {
    pos_x = 0,
    pos_y = 0
  }
  mapManager.width = j*tileSize
  mapManager.height = i*tileSize
end

function mapManager.update(dt,player)
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  mapManager.camera.pos_x = math.min(math.max(0,player.x+player.width/2-w/2),mapManager.width-w)
  mapManager.camera.pos_y = math.min(math.max(0,player.y+player.height/2-h/2),mapManager.height-h)
end

function mapManager.draw()
  --print("DRAW")
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  local px = mapManager.camera.pos_x
  local py = mapManager.camera.pos_y
  local fx = px
  local cx = fx + w
  local fy = py
  local cy = fy + h
  cy = math.floor(cy/tileSize)+1
  fy = math.floor(fy/tileSize)+1
  cx = math.floor(cx/tileSize)+1
  fx = math.floor(fx/tileSize)+1
  local x=px%tileSize
  local y=py%tileSize
  print(fx .. " " .. cx .. " " .. fy .. " " .. cy)
  for i=fy,cy do
  --for i,v in ipairs(mapManager.solid) do
    for j=fx,cx do
    --for j,w in ipairs(v) do
      local w = mapManager.solid[i]
      if w~=nil then w = w[j] end
      if w~=nil and w.quad ~= nil then
        love.graphics.draw(mapManager.sheet,w.quad,-x+(j-fx)*32,-y+(i-fy)*32,0,0.5,0.5)
        --love.graphics.draw(mapManager.sheet,w.quad,(j-1)*32,(i-1)*32,0,0.5,0.5)
      end
      --love.graphics.draw(w.img,(i-1)*32,(j-1)*32,0,0.5,0.5)
    end
  end
end

function mapManager.handleContact(dt,entity)
  local s = math.sign(entity.speedx)
  local front = entity.x + entity.width/2 + entity.width/2*s
  local dx = front + entity.speedx*dt
  local x_coord = math.floor(dx/tileSize)+1
  if dx<0 then entity.x = 0
  elseif mapManager.handleHorizontalContact(entity,x_coord) then
    entity.x = entity.x + (dx - front)
  else
    --entity.x = (x_coord-1-s)*tileSize
  end
  
  s = math.sign(entity.speedy)
  front = entity.y + entity.height/2 + entity.height/2*s
  local dy = front + entity.speedy*dt
  local y_coord = math.floor(dy/tileSize)+1
  if mapManager.handleVerticalContact(entity,y_coord) then
    entity.y = entity.y + (dy - front)
  else
    --entity.y = (y_coord-1-s)*tileSize
  end
end

function mapManager.handleHorizontalContact(entity,tx)
  for i=math.floor(entity.y/tileSize)+1,math.floor((entity.y+entity.height)/tileSize)+1 do
    if i > 0 and i <= table.getn(mapManager.solid)
     and  tx > 0 and tx <= table.getn(mapManager.solid[i]) then
      if not mapManager.solid[i][tx].class.handleHorizontalContact(entity) then
        return false
      end
    else
              return false
    end  
  end
  return true
end

function mapManager.handleVerticalContact(entity,ty)
  local y = (ty-1)*tileSize
  for j=math.floor(entity.x/tileSize)+1,math.floor((entity.x+entity.width)/tileSize)+1 do
    if ty > 0 and ty <=  table.getn(mapManager.solid)
     and  j > 0 and j <=  table.getn(mapManager.solid[ty])then
      if not mapManager.solid[ty][j].class.handleVerticalContact(entity,{x=(j-1)*tileSize,y=y,width=tileSize,height=tileSize}) then
        return false
      end 
    end
  end
  return true
end