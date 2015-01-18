Plugin = {}

-- Cells definition
Plugin.Dead  = {35, 35, 35}
Plugin.Alive = {94, 170, 99}

function Plugin:initialize()
  local random = math.random(100)

  if (random < 40) then
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

  if count < 2 then return Plugin.Dead end
  if count > 1 and count < 4 and cell == Plugin.Alive then return Plugin.Alive end
  if count > 3 then return Plugin.Dead end
  if count == 3 then return Plugin.Alive end

  return cell
end

return Plugin
