local widget = widget ---@type Widget

function widget:GetInfo()
	return {
		name = "Dark Epic Effect",
		desc = "Creates a scary dark epic fullscreen shader effect with greyish-reddish theme and noise glitches",
		author = "AI Assistant",
		date = "2024.12.19",
		license = "Lua code: GNU GPL, v2 or later, Shader GLSL code: (c) AI Assistant",
		layer = 1000,
		enabled = true,
		depends = {'gl4'},
	}
end

-- Configuration
local shaderConfig = {
	INTENSITY = 1.0,        -- Overall effect intensity (0.0 to 1.0)
	CONTRAST = 1.4,         -- Contrast multiplier
	NOISE_INTENSITY = 1.0,  -- Noise overlay intensity
	GLITCH_INTENSITY = 1.0, -- Glitch effect intensity
	DARK_COLOR_R = 0.4,     -- Dark overlay red component
	DARK_COLOR_G = 0.35,    -- Dark overlay green component  
	DARK_COLOR_B = 0.3,     -- Dark overlay blue component
	RED_TINT_R = 0.8,       -- Red tint red component
	RED_TINT_G = 0.3,       -- Red tint green component
	RED_TINT_B = 0.2,       -- Red tint blue component
}

-- Widget state
local darkEpicShader = nil
local effectEnabled = true
local intensity = 1.0
local contrast = 1.4
local noiseIntensity = 1.0
local glitchIntensity = 1.0
local darkColor = {0.4, 0.35, 0.3}
local redTint = {0.8, 0.3, 0.2}

-- GL4 Backend
local LuaShader = gl.LuaShader
local InstanceVBOTable = gl.InstanceVBOTable

-- Shader source paths
local vsSrcPath = "LuaUI/Shaders/dark_epic_effect.vert.glsl"
local fsSrcPath = "LuaUI/Shaders/dark_epic_effect.frag.glsl"

local function goodbye(reason)
	Spring.Echo("Dark Epic Effect widget exiting with reason: " .. reason)
	widgetHandler:RemoveWidget()
end

local function initGL4()
	if gl.CreateShader == nil then
		goodbye("GL4 not available")
		return false
	end

	-- Create shader
	local engineUniformBufferDefs = LuaShader.GetEngineUniformBufferDefs()
	
	local vsSrc = VFS.LoadFile(vsSrcPath)
	local fsSrc = VFS.LoadFile(fsSrcPath)
	
	if not vsSrc or not fsSrc then
		goodbye("Failed to load shader source files")
		return false
	end
	
	vsSrc = vsSrc:gsub("//__ENGINEUNIFORMBUFFERDEFS__", engineUniformBufferDefs)
	fsSrc = fsSrc:gsub("//__ENGINEUNIFORMBUFFERDEFS__", engineUniformBufferDefs)
	
	darkEpicShader = LuaShader({
		vertex = vsSrc:gsub("//__DEFINES__", LuaShader.CreateShaderDefinesString(shaderConfig)),
		fragment = fsSrc:gsub("//__DEFINES__", LuaShader.CreateShaderDefinesString(shaderConfig)),
		uniformFloat = {
			time = 0.0,
			intensity = intensity,
			contrast = contrast,
			noiseIntensity = noiseIntensity,
			glitchIntensity = glitchIntensity,
			darkColor = darkColor,
			redTint = redTint,
		},
	}, "DarkEpicEffectShader")
	
	local shaderCompiled = darkEpicShader:Initialize()
	if not shaderCompiled then
		goodbye("Failed to compile Dark Epic Effect shader")
		return false
	end
	
	-- No need for VBO - we'll use gl.Rect for full screen effect
	
	return true
end

local function DrawDarkEpicEffect()
	if not effectEnabled or not darkEpicShader then
		return
	end
	
	-- Get current time for animation
	local time = Spring.GetGameFrame() * 0.016 -- Convert to seconds
	
	-- Get camera position for full screen effect
	local camX, camY, camZ = Spring.GetCameraPosition()
	local camDirX, camDirY, camDirZ = Spring.GetCameraDirection()
	
	-- Activate shader
	darkEpicShader:Activate()
	
	-- Set uniforms
	darkEpicShader:SetUniform("time", time)
	darkEpicShader:SetUniform("intensity", intensity)
	darkEpicShader:SetUniform("contrast", contrast)
	darkEpicShader:SetUniform("noiseIntensity", noiseIntensity)
	darkEpicShader:SetUniform("glitchIntensity", glitchIntensity)
	darkEpicShader:SetUniform("darkColor", darkColor[1], darkColor[2], darkColor[3])
	darkEpicShader:SetUniform("redTint", redTint[1], redTint[2], redTint[3])
	
	-- Set blending mode for overlay effect
	gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
	
	-- Draw full screen effect using gl.Rect (similar to darken_map widget)
	gl.PushMatrix()
	gl.Translate(camX + (camDirX * 360), camY + (camDirY * 360), camZ + (camDirZ * 360))
	gl.Billboard()
	gl.Rect(-5000, -5000, 5000, 5000)
	gl.PopMatrix()
	
	-- Deactivate shader
	darkEpicShader:Deactivate()
	
	-- Reset blending
	gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA) -- Reset to default
