local wind = GuiWindow(500,500,250,250,"Test",false)
GuiLabel(250/2-50,250/2-100,100,100,"Testing",false,wind)
local test = GuiLabel(0,0,100,100,"Testing Testing",false,guiRoot)
test:setParent(wind)
test:setPosition(250/2-50,250/2,false)

--Cant set gui parent to anything