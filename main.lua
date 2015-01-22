Gui        = require 'vendors.frames'
GameOfLife = require 'plugins.gameOfLife'
TerrainGen = require 'plugins.terrainGeneration'
require 'gui'

function love.load()
  math.randomseed(os.time())

  Plugin = TerrainGen
  WindowWidth, WindowHeight = 800, 600

  Grid = {}
  GridLines, GridColumns = 100, 90

  CellWidth, CellHeight = 0, 0

  AccDt, IterateTime = 0, 0.10
  Paused = true

  setUpGui()

  love.resize(WindowWidth, WindowHeight)
  Grid = createGrid()
end

function love.update(dt)
  love.window.setTitle('Love Casper - FPS ' .. love.timer.getFPS())

  AccDt = AccDt + dt

  if (AccDt > IterateTime and not Paused) then
    AccDt = 0
    local nextGrid = createGrid()

    for x = 1, GridLines do
      for y = 1, GridColumns do
        local neighbors = getNeighbors(x, y)

        nextGrid[x][y] = Plugin:iterate(Grid[x][y], neighbors)
      end
    end
    Grid = nextGrid
  end

  Gui.update(dt)
end

function love.draw()
  for x = 1, GridLines do
    for y = 1, GridColumns do
      love.graphics.setColor(Grid[x][y])
      love.graphics.rectangle('fill', (y - 1) * CellWidth, (x - 1) * CellHeight, CellWidth, CellHeight)
    end
  end
  Gui.draw()
end

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

  -- N: North, E: East, W: West, S: South, etc.
  if Grid[x - 1] ~= nil then table.insert(neighbors, {'N', Grid[x - 1][y]}) end
  if Grid[x + 1] ~= nil then table.insert(neighbors, {'S', Grid[x + 1][y]}) end
  if Grid[x][y - 1] ~= nil then table.insert(neighbors, {'W', Grid[x][y - 1]}) end
  if Grid[x][y + 1] ~= nil then table.insert(neighbors, {'E', Grid[x][y + 1]}) end
  if Grid[x + 1] ~= nil and Grid[x + 1][y + 1] ~= nil then table.insert(neighbors, {'SW', Grid[x + 1][y + 1]}) end
  if Grid[x - 1] ~= nil and Grid[x - 1][y - 1] ~= nil then table.insert(neighbors, {'NE', Grid[x - 1][y - 1]}) end
  if Grid[x + 1] ~= nil and Grid[x + 1][y - 1] ~= nil then table.insert(neighbors, {'NW', Grid[x + 1][y - 1]}) end
  if Grid[x - 1] ~= nil and Grid[x - 1][y + 1] ~= nil then table.insert(neighbors, {'SE', Grid[x - 1][y + 1]}) end

  return neighbors
end

function whichGridCase(x, y)
  return math.ceil(x / CellWidth), math.ceil(y / CellHeight)
end

function love.resize(w, h)
  WindowWidth, WindowHeight = w, h
  CellWidth, CellHeight     = (w / GridColumns), (h / GridLines)
  resizeGui()
end

function love.keypressed(key)
  if key == 'escape' then love.event.quit()
  elseif key == ' ' then Paused = not Paused
  elseif key == 'h' then
    VisiblePanel = not VisiblePanel
    Panel:SetVisible(VisiblePanel)
  elseif key == 'r' then
    Grid = createGrid()
  end
  Gui.keypressed(key, unicode)
end

function love.keyreleased(key) Gui.keyreleased(key) end

function love.mousepressed(x, y, button)
  local col, row = whichGridCase(x, y)
  Grid[row][col] = Plugin.Water

  Gui.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button) Gui.mousereleased(x, y, button) end
