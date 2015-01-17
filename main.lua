require 'grid'
GameOfLife = require 'plugins/gameOfLife'

function love.load()
  math.randomseed(os.time())

  Plugin = GameOfLife
  WindowWidth, WindowHeight = 800, 600

  Grid = {}
  GridWidth, GridHeight = 50, 50

  CellWidth, CellHeight = 0, 0

  AccDt, IterateTime = 0, 0.05

  love.resize(WindowWidth, WindowHeight)
  Grid = createGrid()
end

function love.update(dt)
  love.window.setTitle('Love Casper - FPS ' .. love.timer.getFPS())

  AccDt = AccDt + dt

  if (AccDt > IterateTime) then
    AccDt = 0
    local copiedGrid = createGrid()

    for x = 1, GridHeight do
      for y = 1, GridWidth do
        local neighbors = getNeighbors(x, y)

        copiedGrid[x][y] = Plugin:iterate(Grid[x][y], neighbors)
      end
    end
    Grid = copiedGrid
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

function love.keypressed(key)
  if key == "escape" then love.event.quit() end
end
