/*
    XorDev's "Default Shaderpack"

    This was put together by @XorDev to make it easier for anyone to make their own shaderpacks in Minecraft (Optifine).
    You can do whatever you want with this code! Credit is not necessary, but always appreciated!

    You can find more information about shaders in Optfine here:
    https://github.com/sp614x/optifine/blob/master/OptiFineDoc/doc/shaders.txt

*/
//Declare GL version.
#version 120

//Include common code
#include "/common.glsl"

uniform sampler2D texture;
//This is set to the 'lightmap' texture in shaders.properties (Lighting from day/night + shadows + light sources.)
uniform sampler2D colortex2;

varying vec2 coord0;

void main()
{
    vec3 col = texture2D(texture,coord0).rgb;
    
    //Vanilla vignette seems to have its own variable strength, but I'm not sure how to access that strength value, so it is calculated according to the lightmap value for the player's current position
    vec3 lightmapColor = texture2D(colortex2, eyeBrightnessSmooth/240.0 * 14.0/16.0 + 1.0 / 16.0).rgb;
    float vignetteStrength = mix(1.0, 0.1, getLum(lightmapColor));
    vec2 vignetteCoord = coord0 - 0.5;
    col *= 1.0 - length(vignetteCoord) * vignetteStrength;
    
    //Add some dithering to help decrease color banding
    col += (fract(52.9829189 * fract(0.06711056 * gl_FragCoord.x + 0.00583715 * gl_FragCoord.y + 0.0003181 * frameCounter)) - 0.5) / 255.0;
    
    gl_FragData[0] = vec4(col,1);
}
