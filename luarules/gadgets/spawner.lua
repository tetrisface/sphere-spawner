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
			-- find a random enemy unit
			local enemyUnitID = Spring.GetUnitNearestEnemy(unitID, 100000)
			if enemyUnitID then
				Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {enemyUnitID}, {})
			end
		end

		-- randomly select a unit that has no order and give it an attack order
		local units = Spring.GetTeamUnits(gaiaTeamID)
		local randomUnitID = units[math.random(1, #units)]
		local enemyUnitID = Spring.GetUnitNearestEnemy(randomUnitID, 100000)
		if enemyUnitID and randomUnitID and Spring.GetUnitCommandCount(randomUnitID) == 0 then
			Spring.GiveOrderToUnit(randomUnitID, CMD.ATTACK, {enemyUnitID}, {})
		end
	end
end
