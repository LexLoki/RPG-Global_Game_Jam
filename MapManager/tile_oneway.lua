require "tile"
tile_oneway = {}

function tile_oneway.handleContactVertical(player,tile)
  if player.y<tile.y and player.y+player.height<=tile.y then
    tile.playerTouchedFloor()
    return true
  else
    return false
  end
end