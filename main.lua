GridHandler = require 'grid'
GameOfLife  = require 'plugins/gameOfLife'
Plugin      = GameOfLife

Title = 'Love Casper - FPS '

WindowWidth  = 800
WindowHeight = 600

Grid       = {}
GridWidth  = 100
GridHeight = 100

CellWidth  = 0
CellHeight = 0

AccDt       = 0
IterateTime = 0.05

function love.load()
  math.randomseed(os.time())
  love.resize(WindowWidth, WindowHeight)
  Grid = GridHandler:createGrid(GridWidth, GridHeight, Plugin)
end

function love.update(dt)
  love.window.setTitle(Title .. love.timer.getFPS())

  AccDt = AccDt + dt

  if (AccDt > IterateTime) then
    AccDt = 0
    local copyGrid = Grid

    for x = 1, GridHeight do
      for y = 1, GridWidth do
        local neighbors = GridHandler:getNeighbors(Grid, x, y, GridWidth, GridHeight)

        copyGrid[x][y] = Plugin:iterate(Grid[x][y], neighbors)
      end
    end
    Grid = copyGrid
  end
end

function love.draw()
  for x = 1, GridHeight do
    for y = 1, GridWidth do
      love.graphics.setColor(Grid[x][y])
      love.graphics.rectangle('fill', (x - 1) * CellWidth, (y - 1) * CellHeight, CellWidth, CellHeight)
    end
  end
end

function love.resize(w, h)
  CellWidth  = w / GridWidth
  CellHeight = h / GridHeight
end
