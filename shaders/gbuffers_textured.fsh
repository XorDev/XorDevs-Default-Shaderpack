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

//Diffuse (color) texture.
uniform sampler2D texture;
//Lighting from day/night + shadows + light sources.
uniform sampler2D lightmap;

//RGB+intensity for hurt entities and flashing creepers. (this uniform can only be used in the 'gbuffers_entities' shader, which is this shader unless you fill in the gbuffers_entities shader)
uniform vec4 entityColor;

//Vertex color.
varying vec4 color;
//Diffuse and lightmap texture coordinates.
varying vec2 coord0;
varying vec2 coord1;

void main()
{
    //Combine lightmap with blindness.
    vec3 light = (1.0-blindness) * texture2D(lightmap,coord1).rgb;
    //Sample texture times lighting.
    vec4 col = color * vec4(light,1.0) * texture2D(texture,coord0);
    //Apply entity flashes.
    col.rgb = mix(col.rgb,entityColor.rgb,entityColor.a);

    //Calculate and apply fog.
    float fog;
    if(fogMode == GL_LINEAR){
        fog = clamp((gl_FogFragCoord-gl_Fog.start) * gl_Fog.scale, 0.0, 1.0);
    } else if(fogMode == GL_EXP || isEyeInWater >= 1){
        fog = clamp(1.0-exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0);
    }
    col.rgb = mix(col.rgb, fogColor, fog);

    //Add some dithering to help decrease color banding
    col.rgb += (fract(52.9829189 * fract(0.06711056 * gl_FragCoord.x + 0.00583715 * gl_FragCoord.y + 0.0003181 * frameCounter)) - 0.5) / 255.0;

    //Output the result.
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = col;
}
