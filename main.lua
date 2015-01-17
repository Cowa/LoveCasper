require 'grid'
GameOfLife = require 'plugins/gameOfLife'

function love.load()
  math.randomseed(os.time())

  Plugin = GameOfLife
  WindowWidth, WindowHeight = 800, 600

  Grid = {}
  GridLines, GridColumns = 50, 60

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
    local nextGrid = createGrid()

    for x = 1, GridLines do
      for y = 1, GridColumns do
        local neighbors = getNeighbors(x, y)

        nextGrid[x][y] = Plugin:iterate(Grid[x][y], neighbors)
      end
    end
    Grid = nextGrid
  end
end

function love.draw()
  love.graphics.setColor(50, 50, 255)
  love.graphics.rectangle('fill', 0, 0, WindowWidth, WindowHeight)
  for x = 1, GridLines do
    for y = 1, GridColumns do
      love.graphics.setColor(Grid[x][y])
      love.graphics.rectangle('fill', (y - 1) * CellWidth, (x - 1) * CellHeight, CellWidth, CellHeight)
    end
  end
end

function love.resize(w, h)
  WindowWidth, WindowHeight = w, h
  CellWidth, CellHeight     = (w / GridColumns), (h / GridLines)
end

function love.keypressed(key)
  if key == "escape" then love.event.quit() end
end
