function createGrid()
  local grid, w, h = {}, GridWidth, GridHeight

  for i = 1, h do
    grid[i] = {}
    for j = 1, w do
      grid[i][j] = Plugin:initialize()
    end
  end

  return grid
end

function getNeighbors(x, y)
  local neighbors, w, h = {}, GridWidth, GridHeight

  if Grid[x - 1] ~= nil then table.insert(neighbors, Grid[x - 1][y]) end
  if Grid[x + 1] ~= nil then table.insert(neighbors, Grid[x + 1][y]) end
  if Grid[x][y - 1] ~= nil then table.insert(neighbors, Grid[x][y - 1]) end
  if Grid[x][y + 1] ~= nil then table.insert(neighbors, Grid[x][y + 1]) end
  if Grid[x + 1] ~= nil and Grid[x + 1][y + 1] ~= nil  then table.insert(neighbors, Grid[x + 1][y + 1]) end
  if Grid[x - 1] ~= nil and Grid[x - 1][y - 1] ~= nil  then table.insert(neighbors, Grid[x - 1][y - 1]) end
  if Grid[x + 1] ~= nil and Grid[x + 1][y - 1] ~= nil  then table.insert(neighbors, Grid[x + 1][y - 1]) end
  if Grid[x - 1] ~= nil and Grid[x - 1][y + 1] ~= nil  then table.insert(neighbors, Grid[x - 1][y + 1]) end

  return neighbors
end
