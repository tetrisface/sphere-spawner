if gadgetHandler:IsSyncedCode() then
	return
end

function gadget:GetInfo() 
	return {
		name    = "test2",
		desc    = "",
		author  = "",
		date    = "2025-09-23",
		license = "",
		layer   = 50,
		enabled = true,
	} 
end

Spring.Echo('Hello from modtest2')