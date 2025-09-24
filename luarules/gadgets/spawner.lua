if not gadgetHandler:IsSyncedCode() then
	return
end

function gadget:GetInfo()
	return {
		name = 'spawner',
		desc = 'Spawns sphere units for gaia team',
		author = '',
		date = '2025-09-24',
		license = '',
		layer = 50,
		enabled = true
	}
end

local sphereUnitDefID = UnitDefNames['legohelios'].id
local gaiaTeamID = Spring.GetGaiaTeamID()

function gadget:GameFrame(frame)
	-- Spawn a sphere unit every second (30 frames at 30fps)
	if frame % Game.gameSpeed == 0 then
		-- Get a random position on the map
		local mapSizeX = Game.mapSizeX
		local mapSizeZ = Game.mapSizeZ
		local x = math.random(0, mapSizeX)
		local z = math.random(0, mapSizeZ)
		local y = Spring.GetGroundHeight(x, z)

		-- Spawn the sphere unit for gaia team
		local unitID = Spring.CreateUnit(sphereUnitDefID, x, y, z, 0, gaiaTeamID)

		if unitID then
			-- Make it attack everyone (set to aggressive stance)
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT, {}, {})
		end
	end
end
