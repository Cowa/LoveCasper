Plugin = {}

-- Cells definition
Plugin.Empty  = {200, 200, 200}
Plugin.Ground = {53, 35, 30}
Plugin.Water  = {0, 0, 255}

function Plugin:initialize()
  local random = math.random(100)

  if (random < 40) then
    return Plugin.Ground
  elseif (random < 60) then
    return Plugin.Water
  else
    return Plugin.Empty
  end
end

function Plugin:iterate(cell, neighbors)
  local groundBelow = false
  local waterAbove  = false
  local waterLeft   = false
  local waterRight  = false
  local groundLeft  = false
  local groundRight = false

  for i = 1, #neighbors do
    local current        = neighbors[i]
    local position, type = current[1], current[2]

    if (position == 'S' and type == Plugin.Ground) then
      groundBelow = true
    elseif (position == 'N' and type == Plugin.Water) then
      waterAbove = true
    elseif (position == 'W' and type == Plugin.Ground) then
      groundLeft = true
    elseif (position == 'E' and type == Plugin.Ground) then
      groundRight = true
    elseif (position == 'W' and type == Plugin.Water) then
      waterLeft = true
    elseif (position == 'E' and type == Plugin.Water) then
      waterRight = true
    end
  end

  if (cell == Plugin.Water) then
    if (waterAbove) then
      return Plugin.Water
    elseif (groundBelow and ((groundLeft or waterLeft) and (groundRight or waterRight))) then
      return Plugin.Water
    else
      return Plugin.Empty
    end

  elseif (cell == Plugin.Empty) then
    if (waterAbove) then
      return Plugin.Water
    elseif (waterLeft) then
      return Plugin.Water
    end
  end

  return cell
end

return Plugin
