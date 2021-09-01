/*
    XorDev's "Default Shaderpack"

    This was put together by @XorDev to make it easier for anyone to make their own shaderpacks in Minecraft (Optifine).
    You can do whatever you want with this code! Credit is not necessary, but always appreciated!

    You can find more information about shaders in Optfine here:
    https://github.com/sp614x/optifine/blob/master/OptiFineDoc/doc/shaders.txt

*/
//Declare GL version.
#version 120

//0-1 amount of blindness.
uniform float blindness;
//0 = default, 1 = water, 2 = lava.
uniform int isEyeInWater;

//Vertex color.
varying vec4 color;

const int GL_LINEAR = 9729;
const int GL_EXP = 2048;
uniform int fogMode;

void main()
{
    vec4 col = color;


    //Calculate fog intensity in or out of water.
    float fog;
    if(fogMode == GL_EXP)
        fog = 1.-exp(-gl_FogFragCoord * gl_Fog.density);
    else if (fogMode == GL_LINEAR)
        fog = clamp((gl_FogFragCoord-gl_Fog.start) * gl_Fog.scale, 0., 1.);
    else if (isEyeInWater == 1.0 || isEyeInWater == 2.0)
        fog = 1.-exp(-gl_FogFragCoord * gl_Fog.density);

    //float fog = clamp((gl_FogFragCoord-gl_Fog.start) * gl_Fog.scale, 0., 1.);

    //Apply the fog.
    col.rgb = mix(col.rgb, gl_Fog.color.rgb, fog);

    //Output the result.
    gl_FragData[0] = col * vec4(vec3(1.-blindness),1);
}
