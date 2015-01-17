Grid = {}

function Grid:createGrid(w, h, plugin)
  local grid = {}

  for i = 1, h do
    grid[i] = {}
    for j = 1, w do
      grid[i][j] = plugin:initialize()
    end
  end

  return grid
end

function Grid:getNeighbors(Grid, x, y, w, h)
  local neighbors = {}

  if y > 1 then table.insert(neighbors, Grid[x][y - 1]) end

  if y < h then table.insert(neighbors, Grid[x][y + 1])
  else          table.insert(neighbors, Grid[x][1]) end

  if x > 1 then table.insert(neighbors, Grid[x - 1][y]) end

  if   x < w  then table.insert(neighbors, Grid[x + 1][y])
  else             table.insert(neighbors, Grid[1][y]) end

  if x > 1 and y > 1 then table.insert(neighbors, Grid[x - 1][y - 1]) end

  if     x > 1 and y < h  then table.insert(neighbors, Grid[x - 1][y + 1])
  elseif x > 1 and y >= h then table.insert(neighbors, Grid[x - 1][1]) end

  if     x < w  and y > 1 then table.insert(neighbors, Grid[x + 1][y - 1])
  elseif x >= w and y > 1 then table.insert(neighbors, Grid[1][y - 1]) end

  if     x < w  and y < h  then table.insert(neighbors, Grid[x + 1][y + 1])
  elseif x >= w and y >= h then table.insert(neighbors, Grid[1][1]) end

  return neighbors
end

return Grid
