require "MapManager/tile"
require "MapManager/tile_solid"
require "MapManager/tile_hazard"
require "MapManager/tile_free"
require "MapManager/tile_oneway"
require "mathUtils"
require "Parallax/parallax"

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

local tileSize = 64
local evaluateField, storeBG
local loadTile, loadQuadTile
local loadBackground

function loadBackground(string,speed)
  local img = love.graphics.newImage(string)
  local h = love.graphics.getHeight()
  local w = h/img:getHeight()*img:getWidth()
  return {image = img, height=h, width=w, speed=speed*w}
end

function mapManager.load()
  mapManager.data = {}
  mapManager.backgrounds = {
    loadBackground("/Parallax/Plano-3.png",0.05),
    loadBackground("/Parallax/Plano-2.png",0.1),
    loadBackground("/Parallax/Plano-1.png",0.1625)
  }
  mapManager.parallax = parallax_new(mapManager.backgrounds)
  mapManager.sheet = love.graphics.newImage("/MapManager/tileset.png")
  mapManager.sheetWidth = mapManager.sheet:getWidth()
  mapManager.sheetHeight = mapManager.sheet:getHeight()
  --loadTile("floor",2)
  loadQuadTile(1) -- 1
  loadQuadTile(2,0,0) -- 2
  loadQuadTile(2,0,1) -- 3
  
  --car
  loadQuadTile(2,5,0) -- 4
  loadQuadTile(2,6,0) -- 5
  loadQuadTile(2,4,1) -- 6
  loadQuadTile(2,5,1) -- 7
  loadQuadTile(2,6,1) -- 8
  --muro
  loadQuadTile(2,1,0) -- 9
  loadQuadTile(2,2,0) -- 10
  loadQuadTile(2,3,0) -- 11
  
  --down mureta
  loadQuadTile(2,13,1) -- 12
  loadQuadTile(2,14,1) -- 13
  
  --telha
  loadQuadTile(3,13,0) -- 14
  loadQuadTile(3,14,0) -- 15
  --placeholder
  loadQuadTile(3,0,1) -- 16
  
  --placeholder wall
  loadQuadTile(2,2,1) -- 17
  
  --galho
  loadQuadTile(3,7,0) -- 18
  loadQuadTile(3,8,0) -- 19
  
  --banco
  loadQuadTile(1,9,0) -- 20
  loadQuadTile(1,10,0) -- 21
  loadQuadTile(1,11,0) -- 22
  loadQuadTile(3,9,1) -- 23
  loadQuadTile(3,10,1) -- 24
  loadQuadTile(3,11,1) -- 25
  
  --lixeira
  loadQuadTile(3,12,0) -- 26
  
  --mastro placeholder
  loadQuadTile(3,0,1) -- 27
  loadQuadTile(3,0,1) -- 28
  
  --muro down
  loadQuadTile(2,1,1) -- 29
  loadQuadTile(2,2,1) -- 30
  loadQuadTile(2,3,1) -- 31
  
  --ganhou
  loadQuadTile(1) -- 32
  
  mapManager.bgData = {}
  mapManager.bgSheet = love.graphics.newImage("/MapManager/tilemap_bg.png")
  local w = mapManager.bgSheet:getWidth()
  local h = mapManager.bgSheet:getHeight()
  storeBG(100,2090,0,128,357,w,h)
  storeBG(101,1638,42,451,472,w,h)
  storeBG(102,1638,0,71,44,w,h)
  storeBG(103,0,0,64*4,64*12,w,h)
  storeBG(104,64*4,0,64*4,64*16,w,h)
  storeBG(105,64*8,0,64*4,64*20,w,h)
  storeBG(106,64*12,0,64*18,719,w,h)
  storeBG(107,64*30,0,364,709,w,h)
  --storeBG(108,,0, , ,w,h)
  -- 100 poste
    -- 101 arvore
    -- 102 arbusto
    -- 103 predio1
    -- 104 predio2
    -- 105 predio ferrado
    -- 106 casa1
    -- 107 casa2
    -- 108 buraco
