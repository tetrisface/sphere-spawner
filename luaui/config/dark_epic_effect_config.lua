-- Dark Epic Effect Configuration
-- This file contains all the configurable parameters for the dark epic shader effect

return {
	-- Effect intensity (0.0 = off, 1.0 = maximum)
	intensity = 1.0,
	
	-- Contrast multiplier (0.1 = very low, 3.0 = very high)
	contrast = 1.4,
	
	-- Noise overlay intensity (0.0 = no noise, 1.0 = maximum noise)
	noiseIntensity = 1.0,
	
	-- Glitch effect intensity (0.0 = no glitches, 1.0 = maximum glitches)
	glitchIntensity = 1.0,
	
	-- Dark overlay color (RGB values 0.0-1.0)
	darkColor = {
		r = 0.4,   -- Red component
		g = 0.35,  -- Green component
		b = 0.3,   -- Blue component
	},
	
	-- Red tint color (RGB values 0.0-1.0)
	redTint = {
		r = 0.8,   -- Red component
		g = 0.3,   -- Green component
		b = 0.2,   -- Blue component
	},
	
	-- Animation speed multiplier
	animationSpeed = 1.0,
	
	-- Vignette strength (0.0 = no vignette, 1.0 = strong vignette)
	vignetteStrength = 0.6,
	
	-- Color bleeding intensity (0.0 = no bleeding, 1.0 = maximum bleeding)
	colorBleeding = 0.1,
	
	-- Preset configurations
	presets = {
		subtle = {
			intensity = 0.3,
			contrast = 1.2,
			noiseIntensity = 0.1,
			glitchIntensity = 0.1,
		},
		moderate = {
			intensity = 1.0,
			contrast = 1.4,
			noiseIntensity = 1.0,
			glitchIntensity = 1.0,
		},
		extreme = {
			intensity = 1.0,
			contrast = 2.5,
			noiseIntensity = 0.6,
			glitchIntensity = 0.8,
		},
		anime = {
			intensity = 0.8,
			contrast = 2.2,
			noiseIntensity = 0.4,
			glitchIntensity = 0.3,
			darkColor = {r = 0.15, g = 0.1, b = 0.05},
			redTint = {r = 0.9, g = 0.2, b = 0.1},
		},
	}
}
