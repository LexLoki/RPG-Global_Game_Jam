require "MapManager/tile"
tile_hazard = {}

function tile_hazard.handleHorizontalContact(player)
  tile.playerHitHazard()
  return true
end

function tile_hazard.handleVerticalContact(player)
  tile.playerHitHazard()
  return true
end