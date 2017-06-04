local engineKey,lightsKey = get("@jengine.engineKey"),get("@jengine.lightsKey")
thisResource = thisResource or getThisResource()

--Create functions for the engine state and light state
function changeEngineState(source)
    if not source:isInVehicle() then return end
	local sourceVehicle = source:getOccupiedVehicle()
	sourceVehicle.engineState = not sourceVehicle.engineState
	--setVehicleEngineState ( sourceVehicle, not getVehicleEngineState ( sourceVehicle ) )
end
function changeLightsState(source)
    if not source:isInVehicle() then return end
	local sourceVehicle = source:getOccupiedVehicle()
	sourceVehicle:overrideLights = if(sourceVehicle:getOverrideLights()~=2)then 2 else 1 end
	--[[if getVehicleOverrideLights ( sourceVehicle ) ~= 2 then
		setVehicleOverrideLights( sourceVehicle, 2 )
	else
		setVehicleOverrideLights( sourceVehicle, 1 )
	end]]
end

addEventHandler ( "onPlayerVehicleEnter",root,function( veh, driver, jacker )
    if driver ~= 0 or jacker then return end --Check if it's not the driver or if the vehicle is being jacked
	--setVehicleEngineState ( theVehicle, true ) --Turn engine on
	theVehicle.engineState = true
end)
addEventHandler ( "onPlayerVehicleExit",root,function( theVehicle, driver, jacker )
    if driver ~= 0 or jacker then return end --Check if it's not the driver or if the vehicle is being jacked
	--setVehicleEngineState ( theVehicle, false ) --Turn off the engine
	--setVehicleOverrideLights ( theVehicle, 1 ) --turn off the lights
	theVehicle.engineState = false
	theVehicle.overrideLights = 1
end)

--Key Bindings
addEventHandler ( "onResourceStart",resourceRoot,function(res)
	if res~= thisResource then return end
	for _,p in ipairs(getElementsByType("player")) do
		bindKey(p,engineKey, "down", changeEngineState )
		bindKey(p,lightsKey, "down", changeLightsState )
	end
end)
addEventHandler("onResourceStop",resourceRoot,function(res)
	if res~= thisResource then return end
	for _,p in ipairs(getElementsByType("player")) do
		unbindKey(p,engineKey, "down", changeEngineState )
		unbindKey(p,lightsKey, "down", changeLightsState )
	end
end)
addEventHandler ( "onPlayerJoin",root,function()
	bindKey (source,engineKey, "down", changeEngineState)
	bindKey(source,lightsKey, "down", changeLightsState)
end)
addEventHandler ( "onPlayerQuit",root,function()
	unbindKey (source,engineKey, "down", changeEngineState)
	unbindKey(source,lightsKey, "down", changeLightsState)
end)