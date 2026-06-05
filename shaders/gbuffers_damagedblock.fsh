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

    //Output the result.
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = col;
}
