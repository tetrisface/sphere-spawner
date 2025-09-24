#version 330
#extension GL_ARB_uniform_buffer_object : require
#extension GL_ARB_shading_language_420pack: require

//__ENGINEUNIFORMBUFFERDEFS__
//__DEFINES__

in vec2 v_texCoord;
in vec4 v_position;

uniform float time;
uniform float intensity;
uniform float contrast;
uniform float noiseIntensity;
uniform float glitchIntensity;
uniform vec3 darkColor;
uniform vec3 redTint;

out vec4 fragColor;

// Noise function
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// Improved noise function
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// Fractal noise
float fbm(vec2 st) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 0.0;
    
    for (int i = 0; i < 6; i++) {
        value += amplitude * noise(st);
        st *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

// Glitch effect with vertical lines
vec2 glitch(vec2 uv, float time) {
    float glitchNoise = noise(vec2(time * 10.0, uv.x * 100.0));
    float glitchAmount = step(0.95, glitchNoise) * glitchIntensity;
    
    // Create vertical distortion
    uv.x += sin(uv.x * 80.0 + time * 25.0) * glitchAmount * 0.15;
    uv.y += sin(uv.x * 60.0 + time * 20.0) * glitchAmount * 0.08;
    
    return uv;
}

// Vignette effect
float vignette(vec2 uv) {
    float dist = distance(uv, vec2(0.5));
    return 1.0 - smoothstep(0.3, 0.8, dist);
}

void main()
{
    vec2 uv = v_texCoord;
    
    // Apply glitch distortion
    uv = glitch(uv, time);
    
    // Create base color (we'll create our own instead of sampling screen)
    vec3 baseColor = vec3(0.5, 0.5, 0.5); // Start with neutral gray
    
    // Create noise overlay
    float noiseValue = fbm(uv * 8.0 + time * 0.5);
    float noiseValue2 = fbm(uv * 16.0 - time * 0.3);
    
    // Combine noise for more complex pattern
    float combinedNoise = (noiseValue + noiseValue2 * 0.5) * noiseIntensity;
    
    // Create vertical glitch lines with random durations
    float linePosition = floor(uv.x * 100.0);
    float lineSeed = random(vec2(linePosition, 0.0));
    
    // Create random on/off cycles for each line
    float cycleTime = 2.0 + lineSeed * 3.0; // Random cycle duration 2-5 seconds
    float cyclePhase = mod(time, cycleTime) / cycleTime;
    
    // Each line has a random "on" duration within its cycle
    float onDuration = 0.1 + lineSeed * 0.4; // Random on duration 0.1-0.5 seconds
    float onPhase = onDuration / cycleTime;
    
    // Determine if this line should be visible
    float glitchLine = step(cyclePhase, onPhase) * step(0.95, lineSeed);
    combinedNoise += glitchLine * glitchIntensity * 0.3;
    
    // Add persistent glitch artifacts that last longer
    float artifactSeed = random(vec2(linePosition, 1.0));
    float artifactCycle = 5.0 + artifactSeed * 8.0; // Longer cycles 5-13 seconds
    float artifactPhase = mod(time, artifactCycle) / artifactCycle;
    float artifactDuration = 0.5 + artifactSeed * 2.0; // Longer duration 0.5-2.5 seconds
    float artifactOnPhase = artifactDuration / artifactCycle;
    
    // Create persistent glitch artifacts
    float persistentGlitch = step(artifactPhase, artifactOnPhase) * step(0.98, artifactSeed);
    combinedNoise += persistentGlitch * glitchIntensity * 0.2;
    
    // Add some flickering lines that appear and disappear randomly
    float flickerSeed = random(vec2(linePosition, 2.0));
    float flickerTime = time * (0.5 + flickerSeed * 2.0); // Variable flicker speed
    float flickerPattern = sin(flickerTime) * 0.5 + 0.5;
    float flickerLine = step(0.7, flickerPattern) * step(0.97, flickerSeed);
    combinedNoise += flickerLine * glitchIntensity * 0.15;
    
    // Apply dark color overlay
    vec3 darkOverlay = mix(vec3(1.0), darkColor, intensity);
    
    // Apply red tint
    vec3 redOverlay = mix(vec3(1.0), redTint, intensity * 0.3);
    
    // Combine overlays
    vec3 colorOverlay = darkOverlay * redOverlay;
    
    // Apply contrast to base color
    vec3 finalColor = baseColor * colorOverlay;
    finalColor = (finalColor - 0.5) * contrast + 0.5;
    
    // Add noise
    finalColor += (combinedNoise - 0.5) * 0.2;
    
    // Apply vignette
    float vig = vignette(uv);
    finalColor *= vig;
    
    // Add some color bleeding effect
    float bleed = noise(vec2(uv.x + time * 0.1, uv.y)) * intensity * 0.1;
    finalColor.r += bleed;
    finalColor.g -= bleed * 0.5;
    finalColor.b -= bleed * 0.3;
    
    // Clamp values
    finalColor = clamp(finalColor, 0.0, 1.0);
    
    // Set alpha based on intensity
    float alpha = intensity * 0.8; // Make it semi-transparent overlay
    
    fragColor = vec4(finalColor, alpha);
}
