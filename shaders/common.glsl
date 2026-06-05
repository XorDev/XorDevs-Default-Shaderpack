//User settings (none)



//Uniforms

uniform int fogMode;
uniform vec3 fogColor;

//0-1 amount of blindness 
uniform float blindness;

//0 = default, 1 = water, 2 = lava
uniform int isEyeInWater;

//Ranges from 0 to 240, x = block brightness, y = sky brightness
uniform ivec2 eyeBrightnessSmooth;

//Transforms positions from model space (which is the format given to vsh shaders) to view space (which is centered around the camera)
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

//Counts the number of rendered frames
uniform int frameCounter;



//Constants

//The 'fogMode' uniform must be one of these
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;



//Functions

//Note: this expects colors that are not gamma-corrected
float getLum(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}
