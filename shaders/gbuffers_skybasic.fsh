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

//Vertex color.
varying vec4 color;
//Position in player space
varying vec3 pos;

void main()
{
    vec4 col = color;

    bool isStar = col.r == col.g && col.g == col.b && col.r > 0.3;
    bool isSunriseSunsetHorizon = col.r > col.g * 1.2;
    if (!isStar && !isSunriseSunsetHorizon) {
        float fog = 1.0 - max(normalize(pos).y - 0.06, 0.0);
        fog =
         0.7 * fog * fog * fog * fog * fog * fog * fog * fog
         + 0.3 * fog;
        col.rgb = mix(col.rgb, fogColor, fog);
    }

    //Output the result.
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = col;
}
