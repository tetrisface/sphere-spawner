#version 420
#extension GL_ARB_uniform_buffer_object : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_shading_language_420pack: require

//__ENGINEUNIFORMBUFFERDEFS__
//__DEFINES__

layout (location = 0) in vec4 position; // x, y, z, w

out vec2 v_texCoord;
out vec4 v_position;

void main()
{
    v_texCoord = position.xy * 0.5 + 0.5;
    v_position = position;
    gl_Position = position;
}
