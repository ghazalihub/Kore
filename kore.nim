
# Kore 3 Nim Bindings

{.passC: "-Iincludes".}
{.passC: "-Ibackends/system/linux/includes".}
{.passC: "-Ibackends/system/posix/includes".}
{.passC: "-Ibackends/gpu/opengl/includes".}

type
  # global.h
  kore_ticks* = uint64

  # color.h
  kore_color* {.importc: "kore_color", header: "kore3/color.h", bycopy.} = object
    red*, green*, blue*, alpha*: uint8

  # system.h
  kore_gpu_api* {.pure.} = enum
    DIRECT3D11,
    DIRECT3D12,
    VULKAN,
    METAL,
    WEBGPU,
    OPENGL,
    KOMPJUTA,
    CONSOLE

  # window.h
  kore_window_mode* {.pure.} = enum
    WINDOW,
    FULLSCREEN,
    EXCLUSIVE_FULLSCREEN

  kore_window_parameters* {.importc: "kore_window_parameters", header: "kore3/window.h", bycopy.} = object
    title*: cstring
    x*, y*, width*, height*, display_index*: cint
    visible*: bool
    window_features*: cint
    mode*: kore_window_mode

  kore_framebuffer_parameters* {.importc: "kore_framebuffer_parameters", header: "kore3/window.h", bycopy.} = object
    frequency*: cint
    vertical_sync*: bool
    color_bits*, depth_bits*, stencil_bits*, samples_per_pixel*: cint

  # gpu/textureformat.h
  kore_gpu_texture_format* {.pure.} = enum
    UNDEFINED,
    R8_UNORM,
    R8_SNORM,
    R8_UINT,
    R8_SINT,
    R16_UINT,
    R16_SINT,
    R16_FLOAT,
    RG8_UNORM,
    RG8_SNORM,
    RG8_UINT,
    RG8_SINT,
    R32_UINT,
    R32_SINT,
    R32_FLOAT,
    RG16_UINT,
    RG16_SINT,
    RG16_FLOAT,
    RGBA8_UNORM,
    RGBA8_UNORM_SRGB,
    RGBA8_SNORM,
    RGBA8_UINT,
    RGBA8_SINT,
    BGRA8_UNORM,
    BGRA8_UNORM_SRGB,
    RGB9E5U_FLOAT,
    RGB10A2_UINT,
    RGB10A2_UNORM,
    RG11B10U_FLOAT,
    RG32_UINT,
    RG32_SINT,
    RG32_FLOAT,
    RGBA16_UINT,
    RGBA16_SINT,
    RGBA16_FLOAT,
    RGBA32_UINT,
    RGBA32_SINT,
    RGBA32_FLOAT,
    DEPTH16_UNORM,
    DEPTH24_NOTHING8,
    DEPTH24_STENCIL8,
    DEPTH32_FLOAT,
    DEPTH32_FLOAT_STENCIL8_NOTHING24

  # gpu/texture.h
  kore_gpu_texture* {.importc: "kore_gpu_texture", header: "kore3/gpu/texture.h", bycopy.} = object
    width*, height*: uint32
    format*: kore_gpu_texture_format
    # backend specific fields follow

  kore_gpu_texture_view_dimension* {.pure.} = enum
    DIMENSION_1D,
    DIMENSION_2D,
    DIMENSION_2DARRAY,
    CUBE,
    CUBEARRAY,
    DIMENSION_3D

  kore_gpu_texture_aspect* {.pure.} = enum
    ALL,
    DEPTH_ONLY,
    STENCIL_ONLY

  kore_gpu_texture_view* {.importc: "kore_gpu_texture_view", header: "kore3/gpu/texture.h", bycopy.} = object
    texture*: ptr kore_gpu_texture
    format*: kore_gpu_texture_format
    dimension*: kore_gpu_texture_view_dimension
    aspect*: kore_gpu_texture_aspect
    base_mip_level*: uint32
    mip_level_count*: uint32
    base_array_layer*: uint32
    array_layer_count*: uint32

  # gpu/commandlist.h
  kore_gpu_load_op* {.pure.} = enum
    LOAD,
    CLEAR

  kore_gpu_store_op* {.pure.} = enum
    STORE,
    DISCARD

  kore_gpu_color* {.importc: "kore_gpu_color", header: "kore3/gpu/commandlist.h", bycopy.} = object
    r*, g*, b*, a*: float32

  kore_gpu_render_pass_color_attachment* {.importc: "kore_gpu_render_pass_color_attachment", header: "kore3/gpu/commandlist.h", bycopy.} = object
    texture*: kore_gpu_texture_view
    depth_slice*: uint32
    resolve_target*: kore_gpu_texture_view
    clear_value*: kore_gpu_color
    load_op*: kore_gpu_load_op
    store_op*: kore_gpu_store_op

  kore_gpu_render_pass_depth_stencil_attachment* {.importc: "kore_gpu_render_pass_depth_stencil_attachment", header: "kore3/gpu/commandlist.h", bycopy.} = object
    texture*: ptr kore_gpu_texture
    depth_clear_value*: float32
    depth_load_op*: kore_gpu_load_op
    depth_store_op*: kore_gpu_store_op
    depth_read_only*: bool
    stencil_clear_value*: uint32
    stencil_load_op*: kore_gpu_load_op
    stencil_store_op*: kore_gpu_store_op
    stencil_read_only*: bool

  kore_gpu_render_pass_timestamp_writes* {.importc: "kore_gpu_render_pass_timestamp_writes", header: "kore3/gpu/commandlist.h", bycopy.} = object
    query_set*: pointer
    beginning_of_pass_write_index*: uint32
    end_of_pass_write_index*: uint32

  kore_gpu_render_pass_parameters* {.importc: "kore_gpu_render_pass_parameters", header: "kore3/gpu/commandlist.h", bycopy.} = object
    color_attachments*: array[8, kore_gpu_render_pass_color_attachment]
    color_attachments_count*: int
    depth_stencil_attachment*: kore_gpu_render_pass_depth_stencil_attachment
    occlusion_query_set*: pointer
    timestamp_writes*: kore_gpu_render_pass_timestamp_writes

  kore_gpu_command_list* {.importc: "kore_gpu_command_list", header: "kore3/gpu/commandlist.h", bycopy.} = object
    # backend specific fields follow
    dummy: array[1024, byte]

  # gpu/device.h
  kore_gpu_device* {.importc: "kore_gpu_device", header: "kore3/gpu/device.h", bycopy.} = object
    # backend specific fields follow
    dummy: array[1024, byte]

  kore_gpu_buffer* {.importc: "kore_gpu_buffer", header: "kore3/gpu/buffer.h", bycopy.} = object
    usage_flags*: uint32
    # backend specific fields follow
    dummy: array[1024, byte]

  # OpenGL specific structs from backend
  kore_opengl_render_pipeline* {.importc: "kore_opengl_render_pipeline", header: "kore3/opengl/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

  kore_opengl_render_pipeline_parameters* {.importc: "kore_opengl_render_pipeline_parameters", header: "kore3/opengl/pipeline_structs.h", bycopy.} = object
    dummy: array[4096, byte]

# --- Procedures ---

# system.h
proc kore_init*(name: cstring, width, height: cint, win: ptr kore_window_parameters, frame: ptr kore_framebuffer_parameters): cint {.importc: "kore_init", header: "kore3/system.h".}
proc kore_start*() {.importc: "kore_start", header: "kore3/system.h".}
proc kore_stop*() {.importc: "kore_stop", header: "kore3/system.h".}
proc kore_time*(): float64 {.importc: "kore_time", header: "kore3/system.h".}
proc kore_set_update_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_update_callback", header: "kore3/system.h".}

# window.h
proc kore_window_options_set_defaults*(win: ptr kore_window_parameters) {.importc: "kore_window_options_set_defaults", header: "kore3/window.h".}
proc kore_framebuffer_options_set_defaults*(frame: ptr kore_framebuffer_parameters) {.importc: "kore_framebuffer_options_set_defaults", header: "kore3/window.h".}

# gpu/gpu.h
proc kore_gpu_init*(api: kore_gpu_api) {.importc: "kore_gpu_init", header: "kore3/gpu/gpu.h".}

# gpu/device.h
proc kore_gpu_device_create*(device: ptr kore_gpu_device, wishlist: pointer) {.importc: "kore_gpu_device_create", header: "kore3/gpu/device.h".}
proc kore_gpu_device_get_framebuffer*(device: ptr kore_gpu_device): ptr kore_gpu_texture {.importc: "kore_gpu_device_get_framebuffer", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_command_list*(device: ptr kore_gpu_device, `type`: cint, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_create_command_list", header: "kore3/gpu/device.h".}
proc kore_gpu_device_execute_command_list*(device: ptr kore_gpu_device, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_execute_command_list", header: "kore3/gpu/device.h".}

# gpu/commandlist.h
proc kore_gpu_command_list_begin_render_pass*(list: ptr kore_gpu_command_list, parameters: ptr kore_gpu_render_pass_parameters) {.importc: "kore_gpu_command_list_begin_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_end_render_pass*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_end_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_present*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_present", header: "kore3/gpu/commandlist.h".}

# OpenGL Pipeline (from backend functions)
proc kore_opengl_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_opengl_render_pipeline, parameters: ptr kore_opengl_render_pipeline_parameters) {.importc: "kore_opengl_render_pipeline_init", header: "kore3/opengl/pipeline_functions.h".}
proc kore_opengl_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_opengl_render_pipeline) {.importc: "kore_opengl_command_list_set_render_pipeline", header: "kore3/opengl/commandlist_functions.h".}

# mouse.h
proc kore_mouse_set_press_callback*(value: proc(window, button, x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_press_callback", header: "kore3/input/mouse.h".}
