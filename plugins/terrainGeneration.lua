Plugin = {}

-- Cells definition
Plugin.Empty  = {200, 200, 200}
Plugin.Ground = {53, 35, 30}
Plugin.Water  = {0, 0, 255}

function Plugin:initialize()
  local random = math.random(100)

  if (random < 20) then
    return Plugin.Ground
  elseif (random < 40) then
    return Plugin.Water
  else
    return Plugin.Empty
  end
end

function Plugin:iterate(cell, neighbors)
  local groundBelow = false
  local waterAbove  = false

  for i = 1, #neighbors do
    local current        = neighbors[i]
    local position, type = current[1], current[2]

    if (position == 'S' and type == Plugin.Ground) then
      groundBelow = true
    elseif (position == 'N' and type == Plugin.Water) then
      waterAbove = true
    end
  end

  if (cell == Plugin.Water and groundBelow) then
    return cell
  elseif (cell == Plugin.Empty and waterAbove) then
    return Plugin.Water
  elseif (cell == Plugin.Ground) then
    return cell
  else
    return Plugin.Empty
  end

  return cell
end

return Plugin
