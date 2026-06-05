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

//Vertex color.
varying vec4 color;
//Diffuse texture coordinates.
varying vec2 coord0;

void main()
{
    //Visibility amount.
    vec3 light = vec3(1.0-blindness);
    //Sample texture times Visibility.
    vec4 col = color * vec4(light,1.0) * texture2D(texture,coord0);

    //Calculate and apply fog.
    float fog;
    if(fogMode == GL_LINEAR){
        fog = clamp((gl_FogFragCoord-gl_Fog.start) * gl_Fog.scale, 0.0, 1.0);
    } else if(fogMode == GL_EXP || isEyeInWater >= 1){
        fog = clamp(1.0-exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0);
    }
    col.rgb = mix(col.rgb, fogColor, fog);

    //Output the result.
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = col;
}
