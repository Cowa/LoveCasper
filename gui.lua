VisiblePanel = false

Panel = Gui.Create('panel')

local play         = Gui.Create('button', Panel)
local hide         = Gui.Create('button', Panel)
local nbLineGrid   = Gui.Create("numberbox", Panel)
local nbColumnGrid = Gui.Create("numberbox", Panel)

function setUpGui()
  Panel:SetVisible(false)

  play.OnClick = function()
    Paused = not Paused
  end

  hide.OnClick = function()
    VisiblePanel = not VisiblePanel
    Panel:SetVisible(VisiblePanel)
  end

  nbLineGrid:SetValue(GridLines)
  nbLineGrid:SetMin(1)
  nbLineGrid.OnValueChanged = function(object, value)
    GridLines = value
    Grid = createGrid()
    love.resize(WindowWidth, WindowHeight)
  end

  nbColumnGrid:SetValue(GridColumns)
  nbColumnGrid:SetMin(1)
  nbColumnGrid.OnValueChanged = function(object, value)
    GridColumns = value
    Grid = createGrid()
    love.resize(WindowWidth, WindowHeight)
  end
end

function resizeGui()
  Panel:SetPos(0, 0)
  Panel:SetSize(WindowWidth, 32)

  play:SetText("Play/Pause")
  play:SetPos(4, 4)

  hide:SetText('Hide (h)')
  hide:SetPos(85, 4)

  nbLineGrid:SetPos(185, 6)
  nbColumnGrid:SetPos(270, 6)
end
