
import kore

var
  device: kore_gpu_device
  command_list: kore_gpu_command_list

proc update(data: pointer) {.cdecl.} =
  let framebuffer = kore_gpu_device_get_framebuffer(addr device)

  var render_pass: kore_gpu_render_pass_parameters
  render_pass.color_attachments_count = 1
  render_pass.color_attachments[0].texture.texture = framebuffer
  render_pass.color_attachments[0].texture.format = kore_gpu_texture_format.RGBA8_UNORM
  render_pass.color_attachments[0].texture.mip_level_count = 1
  render_pass.color_attachments[0].texture.array_layer_count = 1
  render_pass.color_attachments[0].texture.dimension = kore_gpu_texture_view_dimension.DIMENSION_2D
  render_pass.color_attachments[0].texture.aspect = kore_gpu_texture_aspect.ALL

  render_pass.color_attachments[0].clear_value = kore_gpu_color(r: 1.0, g: 0.0, b: 0.0, a: 1.0)
  render_pass.color_attachments[0].load_op = kore_gpu_load_op.CLEAR
  render_pass.color_attachments[0].store_op = kore_gpu_store_op.STORE

  kore_gpu_command_list_begin_render_pass(addr command_list, addr render_pass)
  kore_gpu_command_list_end_render_pass(addr command_list)
  kore_gpu_command_list_present(addr command_list)
  kore_gpu_device_execute_command_list(addr device, addr command_list)

proc main() =
  var win_params: kore_window_parameters
  var frame_params: kore_framebuffer_parameters

  kore_window_options_set_defaults(addr win_params)
  kore_framebuffer_options_set_defaults(addr frame_params)

  let window_id = kore_init("Kore Nim Triangle", 1024, 768, addr win_params, addr frame_params)
  if window_id < 0:
    quit("Failed to initialize Kore")

  kore_gpu_init(kore_gpu_api.OPENGL)
  kore_gpu_device_create(addr device, nil)
  kore_gpu_device_create_command_list(addr device, 0, addr command_list) # 0 = Graphics

  kore_set_update_callback(update, nil)

  kore_start()

main()