end

function storeBG(id,x,y,width,height,aw,ah)
  mapManager.bgData[id] = {quad=love.graphics.newQuad(x,y,width,height,aw,ah),width=width,height=height}
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

function evaluateField(sceneList, code,i,j)
  if code > 32 then
    
    --print("rola="..code.. " - "..i.." x "..j)
    pos_x = (j-1)*tileSize
    pos_y = (i-1)*tileSize -1
    
    if code == 33 then --player
      player.x = pos_x
      player.y = pos_y
    elseif code == 34 then --relogio
    elseif code == 35 then --gato
      enemie_cat.spawn(pos_x, pos_y)
      enemies.update_enemie_list()

    elseif code == 36 then --cachorro
      enemie_human.spawn(pos_x, pos_y)
      enemies.update_enemie_list()
    
    elseif code == 37 then --humano
      enemie_dog.spawn(pos_x, pos_y)
      enemies.update_enemie_list()
    
    elseif code == 38 then --marfioso
      enemie_marfian.spawn(pos_x, pos_y)
      enemies.update_enemie_list()
    end
    
    elseif code >= 100 then
      local data = mapManager.bgData[code]
      --data.width
      --data.height
      -- para exibir love.graphics.draw(mapManager.bgSheet,data.quad, POSICAOX, POSICAOY)
    end
    -- 100 poste
    -- 101 arvore
    -- 102 arbusto
    -- 103 predio1
    -- 104 predio2
    -- 105 predio ferrado
    -- 106 casa1
    -- 107 casa2
    -- 108 buraco
 
        code = 1
  end
    sceneList[i][j] = mapManager.data[code]
end

function mapManager.start(filename)
  local file = io.open("MapManager/Distrito_Pacifico.txt")
  local filebg = io.open("MapManager/Distrito_Pacifico_bg.txt")
  
  local lines = file:lines()
  local linesbg = file:lines()
  
  mapManager.solid = {}
  mapManager.background = {}
  
  enemies.reset()
  
  local i = 1
  local j
  for line in lines do
    mapManager.solid[i] = {}
    local words = line:gmatch("%S+")
    j = 1
    local line = {}
    for word in words do
      evaluateField(mapManager.solid,tonumber(word),i,j)
      j = j+1
    end
    i = i+1
  end
  file:close()
  
  
  local ibg = 1
  local jbg
  for linebg in linesbg do
    mapManager.background[i] = {}
    local words = linebg:gmatch("%S+")
    jbg = 1
    local linebg = {}
    for wordbg in wordsbg do
      evaluateField(mapManager.background, tonumber(wordbg),ibg,jbg)
      jbg = jbg+1
    end
    ibg = ibg+1
  end
  filebg:close()
  
  
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
  local x = mapManager.camera.pos_x
  mapManager.camera.pos_x = math.min(math.max(0,player.x+player.width/2-w/2),mapManager.width-w)
  mapManager.camera.pos_y = math.min(math.max(0,player.y+player.height/2-h/2),mapManager.height-h)
  parallax_update(dt,mapManager.parallax,math.absSign(mapManager.camera.pos_x-x))
end

function mapManager.draw()
  --print("DRAW")
  parallax_draw(mapManager.parallax)
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
  --print(fx .. " " .. cx .. " " .. fy .. " " .. cy)
  for i=fy,cy do
  --for i,v in ipairs(mapManager.solid) do
    for j=fx,cx do
    --for j,w in ipairs(v) do
      local w = mapManager.solid[i]
      if w~=nil then w = w[j] end
      if w~=nil and w.quad ~= nil then
        love.graphics.draw(mapManager.sheet,w.quad,-x+(j-fx)*64,-y+(i-fy)*64)
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
  
--[[  if entity.name ~= nil then
    print(entity.name)
    print(entity.name.." "..entity.speedy)
  end]]
  
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