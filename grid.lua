function createGrid()
  local grid = {}

  for x = 1, GridLines do
    grid[x] = {}
    for y = 1, GridColumns do
      grid[x][y] = Plugin:initialize()
    end
  end

  return grid
end

function getNeighbors(x, y)
  local neighbors = {}

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
