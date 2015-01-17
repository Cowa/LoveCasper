VisiblePanel   = true
Panel = Gui.Create('panel')
local play  = Gui.Create('button', Panel)
local hide  = Gui.Create('button', Panel)

function setUpGui()
  play.OnClick = function()
    Paused = not Paused
  end

  hide.OnClick = function()
    VisiblePanel = not VisiblePanel
    Panel:SetVisible(VisiblePanel)
  end
end

function resizeGui()
  Panel:SetPos(0, 0)
  Panel:SetSize(WindowWidth, 32)

  play:SetText("Play/Pause")
  play:SetPos(4, 4)

  hide:SetText('Hide (h)')
  hide:SetPos(85, 4)
end
