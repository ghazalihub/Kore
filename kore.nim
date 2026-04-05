
# Kore 3 Nim Bindings - Comprehensive 100% API Coverage

{.passC: "-Iincludes".}
{.passC: "-Ibackends/system/linux/includes".}
{.passC: "-Ibackends/system/posix/includes".}
{.passC: "-Ibackends/gpu/opengl/includes".}
{.passC: "-Ibackends/gpu/vulkan/includes".}
{.passC: "-Ibackends/gpu/direct3d12/includes".}
{.passC: "-Ibackends/gpu/metal/includes".}

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
    dummy: array[4096, byte]

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

  # --- gpu/raytracing.h ---
  kore_gpu_raytracing_volume* {.importc: "kore_gpu_raytracing_volume", header: "kore3/gpu/raytracing.h", bycopy.} = object
    dummy: array[256, byte]

  kore_gpu_raytracing_hierarchy* {.importc: "kore_gpu_raytracing_hierarchy", header: "kore3/gpu/raytracing.h", bycopy.} = object
    dummy: array[256, byte]

  # --- Backend Specific Pipeline Structs ---
  kore_opengl_render_pipeline* {.importc: "kore_opengl_render_pipeline", header: "kore3/opengl/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

  kore_vulkan_render_pipeline* {.importc: "kore_vulkan_render_pipeline", header: "kore3/vulkan/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

  kore_d3d12_render_pipeline* {.importc: "kore_d3d12_render_pipeline", header: "kore3/direct3d12/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

  kore_metal_render_pipeline* {.importc: "kore_metal_render_pipeline", header: "kore3/metal/pipeline_structs.h", bycopy.} = object
    dummy: array[2048, byte]

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

  kore_image_read_callbacks* {.importc: "kore_image_read_callbacks", header: "kore3/image.h", bycopy.} = object
    read*: proc(user_data: pointer, data: pointer, size: int): int {.cdecl.}
    seek*: proc(user_data: pointer, pos: int) {.cdecl.}
    pos*: proc(user_data: pointer): int {.cdecl.}
    size*: proc(user_data: pointer): int {.cdecl.}

  # --- audio.h ---
  kore_audio_buffer* {.importc: "kore_audio_buffer", header: "kore3/audio/audio.h", bycopy.} = object
    channel_count*: uint8
    channels*: array[8, ptr float32]
    data_size*: uint32
    read_location*: uint32
    write_location*: uint32

  # --- mixer.h ---
  kore_mixer_sound* {.importc: "kore_mixer_sound", header: "kore3/mixer/sound.h", bycopy.} = object
    channel_count*: uint8
    bits_per_sample*: uint8
    samples_per_second*: uint32
    left*: ptr int16
    right*: ptr int16
    size*: cint
    sample_rate_pos*: float32
    volume*: float32
    in_use*: bool

  kore_mixer_sound_stream* {.importc: "kore_mixer_sound_stream", header: "kore3/mixer/soundstream.h", bycopy.} = object
    vorbis*: pointer
    chans*, rate*: cint
    myLooping*: bool
    myVolume*: float32
    rateDecodedHack*: bool
    `end`*: bool
    samples*: array[2, float32]
    buffer*: ptr uint8

  kore_mixer_channel* {.importc: "kore_mixer_channel", header: "kore3/mixer/mixer.h", bycopy.} = object
    dummy: array[128, byte]

  # --- display.h ---
  kore_display_mode* {.importc: "kore_display_mode", header: "kore3/display.h", bycopy.} = object
    x*, y*, width*, height*, pixels_per_inch*, frequency*, bits_per_pixel*: cint

  # --- io headers ---
  kore_file_type* {.pure.} = enum
    ASSET,
    SAVE

  kore_file_reader* {.importc: "kore_file_reader", header: "kore3/io/filereader.h", bycopy.} = object
    data*: pointer
    size*: int
    offset*: int
    close_cb*: pointer
    read_cb*: pointer
    pos_cb*: pointer
    seek_cb*: pointer

  kore_file_writer* {.importc: "kore_file_writer", header: "kore3/io/filewriter.h", bycopy.} = object
    file*: pointer
    filename*: cstring
    mounted*: bool

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

  kore_socket_parameters* {.importc: "kore_socket_parameters", header: "kore3/network/socket.h", bycopy.} = object
    non_blocking*: bool
    broadcast*: bool
    tcp_no_delay*: bool

  # --- threads headers ---
  kore_mutex* {.importc: "kore_mutex", header: "kore3/threads/mutex.h", bycopy.} = object
    dummy: array[128, byte]

  kore_uber_mutex* {.importc: "kore_uber_mutex", header: "kore3/threads/mutex.h", bycopy.} = object
    dummy: array[128, byte]

  kore_semaphore* {.importc: "kore_semaphore", header: "kore3/threads/semaphore.h", bycopy.} = object
    dummy: array[128, byte]

  kore_event* {.importc: "kore_event", header: "kore3/threads/event.h", bycopy.} = object
    dummy: array[128, byte]

  kore_thread* {.importc: "kore_thread", header: "kore3/threads/thread.h", bycopy.} = object
    dummy: array[128, byte]

  # --- video.h ---
  kore_video* {.importc: "kore_video", header: "kore3/video.h", bycopy.} = object
    dummy: array[256, byte]

# --- Procedures ---

# log.h
proc kore_log*(log_level: kore_log_level, format: cstring) {.importc: "kore_log", header: "kore3/log.h", varargs.}
proc kore_log_args*(log_level: kore_log_level, format: cstring, args: pointer) {.importc: "kore_log_args", header: "kore3/log.h".}

# error.h
proc kore_affirm*(condition: bool) {.importc: "kore_affirm", header: "kore3/error.h".}
proc kore_affirm_message*(condition: bool, format: cstring) {.importc: "kore_affirm_message", header: "kore3/error.h", varargs.}
proc kore_affirm_args*(condition: bool, format: cstring, args: pointer) {.importc: "kore_affirm_args", header: "kore3/error.h".}
proc kore_error*() {.importc: "kore_error", header: "kore3/error.h".}
proc kore_error_message*(format: cstring) {.importc: "kore_error_message", header: "kore3/error.h", varargs.}
proc kore_error_args*(format: cstring, args: pointer) {.importc: "kore_error_args", header: "kore3/error.h".}

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
proc kore_allow_user_change*() {.importc: "kore_allow_user_change", header: "kore3/system.h".}
proc kore_disallow_user_change*() {.importc: "kore_disallow_user_change", header: "kore3/system.h".}
proc kore_login*() {.importc: "kore_login", header: "kore3/system.h".}
proc kore_unlock_achievement*(id: cint) {.importc: "kore_unlock_achievement", header: "kore3/system.h".}
proc kore_set_keep_screen_on*(on: bool) {.importc: "kore_set_keep_screen_on", header: "kore3/system.h".}
proc kore_waiting_for_login*(): bool {.importc: "kore_waiting_for_login", header: "kore3/system.h".}
proc kore_debugger_attached*(): bool {.importc: "kore_debugger_attached", header: "kore3/system.h".}

# callbacks
proc kore_set_update_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_update_callback", header: "kore3/system.h".}
proc kore_set_foreground_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_foreground_callback", header: "kore3/system.h".}
proc kore_set_resume_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_resume_callback", header: "kore3/system.h".}
proc kore_set_pause_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_pause_callback", header: "kore3/system.h".}
proc kore_set_background_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_background_callback", header: "kore3/system.h".}
proc kore_set_shutdown_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_shutdown_callback", header: "kore3/system.h".}
proc kore_set_drop_files_callback*(callback: proc(file: ptr cstring, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_drop_files_callback", header: "kore3/system.h".}
proc kore_set_copy_callback*(callback: proc(data: pointer): cstring {.cdecl.}, data: pointer) {.importc: "kore_set_copy_callback", header: "kore3/system.h".}
proc kore_set_cut_callback*(callback: proc(data: pointer): cstring {.cdecl.}, data: pointer) {.importc: "kore_set_cut_callback", header: "kore3/system.h".}
proc kore_set_paste_callback*(callback: proc(text: cstring, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_paste_callback", header: "kore3/system.h".}
proc kore_set_login_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_login_callback", header: "kore3/system.h".}
proc kore_set_logout_callback*(callback: proc(data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_set_logout_callback", header: "kore3/system.h".}

# --- window.h ---
proc kore_window_create*(win: ptr kore_window_parameters, frame: ptr kore_framebuffer_parameters): cint {.importc: "kore_window_create", header: "kore3/window.h".}
proc kore_window_destroy*(window: cint) {.importc: "kore_window_destroy", header: "kore3/window.h".}
proc kore_window_options_set_defaults*(win: ptr kore_window_parameters) {.importc: "kore_window_options_set_defaults", header: "kore3/window.h".}
proc kore_framebuffer_options_set_defaults*(frame: ptr kore_framebuffer_parameters) {.importc: "kore_framebuffer_options_set_defaults", header: "kore3/window.h".}
proc kore_count_windows*(): cint {.importc: "kore_count_windows", header: "kore3/window.h".}
proc kore_window_resize*(window, width, height: cint) {.importc: "kore_window_resize", header: "kore3/window.h".}
proc kore_window_move*(window, x, y: cint) {.importc: "kore_window_move", header: "kore3/window.h".}
proc kore_window_change_mode*(window: cint, mode: kore_window_mode) {.importc: "kore_window_change_mode", header: "kore3/window.h".}
proc kore_window_change_features*(window: cint, features: cint) {.importc: "kore_window_change_features", header: "kore3/window.h".}
proc kore_window_change_framebuffer*(window: cint, frame: ptr kore_framebuffer_parameters) {.importc: "kore_window_change_framebuffer", header: "kore3/window.h".}
proc kore_window_x*(window: cint): cint {.importc: "kore_window_x", header: "kore3/window.h".}
proc kore_window_y*(window: cint): cint {.importc: "kore_window_y", header: "kore3/window.h".}
proc kore_window_width*(window: cint): cint {.importc: "kore_window_width", header: "kore3/window.h".}
proc kore_window_height*(window: cint): cint {.importc: "kore_window_height", header: "kore3/window.h".}
proc kore_window_display*(window: cint): cint {.importc: "kore_window_display", header: "kore3/window.h".}
proc kore_window_get_mode*(window: cint): kore_window_mode {.importc: "kore_window_get_mode", header: "kore3/window.h".}
proc kore_window_show*(window: cint) {.importc: "kore_window_show", header: "kore3/window.h".}
proc kore_window_hide*(window: cint) {.importc: "kore_window_hide", header: "kore3/window.h".}
proc kore_window_set_title*(window: cint, title: cstring) {.importc: "kore_window_set_title", header: "kore3/window.h".}
proc kore_window_set_resize_callback*(window: cint, callback: proc(x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_window_set_resize_callback", header: "kore3/window.h".}
proc kore_window_set_ppi_changed_callback*(window: cint, callback: proc(ppi: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_window_set_ppi_changed_callback", header: "kore3/window.h".}
proc kore_window_set_close_callback*(window: cint, callback: proc(data: pointer): bool {.cdecl.}, data: pointer) {.importc: "kore_window_set_close_callback", header: "kore3/window.h".}
proc kore_window_vsynced*(window: cint): bool {.importc: "kore_window_vsynced", header: "kore3/window.h".}

# --- gpu/gpu.h ---
proc kore_gpu_init*(api: kore_gpu_api) {.importc: "kore_gpu_init", header: "kore3/gpu/gpu.h".}

# --- gpu/device.h ---
proc kore_gpu_device_create*(device: ptr kore_gpu_device, wishlist: pointer) {.importc: "kore_gpu_device_create", header: "kore3/gpu/device.h".}
proc kore_gpu_device_destroy*(device: ptr kore_gpu_device) {.importc: "kore_gpu_device_destroy", header: "kore3/gpu/device.h".}
proc kore_gpu_device_set_name*(device: ptr kore_gpu_device, name: cstring) {.importc: "kore_gpu_device_set_name", header: "kore3/gpu/device.h".}
proc kore_gpu_device_get_framebuffer*(device: ptr kore_gpu_device): ptr kore_gpu_texture {.importc: "kore_gpu_device_get_framebuffer", header: "kore3/gpu/device.h".}
proc kore_gpu_device_framebuffer_format*(device: ptr kore_gpu_device): kore_gpu_texture_format {.importc: "kore_gpu_device_framebuffer_format", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_command_list*(device: ptr kore_gpu_device, `type`: cint, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_create_command_list", header: "kore3/gpu/device.h".}
proc kore_gpu_device_execute_command_list*(device: ptr kore_gpu_device, list: ptr kore_gpu_command_list) {.importc: "kore_gpu_device_execute_command_list", header: "kore3/gpu/device.h".}
proc kore_gpu_device_wait_until_idle*(device: ptr kore_gpu_device) {.importc: "kore_gpu_device_wait_until_idle", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_buffer*(device: ptr kore_gpu_device, parameters: pointer, buffer: ptr kore_gpu_buffer) {.importc: "kore_gpu_device_create_buffer", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_texture*(device: ptr kore_gpu_device, parameters: pointer, texture: ptr kore_gpu_texture) {.importc: "kore_gpu_device_create_texture", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_sampler*(device: ptr kore_gpu_device, parameters: ptr kore_gpu_sampler_parameters, sampler: ptr kore_gpu_sampler) {.importc: "kore_gpu_device_create_sampler", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_fence*(device: ptr kore_gpu_device, fence: ptr kore_gpu_fence) {.importc: "kore_gpu_device_create_fence", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_query_set*(device: ptr kore_gpu_device, parameters: pointer, query_set: pointer) {.importc: "kore_gpu_device_create_query_set", header: "kore3/gpu/device.h".}
proc kore_gpu_device_signal*(device: ptr kore_gpu_device, `type`: cint, fence: ptr kore_gpu_fence, value: uint64) {.importc: "kore_gpu_device_signal", header: "kore3/gpu/device.h".}
proc kore_gpu_device_wait*(device: ptr kore_gpu_device, `type`: cint, fence: ptr kore_gpu_fence, value: uint64) {.importc: "kore_gpu_device_wait", header: "kore3/gpu/device.h".}
proc kore_gpu_device_align_texture_row_bytes*(device: ptr kore_gpu_device, row_bytes: uint32): uint32 {.importc: "kore_gpu_device_align_texture_row_bytes", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_raytracing_volume*(device: ptr kore_gpu_device, vertex_buffer: ptr kore_gpu_buffer, vertex_count: uint64, index_buffer: ptr kore_gpu_buffer, index_count: uint32, volume: ptr kore_gpu_raytracing_volume) {.importc: "kore_gpu_device_create_raytracing_volume", header: "kore3/gpu/device.h".}
proc kore_gpu_device_create_raytracing_hierarchy*(device: ptr kore_gpu_device, volumes: ptr ptr kore_gpu_raytracing_volume, transforms: ptr kore_matrix4x4, count: uint32, hierarchy: ptr kore_gpu_raytracing_hierarchy) {.importc: "kore_gpu_device_create_raytracing_hierarchy", header: "kore3/gpu/device.h".}

# --- gpu/buffer.h ---
proc kore_gpu_buffer_destroy*(buffer: ptr kore_gpu_buffer) {.importc: "kore_gpu_buffer_destroy", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_set_name*(buffer: ptr kore_gpu_buffer, name: cstring) {.importc: "kore_gpu_buffer_set_name", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_lock*(buffer: ptr kore_gpu_buffer, offset, size: uint64): pointer {.importc: "kore_gpu_buffer_lock", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_lock_all*(buffer: ptr kore_gpu_buffer): pointer {.importc: "kore_gpu_buffer_lock_all", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_unlock*(buffer: ptr kore_gpu_buffer) {.importc: "kore_gpu_buffer_unlock", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_try_to_lock*(buffer: ptr kore_gpu_buffer, offset, size: uint64): pointer {.importc: "kore_gpu_buffer_try_to_lock", header: "kore3/gpu/buffer.h".}
proc kore_gpu_buffer_try_to_lock_all*(buffer: ptr kore_gpu_buffer): pointer {.importc: "kore_gpu_buffer_try_to_lock_all", header: "kore3/gpu/buffer.h".}

# --- gpu/texture.h ---
proc kore_gpu_texture_destroy*(texture: ptr kore_gpu_texture) {.importc: "kore_gpu_texture_destroy", header: "kore3/gpu/texture.h".}
proc kore_gpu_texture_set_name*(texture: ptr kore_gpu_texture, name: cstring) {.importc: "kore_gpu_texture_set_name", header: "kore3/gpu/texture.h".}

# --- gpu/sampler.h ---
proc kore_gpu_sampler_destroy*(sampler: ptr kore_gpu_sampler) {.importc: "kore_gpu_sampler_destroy", header: "kore3/gpu/sampler.h".}
proc kore_gpu_sampler_set_name*(sampler: ptr kore_gpu_sampler, name: cstring) {.importc: "kore_gpu_sampler_set_name", header: "kore3/gpu/sampler.h".}

# --- gpu/fence.h ---
proc kore_gpu_fence_destroy*(fence: ptr kore_gpu_fence) {.importc: "kore_gpu_fence_destroy", header: "kore3/gpu/fence.h".}

# --- gpu/raytracing.h ---
proc kore_gpu_raytracing_volume_destroy*(volume: ptr kore_gpu_raytracing_volume) {.importc: "kore_gpu_raytracing_volume_destroy", header: "kore3/gpu/raytracing.h".}
proc kore_gpu_raytracing_hierarchy_destroy*(hierarchy: ptr kore_gpu_raytracing_hierarchy) {.importc: "kore_gpu_raytracing_hierarchy_destroy", header: "kore3/gpu/raytracing.h".}

# --- gpu/commandlist.h ---
proc kore_gpu_command_list_destroy*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_destroy", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_name*(list: ptr kore_gpu_command_list, name: cstring) {.importc: "kore_gpu_command_list_set_name", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_begin_render_pass*(list: ptr kore_gpu_command_list, parameters: ptr kore_gpu_render_pass_parameters) {.importc: "kore_gpu_command_list_begin_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_end_render_pass*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_end_render_pass", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw*(list: ptr kore_gpu_command_list, vertex_count, instance_count, first_vertex, first_instance: uint32) {.importc: "kore_gpu_command_list_draw", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw_indexed*(list: ptr kore_gpu_command_list, index_count, instance_count, first_index: uint32, base_vertex: cint, first_instance: uint32) {.importc: "kore_gpu_command_list_draw_indexed", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw_indirect*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, offset: uint64, max_count: uint32, count_buffer: ptr kore_gpu_buffer, count_offset: uint64) {.importc: "kore_gpu_command_list_draw_indirect", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_draw_indexed_indirect*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, offset: uint64, max_count: uint32, count_buffer: ptr kore_gpu_buffer, count_offset: uint64) {.importc: "kore_gpu_command_list_draw_indexed_indirect", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_present*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_present", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_viewport*(list: ptr kore_gpu_command_list, x, y, width, height, min_depth, max_depth: float32) {.importc: "kore_gpu_command_list_set_viewport", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_scissor_rect*(list: ptr kore_gpu_command_list, x, y, width, height: uint32) {.importc: "kore_gpu_command_list_set_scissor_rect", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_index_buffer*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, format: cint, offset: uint64) {.importc: "kore_gpu_command_list_set_index_buffer", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_clear_buffer*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, offset: int, size: uint64) {.importc: "kore_gpu_command_list_clear_buffer", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_copy_buffer_to_buffer*(list: ptr kore_gpu_command_list, src, dst: ptr kore_gpu_buffer, src_offset, dst_offset, size: uint64) {.importc: "kore_gpu_command_list_copy_buffer_to_buffer", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_copy_buffer_to_texture*(list: ptr kore_gpu_command_list, src: pointer, dst: pointer, width, height, layers: uint32) {.importc: "kore_gpu_command_list_copy_buffer_to_texture", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_copy_texture_to_buffer*(list: ptr kore_gpu_command_list, src: pointer, dst: pointer, width, height, layers: uint32) {.importc: "kore_gpu_command_list_copy_texture_to_buffer", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_copy_texture_to_texture*(list: ptr kore_gpu_command_list, src: pointer, dst: pointer, width, height, layers: uint32) {.importc: "kore_gpu_command_list_copy_texture_to_texture", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_resolve_query_set*(list: ptr kore_gpu_command_list, query_set: pointer, first_query, count: uint32, dst: ptr kore_gpu_buffer, dst_offset: uint64) {.importc: "kore_gpu_command_list_resolve_query_set", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_compute*(list: ptr kore_gpu_command_list, x, y, z: uint32) {.importc: "kore_gpu_command_list_compute", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_compute_indirect*(list: ptr kore_gpu_command_list, buffer: ptr kore_gpu_buffer, offset: uint64) {.importc: "kore_gpu_command_list_compute_indirect", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_trace_rays*(list: ptr kore_gpu_command_list, width, height, depth: uint32) {.importc: "kore_gpu_command_list_trace_rays", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_prepare_raytracing_volume*(list: ptr kore_gpu_command_list, volume: ptr kore_gpu_raytracing_volume) {.importc: "kore_gpu_command_list_prepare_raytracing_volume", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_prepare_raytracing_hierarchy*(list: ptr kore_gpu_command_list, hierarchy: ptr kore_gpu_raytracing_hierarchy) {.importc: "kore_gpu_command_list_prepare_raytracing_hierarchy", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_update_raytracing_hierarchy*(list: ptr kore_gpu_command_list, transforms: ptr kore_matrix4x4, count: uint32, hierarchy: ptr kore_gpu_raytracing_hierarchy) {.importc: "kore_gpu_command_list_update_raytracing_hierarchy", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_insert_debug_marker*(list: ptr kore_gpu_command_list, name: cstring) {.importc: "kore_gpu_command_list_insert_debug_marker", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_push_debug_group*(list: ptr kore_gpu_command_list, name: cstring) {.importc: "kore_gpu_command_list_push_debug_group", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_pop_debug_group*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_pop_debug_group", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_blend_constant*(list: ptr kore_gpu_command_list, color: kore_gpu_color) {.importc: "kore_gpu_command_list_set_blend_constant", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_set_stencil_reference*(list: ptr kore_gpu_command_list, reference: uint32) {.importc: "kore_gpu_command_list_set_stencil_reference", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_begin_occlusion_query*(list: ptr kore_gpu_command_list, query_index: uint32) {.importc: "kore_gpu_command_list_begin_occlusion_query", header: "kore3/gpu/commandlist.h".}
proc kore_gpu_command_list_end_occlusion_query*(list: ptr kore_gpu_command_list) {.importc: "kore_gpu_command_list_end_occlusion_query", header: "kore3/gpu/commandlist.h".}

# --- Backend Specific Pipeline Init ---
proc kore_opengl_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_opengl_render_pipeline, parameters: pointer) {.importc: "kore_opengl_render_pipeline_init", header: "kore3/opengl/pipeline_functions.h".}
proc kore_vulkan_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_vulkan_render_pipeline, parameters: pointer) {.importc: "kore_vulkan_render_pipeline_init", header: "kore3/vulkan/pipeline_functions.h".}
proc kore_d3d12_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_d3d12_render_pipeline, parameters: pointer) {.importc: "kore_d3d12_render_pipeline_init", header: "kore3/direct3d12/pipeline_functions.h".}
proc kore_metal_render_pipeline_init*(device: ptr kore_gpu_device, pipe: ptr kore_metal_render_pipeline, parameters: pointer) {.importc: "kore_metal_render_pipeline_init", header: "kore3/metal/pipeline_functions.h".}

# --- Backend Specific Command List Functions ---
proc kore_opengl_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_opengl_render_pipeline) {.importc: "kore_opengl_command_list_set_render_pipeline", header: "kore3/opengl/commandlist_functions.h".}
proc kore_vulkan_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_vulkan_render_pipeline) {.importc: "kore_vulkan_command_list_set_render_pipeline", header: "kore3/vulkan/commandlist_functions.h".}
proc kore_d3d12_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_d3d12_render_pipeline) {.importc: "kore_d3d12_command_list_set_render_pipeline", header: "kore3/direct3d12/commandlist_functions.h".}
proc kore_metal_command_list_set_render_pipeline*(list: ptr kore_gpu_command_list, pipeline: ptr kore_metal_render_pipeline) {.importc: "kore_metal_command_list_set_render_pipeline", header: "kore3/metal/commandlist_functions.h".}

# --- input headers ---
proc kore_mouse_set_press_callback*(value: proc(window, button, x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_press_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_release_callback*(value: proc(window, button, x, y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_release_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_move_callback*(value: proc(window, x, y, movement_x, movement_y: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_move_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_scroll_callback*(value: proc(window, delta: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_scroll_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_enter_window_callback*(value: proc(window: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_enter_window_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_set_leave_window_callback*(value: proc(window: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_mouse_set_leave_window_callback", header: "kore3/input/mouse.h".}
proc kore_mouse_lock*(window: cint) {.importc: "kore_mouse_lock", header: "kore3/input/mouse.h".}
proc kore_mouse_unlock*() {.importc: "kore_mouse_unlock", header: "kore3/input/mouse.h".}
proc kore_mouse_show*() {.importc: "kore_mouse_show", header: "kore3/input/mouse.h".}
proc kore_mouse_hide*() {.importc: "kore_mouse_hide", header: "kore3/input/mouse.h".}
proc kore_mouse_set_position*(window, x, y: cint) {.importc: "kore_mouse_set_position", header: "kore3/input/mouse.h".}
proc kore_mouse_get_position*(window: cint, x, y: ptr cint) {.importc: "kore_mouse_get_position", header: "kore3/input/mouse.h".}
proc kore_mouse_can_lock*(): bool {.importc: "kore_mouse_can_lock", header: "kore3/input/mouse.h".}
proc kore_mouse_is_locked*(): bool {.importc: "kore_mouse_is_locked", header: "kore3/input/mouse.h".}
proc kore_mouse_set_cursor*(cursor: cint) {.importc: "kore_mouse_set_cursor", header: "kore3/input/mouse.h".}

proc kore_keyboard_set_key_down_callback*(value: proc(key_code: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_down_callback", header: "kore3/input/keyboard.h".}
proc kore_keyboard_set_key_up_callback*(value: proc(key_code: cint, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_up_callback", header: "kore3/input/keyboard.h".}
proc kore_keyboard_set_key_press_callback*(value: proc(character: uint32, data: pointer) {.cdecl.}, data: pointer) {.importc: "kore_keyboard_set_key_press_callback", header: "kore3/input/keyboard.h".}
proc kore_keyboard_show*() {.importc: "kore_keyboard_show", header: "kore3/input/keyboard.h".}
proc kore_keyboard_hide*() {.importc: "kore_keyboard_hide", header: "kore3/input/keyboard.h".}
proc kore_keyboard_active*(): bool {.importc: "kore_keyboard_active", header: "kore3/input/keyboard.h".}

proc kore_gamepad_set_connect_callback*(value: proc(gamepad: cint, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_connect_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_set_disconnect_callback*(value: proc(gamepad: cint, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_disconnect_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_set_axis_callback*(value: proc(gamepad, axis: cint, value: float32, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_axis_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_set_button_callback*(value: proc(gamepad, button: cint, value: float32, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_gamepad_set_button_callback", header: "kore3/input/gamepad.h".}
proc kore_gamepad_vendor*(gamepad: cint): cstring {.importc: "kore_gamepad_vendor", header: "kore3/input/gamepad.h".}
proc kore_gamepad_product_name*(gamepad: cint): cstring {.importc: "kore_gamepad_product_name", header: "kore3/input/gamepad.h".}
proc kore_gamepad_connected*(gamepad: cint): bool {.importc: "kore_gamepad_connected", header: "kore3/input/gamepad.h".}
proc kore_gamepad_rumble*(gamepad: cint, left, right: float32) {.importc: "kore_gamepad_rumble", header: "kore3/input/gamepad.h".}

proc kore_pen_set_press_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_pen_set_press_callback", header: "kore3/input/pen.h".}
proc kore_pen_set_move_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_pen_set_move_callback", header: "kore3/input/pen.h".}
proc kore_pen_set_release_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_pen_set_release_callback", header: "kore3/input/pen.h".}

proc kore_eraser_set_press_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_eraser_set_press_callback", header: "kore3/input/pen.h".}
proc kore_eraser_set_move_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_eraser_set_move_callback", header: "kore3/input/pen.h".}
proc kore_eraser_set_release_callback*(value: proc(window, x, y: cint, pressure: float32) {.cdecl.}) {.importc: "kore_eraser_set_release_callback", header: "kore3/input/pen.h".}

proc kore_surface_set_touch_start_callback*(value: proc(index, x, y: cint) {.cdecl.}) {.importc: "kore_surface_set_touch_start_callback", header: "kore3/input/surface.h".}
proc kore_surface_set_move_callback*(value: proc(index, x, y: cint) {.cdecl.}) {.importc: "kore_surface_set_move_callback", header: "kore3/input/surface.h".}
proc kore_surface_set_touch_end_callback*(value: proc(index, x, y: cint) {.cdecl.}) {.importc: "kore_surface_set_touch_end_callback", header: "kore3/input/surface.h".}

proc kore_acceleration_set_callback*(value: proc(x, y, z: float32) {.cdecl.}) {.importc: "kore_acceleration_set_callback", header: "kore3/input/acceleration.h".}
proc kore_rotation_set_callback*(value: proc(x, y, z: float32) {.cdecl.}) {.importc: "kore_rotation_set_callback", header: "kore3/input/rotation.h".}

# --- display.h ---
proc kore_display_init*() {.importc: "kore_display_init", header: "kore3/display.h".}
proc kore_count_displays*(): cint {.importc: "kore_count_displays", header: "kore3/display.h".}
proc kore_display_name*(index: cint): cstring {.importc: "kore_display_name", header: "kore3/display.h".}
proc kore_display_primary*(): cint {.importc: "kore_display_primary", header: "kore3/display.h".}
proc kore_display_available*(index: cint): bool {.importc: "kore_display_available", header: "kore3/display.h".}
proc kore_display_current_mode*(index: cint): kore_display_mode {.importc: "kore_display_current_mode", header: "kore3/display.h".}
proc kore_display_count_available_modes*(index: cint): cint {.importc: "kore_display_count_available_modes", header: "kore3/display.h".}
proc kore_display_available_mode*(index, mode_index: cint): kore_display_mode {.importc: "kore_display_available_mode", header: "kore3/display.h".}
proc kore_primary_display*(): cint {.importc: "kore_primary_display", header: "kore3/display.h".}

# --- image.h ---
proc kore_image_init*(image: ptr kore_image, memory: pointer, width, height: cint, format: kore_image_format): int {.importc: "kore_image_init", header: "kore3/image.h".}
proc kore_image_init3d*(image: ptr kore_image, memory: pointer, width, height, depth: cint, format: kore_image_format): int {.importc: "kore_image_init3d", header: "kore3/image.h".}
proc kore_image_size_from_file*(filename: cstring): int {.importc: "kore_image_size_from_file", header: "kore3/image.h".}
proc kore_image_init_from_file*(image: ptr kore_image, memory: pointer, filename: cstring): int {.importc: "kore_image_init_from_file", header: "kore3/image.h".}
proc kore_image_destroy*(image: ptr kore_image) {.importc: "kore_image_destroy", header: "kore3/image.h".}
proc kore_image_at*(image: ptr kore_image, x, y: cint): uint32 {.importc: "kore_image_at", header: "kore3/image.h".}
proc kore_image_at_raw*(image: ptr kore_image, x, y: cint): pointer {.importc: "kore_image_at_raw", header: "kore3/image.h".}
proc kore_image_get_pixels*(image: ptr kore_image): ptr uint8 {.importc: "kore_image_get_pixels", header: "kore3/image.h".}
proc kore_image_format_sizeof*(format: kore_image_format): cint {.importc: "kore_image_format_sizeof", header: "kore3/image.h".}
proc kore_image_size_from_callbacks*(callbacks: kore_image_read_callbacks, user_data: pointer, format: cstring): int {.importc: "kore_image_size_from_callbacks", header: "kore3/image.h".}
proc kore_image_size_from_encoded_bytes*(data: pointer, data_size: int, format_hint: cstring): int {.importc: "kore_image_size_from_encoded_bytes", header: "kore3/image.h".}
proc kore_image_init_from_file_with_stride*(image: ptr kore_image, memory: pointer, filename: cstring, stride: uint32): int {.importc: "kore_image_init_from_file_with_stride", header: "kore3/image.h".}
proc kore_image_init_from_callbacks*(image: ptr kore_image, memory: pointer, callbacks: kore_image_read_callbacks, user_data: pointer, format: cstring): int {.importc: "kore_image_init_from_callbacks", header: "kore3/image.h".}
proc kore_image_init_from_callbacks_with_stride*(image: ptr kore_image, memory: pointer, callbacks: kore_image_read_callbacks, user_data: pointer, format: cstring, stride: uint32): int {.importc: "kore_image_init_from_callbacks_with_stride", header: "kore3/image.h".}
proc kore_image_init_from_encoded_bytes*(image: ptr kore_image, memory: pointer, data: pointer, data_size: int, format: cstring): int {.importc: "kore_image_init_from_encoded_bytes", header: "kore3/image.h".}
proc kore_image_init_from_encoded_bytes_with_stride*(image: ptr kore_image, memory: pointer, data: pointer, data_size: int, format: cstring, stride: uint32): int {.importc: "kore_image_init_from_encoded_bytes_with_stride", header: "kore3/image.h".}
proc kore_image_init_from_bytes*(image: ptr kore_image, data: pointer, width, height: cint, format: kore_image_format) {.importc: "kore_image_init_from_bytes", header: "kore3/image.h".}
proc kore_image_init_from_bytes3d*(image: ptr kore_image, data: pointer, width, height, depth: cint, format: kore_image_format) {.importc: "kore_image_init_from_bytes3d", header: "kore3/image.h".}

# --- audio.h ---
proc kore_audio_init*() {.importc: "kore_audio_init", header: "kore3/audio/audio.h".}
proc kore_audio_shutdown*() {.importc: "kore_audio_shutdown", header: "kore3/audio/audio.h".}
proc kore_audio_samples_per_second*(): uint32 {.importc: "kore_audio_samples_per_second", header: "kore3/audio/audio.h".}
proc kore_audio_set_callback*(kore_audio_callback: proc(buffer: ptr kore_audio_buffer, samples: uint32, userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_audio_set_callback", header: "kore3/audio/audio.h".}
proc kore_audio_set_sample_rate_callback*(kore_audio_sample_rate_callback: proc(userdata: pointer) {.cdecl.}, userdata: pointer) {.importc: "kore_audio_set_sample_rate_callback", header: "kore3/audio/audio.h".}
proc kore_audio_update*() {.importc: "kore_audio_update", header: "kore3/audio/audio.h".}

# --- mixer ---
proc kore_mixer_init*() {.importc: "kore_mixer_init", header: "kore3/mixer/mixer.h".}
proc kore_mixer_play_sound*(sound: ptr kore_mixer_sound, loop: bool, pitch: float32, unique: bool): ptr kore_mixer_channel {.importc: "kore_mixer_play_sound", header: "kore3/mixer/mixer.h".}
proc kore_mixer_stop_sound*(sound: ptr kore_mixer_sound) {.importc: "kore_mixer_stop_sound", header: "kore3/mixer/mixer.h".}
proc kore_mixer_play_sound_stream*(stream: ptr kore_mixer_sound_stream) {.importc: "kore_mixer_play_sound_stream", header: "kore3/mixer/mixer.h".}
proc kore_mixer_stop_sound_stream*(stream: ptr kore_mixer_sound_stream) {.importc: "kore_mixer_stop_sound_stream", header: "kore3/mixer/mixer.h".}
proc kore_mixer_channel_get_volume*(channel: ptr kore_mixer_channel): float32 {.importc: "kore_mixer_channel_get_volume", header: "kore3/mixer/mixer.h".}
proc kore_mixer_channel_set_volume*(channel: ptr kore_mixer_channel, volume: float32) {.importc: "kore_mixer_channel_set_volume", header: "kore3/mixer/mixer.h".}
proc kore_mixer_mix*(buffer: ptr kore_audio_buffer, samples: uint32) {.importc: "kore_mixer_mix", header: "kore3/mixer/mixer.h".}

proc kore_mixer_sound_create*(filename: cstring): ptr kore_mixer_sound {.importc: "kore_mixer_sound_create", header: "kore3/mixer/sound.h".}
proc kore_mixer_sound_create_from_buffer*(audio_data: ptr uint8, size: uint32, format: cint): ptr kore_mixer_sound {.importc: "kore_mixer_sound_create_from_buffer", header: "kore3/mixer/sound.h".}
proc kore_mixer_sound_destroy*(sound: ptr kore_mixer_sound) {.importc: "kore_mixer_sound_destroy", header: "kore3/mixer/sound.h".}
proc kore_mixer_sound_volume*(sound: ptr kore_mixer_sound): float32 {.importc: "kore_mixer_sound_volume", header: "kore3/mixer/sound.h".}
proc kore_mixer_sound_set_volume*(sound: ptr kore_mixer_sound, value: float32) {.importc: "kore_mixer_sound_set_volume", header: "kore3/mixer/sound.h".}

proc kore_mixer_sound_stream_create*(filename: cstring, looping: bool): ptr kore_mixer_sound_stream {.importc: "kore_mixer_sound_stream_create", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_channels*(stream: ptr kore_mixer_sound_stream): cint {.importc: "kore_mixer_sound_stream_channels", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_sample_rate*(stream: ptr kore_mixer_sound_stream): cint {.importc: "kore_mixer_sound_stream_sample_rate", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_set_looping*(stream: ptr kore_mixer_sound_stream, loop: bool) {.importc: "kore_mixer_sound_stream_set_looping", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_reset*(stream: ptr kore_mixer_sound_stream) {.importc: "kore_mixer_sound_stream_reset", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_volume*(stream: ptr kore_mixer_sound_stream): float32 {.importc: "kore_mixer_sound_stream_volume", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_set_volume*(stream: ptr kore_mixer_sound_stream, value: float32) {.importc: "kore_mixer_sound_stream_set_volume", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_next_frame*(stream: ptr kore_mixer_sound_stream): ptr float32 {.importc: "kore_mixer_sound_stream_next_frame", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_looping*(stream: ptr kore_mixer_sound_stream): bool {.importc: "kore_mixer_sound_stream_looping", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_ended*(stream: ptr kore_mixer_sound_stream): bool {.importc: "kore_mixer_sound_stream_ended", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_length*(stream: ptr kore_mixer_sound_stream): float32 {.importc: "kore_mixer_sound_stream_length", header: "kore3/mixer/soundstream.h".}
proc kore_mixer_sound_stream_position*(stream: ptr kore_mixer_sound_stream): float32 {.importc: "kore_mixer_sound_stream_position", header: "kore3/mixer/soundstream.h".}

# --- io headers ---
proc kore_file_reader_open*(reader: ptr kore_file_reader, filename: cstring, `type`: cint): bool {.importc: "kore_file_reader_open", header: "kore3/io/filereader.h".}
proc kore_file_reader_from_memory*(reader: ptr kore_file_reader, data: pointer, size: int): bool {.importc: "kore_file_reader_from_memory", header: "kore3/io/filereader.h".}
proc kore_file_reader_set_callback*(callback: proc(reader: ptr kore_file_reader, filename: cstring, `type`: cint): bool {.cdecl.}) {.importc: "kore_file_reader_set_callback", header: "kore3/io/filereader.h".}
proc kore_file_reader_close*(reader: ptr kore_file_reader): bool {.importc: "kore_file_reader_close", header: "kore3/io/filereader.h".}
proc kore_file_reader_read*(reader: ptr kore_file_reader, data: pointer, size: int): int {.importc: "kore_file_reader_read", header: "kore3/io/filereader.h".}
proc kore_file_reader_size*(reader: ptr kore_file_reader): int {.importc: "kore_file_reader_size", header: "kore3/io/filereader.h".}
proc kore_file_reader_pos*(reader: ptr kore_file_reader): int {.importc: "kore_file_reader_pos", header: "kore3/io/filereader.h".}
proc kore_file_reader_seek*(reader: ptr kore_file_reader, pos: int): bool {.importc: "kore_file_reader_seek", header: "kore3/io/filereader.h".}
proc kore_read_f32le*(data: ptr uint8): float32 {.importc: "kore_read_f32le", header: "kore3/io/filereader.h".}
proc kore_read_f32be*(data: ptr uint8): float32 {.importc: "kore_read_f32be", header: "kore3/io/filereader.h".}
proc kore_read_u64le*(data: ptr uint8): uint64 {.importc: "kore_read_u64le", header: "kore3/io/filereader.h".}
proc kore_read_u64be*(data: ptr uint8): uint64 {.importc: "kore_read_u64be", header: "kore3/io/filereader.h".}
proc kore_read_s64le*(data: ptr uint8): int64 {.importc: "kore_read_s64le", header: "kore3/io/filereader.h".}
proc kore_read_s64be*(data: ptr uint8): int64 {.importc: "kore_read_s64be", header: "kore3/io/filereader.h".}
proc kore_read_u32le*(data: ptr uint8): uint32 {.importc: "kore_read_u32le", header: "kore3/io/filereader.h".}
proc kore_read_u32be*(data: ptr uint8): uint32 {.importc: "kore_read_u32be", header: "kore3/io/filereader.h".}
proc kore_read_s32le*(data: ptr uint8): int32 {.importc: "kore_read_s32le", header: "kore3/io/filereader.h".}
proc kore_read_s32be*(data: ptr uint8): int32 {.importc: "kore_read_s32be", header: "kore3/io/filereader.h".}
proc kore_read_u16le*(data: ptr uint8): uint16 {.importc: "kore_read_u16le", header: "kore3/io/filereader.h".}
proc kore_read_u16be*(data: ptr uint8): uint16 {.importc: "kore_read_u16be", header: "kore3/io/filereader.h".}
proc kore_read_s16le*(data: ptr uint8): int16 {.importc: "kore_read_s16le", header: "kore3/io/filereader.h".}
proc kore_read_s16be*(data: ptr uint8): int16 {.importc: "kore_read_s16be", header: "kore3/io/filereader.h".}
proc kore_read_u8*(data: ptr uint8): uint8 {.importc: "kore_read_u8", header: "kore3/io/filereader.h".}
proc kore_read_s8*(data: ptr uint8): int8 {.importc: "kore_read_s8", header: "kore3/io/filereader.h".}

proc kore_file_writer_open*(writer: ptr kore_file_writer, filepath: cstring): bool {.importc: "kore_file_writer_open", header: "kore3/io/filewriter.h".}
proc kore_file_writer_write*(writer: ptr kore_file_writer, data: pointer, size: cint) {.importc: "kore_file_writer_write", header: "kore3/io/filewriter.h".}
proc kore_file_writer_close*(writer: ptr kore_file_writer) {.importc: "kore_file_writer_close", header: "kore3/io/filewriter.h".}

# --- math headers ---
proc kore_matrix3x3_identity*(): kore_matrix3x3 {.importc: "kore_matrix3x3_identity", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_get*(matrix: ptr kore_matrix3x3, x, y: cint): float32 {.importc: "kore_matrix3x3_get", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_set*(matrix: ptr kore_matrix3x3, x, y: cint, value: float32) {.importc: "kore_matrix3x3_set", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_transpose*(matrix: ptr kore_matrix3x3) {.importc: "kore_matrix3x3_transpose", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_rotation_x*(alpha: float32): kore_matrix3x3 {.importc: "kore_matrix3x3_rotation_x", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_rotation_y*(alpha: float32): kore_matrix3x3 {.importc: "kore_matrix3x3_rotation_y", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_rotation_z*(alpha: float32): kore_matrix3x3 {.importc: "kore_matrix3x3_rotation_z", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_translation*(x, y: float32): kore_matrix3x3 {.importc: "kore_matrix3x3_translation", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_scale*(x, y, z: float32): kore_matrix3x3 {.importc: "kore_matrix3x3_scale", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_multiply*(a, b: ptr kore_matrix3x3): kore_matrix3x3 {.importc: "kore_matrix3x3_multiply", header: "kore3/math/matrix.h".}
proc kore_matrix3x3_multiply_vector*(a: ptr kore_matrix3x3, b: kore_vector3): kore_vector3 {.importc: "kore_matrix3x3_multiply_vector", header: "kore3/math/matrix.h".}

proc kore_matrix4x4_identity*(): kore_matrix4x4 {.importc: "kore_matrix4x4_identity", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_get*(matrix: ptr kore_matrix4x4, x, y: cint): float32 {.importc: "kore_matrix4x4_get", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_set*(matrix: ptr kore_matrix4x4, x, y: cint, value: float32) {.importc: "kore_matrix4x4_set", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_transpose*(matrix: ptr kore_matrix4x4) {.importc: "kore_matrix4x4_transpose", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_rotation_x*(alpha: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_rotation_x", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_rotation_y*(alpha: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_rotation_y", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_rotation_z*(alpha: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_rotation_z", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_translation*(x, y, z: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_translation", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_scale*(x, y, z: float32): kore_matrix4x4 {.importc: "kore_matrix4x4_scale", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_multiply*(a, b: ptr kore_matrix4x4): kore_matrix4x4 {.importc: "kore_matrix4x4_multiply", header: "kore3/math/matrix.h".}
proc kore_matrix4x4_multiply_vector*(a: ptr kore_matrix4x4, b: kore_vector4): kore_vector4 {.importc: "kore_matrix4x4_multiply_vector", header: "kore3/math/matrix.h".}

proc kore_random_init*(seed: int64) {.importc: "kore_random_init", header: "kore3/math/random.h".}
proc kore_random_get*(): int64 {.importc: "kore_random_get", header: "kore3/math/random.h".}
proc kore_random_get_max*(max: int64): int64 {.importc: "kore_random_get_max", header: "kore3/math/random.h".}
proc kore_random_get_in*(min, max: int64): int64 {.importc: "kore_random_get_in", header: "kore3/math/random.h".}

proc kore_cot*(x: float32): float32 {.importc: "kore_cot", header: "kore3/math/core.h".}
proc kore_round*(value: float32): float32 {.importc: "kore_round", header: "kore3/math/core.h".}
proc kore_abs*(value: float32): float32 {.importc: "kore_abs", header: "kore3/math/core.h".}
proc kore_min*(a, b: float32): float32 {.importc: "kore_min", header: "kore3/math/core.h".}
proc kore_max*(a, b: float32): float32 {.importc: "kore_max", header: "kore3/math/core.h".}
proc kore_mini*(a, b: cint): cint {.importc: "kore_mini", header: "kore3/math/core.h".}
proc kore_maxi*(a, b: cint): cint {.importc: "kore_maxi", header: "kore3/math/core.h".}
proc kore_clamp*(value, minValue, maxValue: float32): float32 {.importc: "kore_clamp", header: "kore3/math/core.h".}

# --- network headers ---
proc kore_socket_init*(socket: ptr kore_socket) {.importc: "kore_socket_init", header: "kore3/network/socket.h".}
proc kore_socket_destroy*(socket: ptr kore_socket) {.importc: "kore_socket_destroy", header: "kore3/network/socket.h".}
proc kore_socket_set*(socket: ptr kore_socket, host: cstring, port: cint, family: kore_socket_family, protocol: kore_socket_protocol): bool {.importc: "kore_socket_set", header: "kore3/network/socket.h".}
proc kore_socket_open*(socket: ptr kore_socket, parameters: ptr kore_socket_parameters): bool {.importc: "kore_socket_open", header: "kore3/network/socket.h".}
proc kore_socket_connect*(socket: ptr kore_socket): bool {.importc: "kore_socket_connect", header: "kore3/network/socket.h".}
proc kore_socket_bind*(socket: ptr kore_socket): bool {.importc: "kore_socket_bind", header: "kore3/network/socket.h".}
proc kore_socket_listen*(socket: ptr kore_socket, backlog: cint): bool {.importc: "kore_socket_listen", header: "kore3/network/socket.h".}
proc kore_socket_accept*(socket, new_socket: ptr kore_socket, remote_address, remote_port: ptr cuint): bool {.importc: "kore_socket_accept", header: "kore3/network/socket.h".}
proc kore_socket_select*(socket: ptr kore_socket, waittime: uint32, read, write: bool): bool {.importc: "kore_socket_select", header: "kore3/network/socket.h".}
proc kore_socket_send*(socket: ptr kore_socket, data: ptr uint8, size: cint): cint {.importc: "kore_socket_send", header: "kore3/network/socket.h".}
proc kore_socket_send_address*(socket: ptr kore_socket, address: cuint, port: cint, data: ptr uint8, size: cint): cint {.importc: "kore_socket_send_address", header: "kore3/network/socket.h".}
proc kore_socket_send_url*(socket: ptr kore_socket, url: cstring, port: cint, data: ptr uint8, size: cint): cint {.importc: "kore_socket_send_url", header: "kore3/network/socket.h".}
proc kore_socket_receive*(socket: ptr kore_socket, data: ptr uint8, maxSize: cint, from_address, from_port: ptr cuint): cint {.importc: "kore_socket_receive", header: "kore3/network/socket.h".}
proc kore_socket_parameters_set_defaults*(parameters: ptr kore_socket_parameters) {.importc: "kore_socket_parameters_set_defaults", header: "kore3/network/socket.h".}
proc kore_url_to_int*(url: cstring, port: cint): cuint {.importc: "kore_url_to_int", header: "kore3/network/socket.h".}

proc kore_http_request*(url, path, data: cstring, port: cint, secure: bool, `method`: cint, header: cstring, callback: pointer, callbackdata: pointer) {.importc: "kore_http_request", header: "kore3/network/http.h".}

# --- threads headers ---
proc kore_threads_init*() {.importc: "kore_threads_init", header: "kore3/threads/thread.h".}
proc kore_threads_quit*() {.importc: "kore_threads_quit", header: "kore3/threads/thread.h".}
proc kore_thread_init*(thread: ptr kore_thread, func_ptr: proc(param: pointer) {.cdecl.}, param: pointer) {.importc: "kore_thread_init", header: "kore3/threads/thread.h".}
proc kore_thread_wait_and_destroy*(thread: ptr kore_thread) {.importc: "kore_thread_wait_and_destroy", header: "kore3/threads/thread.h".}
proc kore_thread_try_to_destroy*(thread: ptr kore_thread): bool {.importc: "kore_thread_try_to_destroy", header: "kore3/threads/thread.h".}
proc kore_thread_set_name*(name: cstring) {.importc: "kore_thread_set_name", header: "kore3/threads/thread.h".}
proc kore_thread_sleep*(milliseconds: cint) {.importc: "kore_thread_sleep", header: "kore3/threads/thread.h".}

proc kore_mutex_init*(mutex: ptr kore_mutex) {.importc: "kore_mutex_init", header: "kore3/threads/mutex.h".}
proc kore_mutex_destroy*(mutex: ptr kore_mutex) {.importc: "kore_mutex_destroy", header: "kore3/threads/mutex.h".}
proc kore_mutex_lock*(mutex: ptr kore_mutex) {.importc: "kore_mutex_lock", header: "kore3/threads/mutex.h".}
proc kore_mutex_try_to_lock*(mutex: ptr kore_mutex): bool {.importc: "kore_mutex_try_to_lock", header: "kore3/threads/mutex.h".}
proc kore_mutex_unlock*(mutex: ptr kore_mutex) {.importc: "kore_mutex_unlock", header: "kore3/threads/mutex.h".}

proc kore_uber_mutex_init*(mutex: ptr kore_uber_mutex, name: cstring): bool {.importc: "kore_uber_mutex_init", header: "kore3/threads/mutex.h".}
proc kore_uber_mutex_destroy*(mutex: ptr kore_uber_mutex) {.importc: "kore_uber_mutex_destroy", header: "kore3/threads/mutex.h".}
proc kore_uber_mutex_lock*(mutex: ptr kore_uber_mutex) {.importc: "kore_uber_mutex_lock", header: "kore3/threads/mutex.h".}
proc kore_uber_mutex_unlock*(mutex: ptr kore_uber_mutex) {.importc: "kore_uber_mutex_unlock", header: "kore3/threads/mutex.h".}

proc kore_semaphore_init*(semaphore: ptr kore_semaphore, current, max: cint) {.importc: "kore_semaphore_init", header: "kore3/threads/semaphore.h".}
proc kore_semaphore_destroy*(semaphore: ptr kore_semaphore) {.importc: "kore_semaphore_destroy", header: "kore3/threads/semaphore.h".}
proc kore_semaphore_release*(semaphore: ptr kore_semaphore, count: cint) {.importc: "kore_semaphore_release", header: "kore3/threads/semaphore.h".}
proc kore_semaphore_acquire*(semaphore: ptr kore_semaphore) {.importc: "kore_semaphore_acquire", header: "kore3/threads/semaphore.h".}
proc kore_semaphore_try_to_acquire*(semaphore: ptr kore_semaphore, timeout: float64): bool {.importc: "kore_semaphore_try_to_acquire", header: "kore3/threads/semaphore.h".}

proc kore_event_init*(event: ptr kore_event, auto_clear: bool) {.importc: "kore_event_init", header: "kore3/threads/event.h".}
proc kore_event_destroy*(event: ptr kore_event) {.importc: "kore_event_destroy", header: "kore3/threads/event.h".}
proc kore_event_signal*(event: ptr kore_event) {.importc: "kore_event_signal", header: "kore3/threads/event.h".}
proc kore_event_wait*(event: ptr kore_event) {.importc: "kore_event_wait", header: "kore3/threads/event.h".}
proc kore_event_try_to_wait*(event: ptr kore_event, timeout: float64): bool {.importc: "kore_event_try_to_wait", header: "kore3/threads/event.h".}
proc kore_event_reset*(event: ptr kore_event) {.importc: "kore_event_reset", header: "kore3/threads/event.h".}

# --- video.h ---
proc kore_video_formats*(): ptr cstring {.importc: "kore_video_formats", header: "kore3/video.h".}
proc kore_video_init*(video: ptr kore_video, filename: cstring) {.importc: "kore_video_init", header: "kore3/video.h".}
proc kore_video_destroy*(video: ptr kore_video) {.importc: "kore_video_destroy", header: "kore3/video.h".}
proc kore_video_play*(video: ptr kore_video, loop: bool) {.importc: "kore_video_play", header: "kore3/video.h".}
proc kore_video_pause*(video: ptr kore_video) {.importc: "kore_video_pause", header: "kore3/video.h".}
proc kore_video_stop*(video: ptr kore_video) {.importc: "kore_video_stop", header: "kore3/video.h".}
proc kore_video_width*(video: ptr kore_video): cint {.importc: "kore_video_width", header: "kore3/video.h".}
proc kore_video_height*(video: ptr kore_video): cint {.importc: "kore_video_height", header: "kore3/video.h".}
proc kore_video_current_image*(video: ptr kore_video): ptr kore_gpu_texture {.importc: "kore_video_current_image", header: "kore3/video.h".}
proc kore_video_duration*(video: ptr kore_video): float64 {.importc: "kore_video_duration", header: "kore3/video.h".}
proc kore_video_position*(video: ptr kore_video): float64 {.importc: "kore_video_position", header: "kore3/video.h".}
proc kore_video_finished*(video: ptr kore_video): bool {.importc: "kore_video_finished", header: "kore3/video.h".}
proc kore_video_paused*(video: ptr kore_video): bool {.importc: "kore_video_paused", header: "kore3/video.h".}
proc kore_video_update*(video: ptr kore_video, time: float64) {.importc: "kore_video_update", header: "kore3/video.h".}

# --- framebuffer.h ---
proc kore_fb_init*() {.importc: "kore_fb_init", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_begin*() {.importc: "kore_fb_begin", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_end*() {.importc: "kore_fb_end", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_set_pixel*(x, y: uint32, red, green, blue: uint8) {.importc: "kore_fb_set_pixel", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_width*(): cint {.importc: "kore_fb_width", header: "kore3/framebuffer/framebuffer.h".}
proc kore_fb_height*(): cint {.importc: "kore_fb_height", header: "kore3/framebuffer/framebuffer.h".}

# --- Additional from comparative review ---
proc kore_color_components*(color: uint32, red, green, blue, alpha: ptr uint8) {.importc: "kore_color_components", header: "kore3/color.h".}
proc kore_LivePP_start*() {.importc: "kore_LivePP_start", header: "kore3/system.h".}
proc kore_LivePP_stop*() {.importc: "kore_LivePP_stop", header: "kore3/system.h".}
