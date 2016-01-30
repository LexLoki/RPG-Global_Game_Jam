tile_solid = {}

function tile_solid.handleHorizontalContact(player,tile)
  return true
end

function tile_solid.handleVerticalContact(player,tile)
  if player.speed.y>0 then
    tile_playerTouchedFloor()
  end
  return true
end