end

-- Configuration functions
local function SetIntensity(value)
	intensity = math.max(0.0, math.min(1.0, value))
	Spring.Echo("Dark Epic Effect intensity set to: " .. intensity)
end

local function SetContrast(value)
	contrast = math.max(0.1, math.min(3.0, value))
	Spring.Echo("Dark Epic Effect contrast set to: " .. contrast)
end

local function SetNoiseIntensity(value)
	noiseIntensity = math.max(0.0, math.min(1.0, value))
	Spring.Echo("Dark Epic Effect noise intensity set to: " .. noiseIntensity)
end

local function SetGlitchIntensity(value)
	glitchIntensity = math.max(0.0, math.min(1.0, value))
	Spring.Echo("Dark Epic Effect glitch intensity set to: " .. glitchIntensity)
end

local function ToggleEffect()
	effectEnabled = not effectEnabled
	Spring.Echo("Dark Epic Effect " .. (effectEnabled and "enabled" or "disabled"))
end

-- Text command handler
function widget:TextCommand(command)
	if string.find(command, "darkepic", nil, true) then
		local words = {}
		for word in command:gmatch("%S+") do
			table.insert(words, word)
		end
		
		if words[2] == "intensity" and words[3] then
			SetIntensity(tonumber(words[3]))
		elseif words[2] == "contrast" and words[3] then
			SetContrast(tonumber(words[3]))
		elseif words[2] == "noise" and words[3] then
			SetNoiseIntensity(tonumber(words[3]))
		elseif words[2] == "glitch" and words[3] then
			SetGlitchIntensity(tonumber(words[3]))
		elseif words[2] == "toggle" then
			ToggleEffect()
		elseif words[2] == "reset" then
			intensity = 1.0
			contrast = 1.4
			noiseIntensity = 1.0
			glitchIntensity = 1.0
			Spring.Echo("Dark Epic Effect reset to defaults")
		else
			Spring.Echo("Dark Epic Effect commands:")
			Spring.Echo("  /darkepic intensity <0.0-1.0>")
			Spring.Echo("  /darkepic contrast <0.1-3.0>")
			Spring.Echo("  /darkepic noise <0.0-1.0>")
			Spring.Echo("  /darkepic glitch <0.0-1.0>")
			Spring.Echo("  /darkepic toggle")
			Spring.Echo("  /darkepic reset")
		end
		return true
	end
	return false
end

function widget:Initialize()
	if not initGL4() then
		return
	end
	
	-- Expose API
	WG['darkepiceffect'] = {
		setIntensity = SetIntensity,
		setContrast = SetContrast,
		setNoiseIntensity = SetNoiseIntensity,
		setGlitchIntensity = SetGlitchIntensity,
		toggle = ToggleEffect,
		isEnabled = function() return effectEnabled end,
	}
	
	Spring.Echo("Dark Epic Effect widget loaded successfully")
	Spring.Echo("Use /darkepic for commands")
end

function widget:Shutdown()
	WG['darkepiceffect'] = nil
end

-- Draw the effect after everything else
function widget:DrawScreen()
	DrawDarkEpicEffect()
end

-- Configuration persistence
function widget:GetConfigData()
	return {
		effectEnabled = effectEnabled,
		intensity = intensity,
		contrast = contrast,
		noiseIntensity = noiseIntensity,
		glitchIntensity = glitchIntensity,
		darkColor = darkColor,
		redTint = redTint,
	}
end

function widget:SetConfigData(data)
	if data.effectEnabled ~= nil then
		effectEnabled = data.effectEnabled
	end
	if data.intensity ~= nil then
		intensity = data.intensity
	end
	if data.contrast ~= nil then
		contrast = data.contrast
	end
	if data.noiseIntensity ~= nil then
		noiseIntensity = data.noiseIntensity
	end
	if data.glitchIntensity ~= nil then
		glitchIntensity = data.glitchIntensity
	end
	if data.darkColor ~= nil then
		darkColor = data.darkColor
	end
	if data.redTint ~= nil then
		redTint = data.redTint
	end
end
