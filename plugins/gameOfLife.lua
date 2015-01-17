Plugin = {}

-- Cells definition
Plugin.Dead  = {0, 0, 0}
Plugin.Alive = {255, 255, 255}

function Plugin:initialize()
  local random = math.random(100)

  if (random < 10) then
    return Plugin.Alive
  else
    return Plugin.Dead
  end
end

function Plugin:iterate(cell, neighbors)
  local count = 0

  for i = 1, #neighbors do
    if neighbors[i] == Plugin.Alive then
      count = count + 1
    end
  end

  -- When the current cell is Dead
  if cell == Plugin.Dead then
    if count == 3 then
      return Plugin.Alive
    else
      return Plugin.Dead
    end
  else
    -- When the current cell is Alive
    if count >= 2 and count <= 3 then
      return Plugin.Alive
    else
      return Plugin.Dead
    end
  end
end

return Plugin
