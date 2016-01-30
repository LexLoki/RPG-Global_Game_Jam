tile = {}

function tile.playerTouchedFloor()
  if tile.touchedFloorCallback ~= nil then
    tile.touchedFloorCallback()
  end
end

function tile.playerHitHazard()
  if tile.hitHazardCallback ~= nil then
    tile.hitHazardCallback()
  end
end