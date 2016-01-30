require "tile"
tile_hazard = {}

function tile_hazard.handleContact(player,tile)
  tile.playerHitHazard()
  return true
end