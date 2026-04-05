
# Kore 3 Nim Bindings - Exhaustive Comprehensive Integration

{.passC: "-Iincludes".}
{.passC: "-Ibackends/system/linux/includes".}
{.passC: "-Ibackends/system/posix/includes".}
{.passC: "-Ibackends/gpu/opengl/includes".}

type
  # --- global.h ---
  kore_ticks* = uint64

  # --- log.h ---
  kore_log_level* {.pure.} = enum
    INFO,
    WARNING,
    ERROR

  # --- color.h ---
  kore_color* {.importc: "kore_color", header: "kore3/color.h", bycopy.} = object
    red*, green*, blue*, alpha*: uint8

  # --- system.h ---
  kore_gpu_api* {.pure.} = enum
    DIRECT3D11,
    DIRECT3D12,
    VULKAN,
    METAL,
    WEBGPU,
    OPENGL,
    KOMPJUTA,
    CONSOLE

  # --- window.h ---
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

  # --- gpu/textureformat.h ---
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

  # --- gpu/texture.h ---
  kore_gpu_texture* {.importc: "kore_gpu_texture", header: "kore3/gpu/texture.h", bycopy.} = object
    width*, height*: uint32
    format*: kore_gpu_texture_format

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

  # --- gpu/commandlist.h ---
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

  kore_gpu_render_pass_parameters* {.importc: "kore_gpu_render_pass_parameters", header: "kore3/gpu/commandlist.h", bycopy.} = object
    color_attachments*: array[8, kore_gpu_render_pass_color_attachment]
    color_attachments_count*: int
    depth_stencil_attachment*: kore_gpu_render_pass_depth_stencil_attachment
    occlusion_query_set*: pointer
    timestamp_writes*: pointer

  kore_gpu_command_list* {.importc: "kore_gpu_command_list", header: "kore3/gpu/commandlist.h", bycopy.} = object
    dummy: array[1024, byte]

  # --- gpu/device.h ---
  kore_gpu_device* {.importc: "kore_gpu_device", header: "kore3/gpu/device.h", bycopy.} = object
    dummy: array[1024, byte]

  kore_gpu_buffer* {.importc: "kore_gpu_buffer", header: "kore3/gpu/buffer.h", bycopy.} = object
    usage_flags*: uint32
    dummy: array[1024, byte]

  # --- gpu/sampler.h ---
  kore_gpu_address_mode* {.pure.} = enum
    CLAMP_TO_EDGE,
    REPEAT,
    MIRROR_REPEAT

  kore_gpu_filter_mode* {.pure.} = enum
    NEAREST,
    LINEAR

  kore_gpu_mipmap_filter_mode* {.pure.} = enum
    NEAREST,
    LINEAR

  kore_gpu_compare_function* {.pure.} = enum
    UNDEFINED,
    NEVER,
    LESS,
    EQUAL,
    LESS_EQUAL,
    GREATER,
    NOT_EQUAL,
    GREATER_EQUAL,
    ALWAYS

  kore_gpu_sampler_parameters* {.importc: "kore_gpu_sampler_parameters", header: "kore3/gpu/device.h", bycopy.} = object
    address_mode_u*, address_mode_v*, address_mode_w*: kore_gpu_address_mode
    min_filter*, mag_filter*: kore_gpu_filter_mode
    mipmap_filter*: kore_gpu_mipmap_filter_mode
    lod_min_clamp*, lod_max_clamp*: float32
    compare*: kore_gpu_compare_function
    max_anisotropy*: uint16

  kore_gpu_sampler* {.importc: "kore_gpu_sampler", header: "kore3/gpu/sampler.h", bycopy.} = object
    dummy: array[256, byte]

  # --- gpu/fence.h ---
  kore_gpu_fence* {.importc: "kore_gpu_fence", header: "kore3/gpu/fence.h", bycopy.} = object
    dummy: array[256, byte]

  # --- OpenGL specific (backend headers) ---
  kore_opengl_render_pipeline* {.importc: "kore_opengl_render_pipeline", header: "kore3/opengl/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

  kore_opengl_render_pipeline_parameters* {.importc: "kore_opengl_render_pipeline_parameters", header: "kore3/opengl/pipeline_structs.h", bycopy.} = object
    dummy: array[4096, byte]

  # --- math headers ---
  kore_matrix3x3* {.importc: "kore_matrix3x3", header: "kore3/math/matrix.h", bycopy.} = object
    m*: array[9, float32]

  kore_matrix4x4* {.importc: "kore_matrix4x4", header: "kore3/math/matrix.h", bycopy.} = object
    matrix*: array[16, float32]

  kore_vector2* {.importc: "kore_float2", header: "kore3/math/vector.h", bycopy.} = object
    x*, y*: float32

  kore_vector3* {.importc: "kore_float3", header: "kore3/math/vector.h", bycopy.} = object
    x*, y*, z*: float32

  kore_vector4* {.importc: "kore_float4", header: "kore3/math/vector.h", bycopy.} = object
    x*, y*, z*, w*: float32

  kore_quaternion* {.importc: "kore_quaternion", header: "kore3/math/quaternion.h", bycopy.} = object
    x*, y*, z*, w*: float32

  # --- image.h ---
  kore_image_compression* {.pure.} = enum
    NONE,
    DXT5,
    ASTC,
    PVRTC

  kore_image_format* {.pure.} = enum
    RGBA32,
    GREY8,
    RGB24,
    RGBA128,
    RGBA64,
    A32,
    BGRA32,
    A16

  kore_image* {.importc: "kore_image", header: "kore3/image.h", bycopy.} = object
    width*, height*, depth*: cint
    format*: kore_image_format
    internal_format*: cuint
    compression*: kore_image_compression
    data*: pointer
    data_size*: int

  # --- audio.h ---
  kore_audio_buffer* {.importc: "kore_audio_buffer", header: "kore3/audio/audio.h", bycopy.} = object
    channel_count*: uint8
    channels*: array[8, ptr float32]
    data_size*: uint32
    read_location*: uint32
    write_location*: uint32

  # --- io headers ---
  kore_file_type* {.pure.} = enum
    ASSET,
    SAVE

  kore_file_reader* {.importc: "kore_file_reader", header: "kore3/io/filereader.h", bycopy.} = object
    dummy: array[1024, byte]

  # --- mixer headers ---
  kore_sound* {.importc: "kore_sound", header: "kore3/mixer/sound.h", bycopy.} = object
    dummy: array[256, byte]

  # --- network headers ---
  kore_socket_protocol* {.pure.} = enum
    UDP,
    TCP

  kore_socket_family* {.pure.} = enum
    IP4,
    IP6

  kore_socket* {.importc: "kore_socket", header: "kore3/network/socket.h", bycopy.} = object
    handle*: cint
    host*, port*: uint32
    protocol*: kore_socket_protocol
    family*: kore_socket_family
    connected*: bool

# --- Procedures ---

# log.h
proc kore_log*(log_level: kore_log_level, format: cstring) {.importc: "kore_log", header: "kore3/log.h", varargs.}

# error.h
proc kore_affirm*(condition: bool) {.importc: "kore_affirm", header: "kore3/error.h".}
proc kore_affirm_message*(condition: bool, format: cstring) {.importc: "kore_affirm_message", header: "kore3/error.h", varargs.}
proc kore_error*() {.importc: "kore_error", header: "kore3/error.h".}
proc kore_error_message*(format: cstring) {.importc: "kore_error_message", header: "kore3/error.h", varargs.}

# system.h
proc kore_init*(name: cstring, width, height: cint, win: ptr kore_window_parameters, frame: ptr kore_framebuffer_parameters): cint {.importc: "kore_init", header: "kore3/system.h".}
proc kore_application_name*(): cstring {.importc: "kore_application_name", header: "kore3/system.h".}
proc kore_set_application_name*(name: cstring) {.importc: "kore_set_application_name", header: "kore3/system.h".}
proc kore_width*(): cint {.importc: "kore_width", header: "kore3/system.h".}
proc kore_height*(): cint {.importc: "kore_height", header: "kore3/system.h".}
proc kore_load_url*(url: cstring) {.importc: "kore_load_url", header: "kore3/system.h".}
proc kore_system_id*(): cstring {.importc: "kore_system_id", header: "kore3/system.h".}
proc kore_language*(): cstring {.importc: "kore_language", header: "kore3/system.h".}
proc kore_vibrate*(milliseconds: cint) {.importc: "kore_vibrate", header: "kore3/system.h".}
proc kore_safe_zone*(): float32 {.importc: "kore_safe_zone", header: "kore3/system.h".}
proc kore_automatic_safe_zone*(): bool {.importc: "kore_automatic_safe_zone", header: "kore3/system.h".}
proc kore_set_safe_zone*(value: float32) {.importc: "kore_set_safe_zone", header: "kore3/system.h".}
proc kore_frequency*(): float64 {.importc: "kore_frequency", header: "kore3/system.h".}
proc kore_timestamp*(): kore_ticks {.importc: "kore_timestamp", header: "kore3/system.h".}
proc kore_cpu_cores*(): cint {.importc: "kore_cpu_cores", header: "kore3/system.h".}
proc kore_hardware_threads*(): cint {.importc: "kore_hardware_threads", header: "kore3/system.h".}
proc kore_time*(): float64 {.importc: "kore_time", header: "kore3/system.h".}
proc kore_start*() {.importc: "kore_start", header: "kore3/system.h".}
proc kore_stop*() {.importc: "kore_stop", header: "kore3/system.h".}
proc kore_copy_to_clipboard*(text: cstring) {.importc: "kore_copy_to_clipboard", header: "kore3/system.h".}

# callbacks
proc kore_set_update_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_update_callback", header: "kore3/system.h".}
proc kore_set_foreground_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_foreground_callback", header: "kore3/system.h".}
proc kore_set_resume_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_resume_callback", header: "kore3/system.h".}
proc kore_set_pause_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_pause_callback", header: "kore3/system.h".}
proc kore_set_background_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_background_callback", header: "kore3/system.h".}
proc kore_set_shutdown_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_shutdown_callback", header: "kore3/system.h".}
proc kore_set_drop_files_callback*(callback: proc(file: ptr cstring, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_drop_files_callback", header: "kore3/system.h".}

# window.h
proc kore_window_create*(win: ptr kore_window_parameters, frame: ptr kore_framebuffer_parameters): cint {.importc: "kore_window_create", header: "kore3/window.h".}
proc kore_window_destroy*(window: cint) {.importc: "kore_window_destroy", header: "kore3/window.h".}
proc kore_window_options_set_defaults*(win: ptr kore_window_parameters) {.importc: "kore_window_options_set_defaults", header: "kore3/window.h".}
proc kore_framebuffer_options_set_defaults*(frame: ptr kore_framebuffer_parameters) {.importc: "kore_framebuffer_options_set_defaults", header: "kore3/window.h".}
proc kore_count_windows*(): cint {.importc: "kore_count_windows", header: "kore3/window.h".}
proc kore_window_resize*(window, width, height: cint) {.importc: "kore_window_resize", header: "kore3/window.h".}
proc kore_window_move*(window, x, y: cint) {.importc: "kore_window_move", header: "kore3/window.h".}
proc kore_window_change_mode*(window: cint, mode: kore_window_mode) {.importc: "kore_window_change_mode", header: "kore3/window.h".}
proc kore_window_x*(window: cint): cint {.importc: "kore_window_x", header: "kore3/window.h".}
proc kore_window_y*(window: cint): cint {.importc: "kore_window_y", header: "kore3/window.h".}
proc kore_window_width*(window: cint): cint {.importc: "kore_window_width", header: "kore3/window.h".}
proc kore_window_height*(window: cint): cint {.importc: "kore_window_height", header: "kore3/window.h".}
proc kore_window_show*(window: cint) {.importc: "kore_window_show", header: "kore3/window.h".}
proc kore_window_hide*(window: cint) {.importc: "kore_window_hide", header: "kore3/window.h".}
proc kore_window_set_title*(window: cint, title: cstring) {.importc: "kore_window_set_title", header: "kore3/window.h".}

# gpu/gpu.h
proc kore_gpu_init*(api: kore_gpu_api) {.importc: "kore_gpu_init", header: "kore3/gpu/gpu.h".}

# gpu/device.h
proc kore_gpu_device_create*(device: ptr kore_gpu_device, wishlist: pointer) {.importc: "kore_gpu_device_create", header: "kore3/gpu/device.h".}
proc kore_gpu_device_destroy*(device: ptr kore_gpu_device) {.importc: "kore_gpu_device_destroy", header: "kore3/gpu/device.h".}
proc kore_gpu_device_get_framebuffer*(device: ptr kore_gpu_device): ptr kore_gpu_texture {.importc: "kore_gpu_device_get_framebuffer", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_command_list*(device: ptr kore_gpu_device, `type`: cint, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_create_command_list", header: "kore3/gpu/device.h".}
proc kore_gpu_device_execute_command_list*(device: ptr kore_gpu_device, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_execute_command_list", header: "kore3/gpu/device.h".}
proc kore_gpu_device_wait_until_idle*(device: ptr kore_gpu_device) {.importc: "kore_gpu_device_wait_until_idle", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_buffer*(device: ptr kore_gpu_device, parameters: pointer, buffer: ptr kore_gpu_buffer) {.importc: "kore_gpu_device_create_buffer", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_sampler*(device: ptr kore_gpu_device, parameters: ptr kore_gpu_sampler_parameters, sampler: ptr kore_gpu_sampler) {.importc: "kore_gpu_device_create_sampler", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_fence*(device: ptr kore_gpu_device, fence: ptr kore_gpu_fence) {.importc: "kore_gpu_device_create_fence", header: "kore3/gpu/device.h".}
proc kore_gpu_device_signal*(device: ptr kore_gpu_device, `type`: cint, fence: ptr kore_gpu_fence, value: uint64) {.importc: "kore_gpu_device_signal", header: "kore3/gpu/device.h".}
proc kore_gpu_device_wait*(device: ptr kore_gpu_device, `type`: cint, fence: ptr kore_gpu_fence, value: uint64) {.importc: "kore_gpu_device_wait", header: "kore3/gpu/device.h".}

# gpu/commandlist.h
proc kore_gpu_command_list_begin_render_pass*(list: ptr kore_gpu_command_list, parameters: ptr kore_gpu_render_pass_parameters) {.importc: "kore_gpu_command_list_begin_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_end_render_pass*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_end_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw*(list: ptr kore_gpu_command_list, vertex_count, instance_count, first_vertex, first_instance: uint32) {.importc: "kore_gpu_command_list_draw", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw_indexed*(list: ptr kore_gpu_command_list, index_count, instance_count, first_index: uint32, base_vertex: cint, first_instance: uint32) {.importc: "kore_gpu_command_list_draw_indexed", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_present*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_present", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_viewport*(list: ptr kore_gpu_command_list, x, y, width, height, min_depth, max_depth: float32) {.importc: "kore_gpu_command_list_set_viewport", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_scissor_rect*(list: ptr kore_gpu_command_list, x, y, width, height: uint32) {.importc: "kore_gpu_command_list_set_scissor_rect", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_index_buffer*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, format: cint, offset: uint64) {.importc: "kore_gpu_command_list_set_index_buffer", header: "kore3/gpu/commandlist.h".}

# OpenGL Pipeline (from backend headers)
proc kore_opengl_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_opengl_render_pipeline, parameters: ptr kore_opengl_render_pipeline_parameters) {.importc: "kore_opengl_render_pipeline_init", header: "kore3/opengl/pipeline_functions.h".}
proc kore_opengl_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_opengl_render_pipeline) {.importc: "kore_opengl_command_list_set_render_pipeline", header: "kore3/opengl/commandlist_functions.h".}

# input
proc kore_mouse_set_press_callback*(value: proc(window, button, x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_press_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_release_callback*(value: proc(window, button, x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_release_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_move_callback*(value: proc(window, x, y, movement_x, movement_y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_move_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_scroll_callback*(value: proc(window, delta: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_scroll_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_lock*(window: cint) {.importc: "kore_mouse_lock", header: "kore3/input/mouse.h".}
proc kore_mouse_unlock*() {.importc: "kore_mouse_unlock", header: "kore3/input/mouse.h".}
proc kore_mouse_show*() {.importc: "kore_mouse_show", header: "kore3/input/mouse.h".}
proc kore_mouse_hide*() {.importc: "kore_mouse_hide", header: "kore3/input/mouse.h".}

proc kore_keyboard_set_key_down_callback*(value: proc(key_code: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_down_callback", header: "kore3/input/keyboard.h".}
proc kore_keyboard_set_key_up_callback*(value: proc(key_code: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_up_callback", header: "kore3/input/keyboard.h".}
proc kore_keyboard_set_key_press_callback*(value: proc(character: uint32, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_press_callback", header: "kore3/input/keyboard.h".}

proc kore_gamepad_set_connect_callback*(value: proc(gamepad: cint, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_connect_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_set_axis_callback*(value: proc(gamepad, axis: cint, value: float32, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_axis_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_set_button_callback*(value: proc(gamepad, button: cint, value: float32, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_button_callback", header: "kore3/input/gamepad.h".}

# display.h
proc kore_display_init*() {.importc: "kore_display_init", header: "kore3/display.h".}
proc kore_count_displays*(): cint {.importc: "kore_count_displays", header: "kore3/display.h".}
proc kore_display_name*(index: cint): cstring {.importc: "kore_display_name", header: "kore3/display.h".}
proc kore_display_primary*(): cint {.importc: "kore_display_primary", header: "kore3/display.h".}

# image.h
proc kore_image_size_from_file*(filename: cstring): int {.importc: "kore_image_size_from_file", header: "kore3/image.h".}
proc kore_image_init_from_file*(image: ptr kore_image, memory: pointer, filename: cstring): int {.importc: "kore_image_init_from_file", header: "kore3/image.h".}
proc kore_image_destroy*(image: ptr kore_image) {.importc: "kore_image_destroy", header: "kore3/image.h".}

# audio/audio.h
proc kore_audio_init*() {.importc: "kore_audio_init", header: "kore3/audio/audio.h".}
proc kore_audio_shutdown*() {.importc: "kore_audio_shutdown", header: "kore3/audio/audio.h".}
proc kore_audio_samples_per_second*(): uint32 {.importc: "kore_audio_samples_per_second", header: "kore3/audio/audio.h".}

# mixer
proc kore_mixer_init*() {.importc: "kore_mixer_init", header: "kore3/mixer/mixer.h".}
proc kore_mixer_play*(sound: ptr kore_sound) {.importc: "kore_mixer_play", header: "kore3/mixer/mixer.h".}

# io
proc kore_file_reader_open*(reader: ptr kore_file_reader, filename: cstring, `type`: kore_file_type): bool {.importc: "kore_file_reader_open", header: "kore3/io/filereader.h".}
proc kore_file_reader_close*(reader: ptr kore_file_reader) {.importc: "kore_file_reader_close", header: "kore3/io/filereader.h".}
proc kore_file_reader_read*(reader: ptr kore_file_reader, data: pointer, size: int): int {.importc: "kore_file_reader_read", header: "kore3/io/filereader.h".}
proc kore_file_reader_size*(reader: ptr kore_file_reader): int {.importc: "kore_file_reader_size", header: "kore3/io/filereader.h".}

# threads
proc kore_mutex_init*(mutex: pointer) {.importc: "kore_mutex_init", header: "kore3/threads/mutex.h".}
proc kore_mutex_lock*(mutex: pointer) {.importc: "kore_mutex_lock", header: "kore3/threads/mutex.h".}
proc kore_mutex_unlock*(mutex: pointer) {.importc: "kore_mutex_unlock", header: "kore3/threads/mutex.h".}

# math
proc kore_matrix4x4_identity*(): kore_matrix4x4 {.importc: "kore_matrix4x4_identity", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_rotation_x*(alpha: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_rotation_x", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_translation*(x, y, z: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_translation", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_multiply*(a, b: ptr kore_matrix4x4): kore_matrix4x4 {.importc: "kore_matrix4x4_multiply", header: "kore3/math/matrix.h".}

# socket
proc kore_socket_init*(socket: ptr kore_socket) {.importc: "kore_socket_init", header: "kore3/network/socket.h".}
proc kore_socket_open*(socket: ptr kore_socket, parameters: pointer): bool {.importc: "kore_socket_open", header: "kore3/network/socket.h".}
proc kore_socket_send*(socket: ptr kore_socket, data: pointer, size: cint): cint {.importc: "kore_socket_send", header: "kore3/network/socket.h".}

# framebuffer.h
proc kore_fb_init*() {.importc: "kore_fb_init", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_begin*() {.importc: "kore_fb_begin", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_end*() {.importc: "kore_fb_end", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_set_pixel*(x, y: uint32, red, green, blue: uint8) {.importc: "kore_fb_set_pixel", header: "kore3/framebuffer/framebuffer.h".}
