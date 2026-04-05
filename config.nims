
import os

# Configuration: Selection of Graphics API
# Possible values: "opengl", "vulkan", "direct3d12", "metal"
const graphicsApi = "opengl"

# Platform detection and specific settings
var platformDefine = "-DKORE_LINUX"
var libs = @["-lasound", "-ldl", "-ludev", "-lGL", "-lEGL", "-lX11"]
var backendGpuSource = "backends/gpu/opengl/sources/openglunit.c"
var backendSystemSource = "backends/system/linux/sources/linuxunit.c"

when defined(windows):
  platformDefine = "-DKORE_WINDOWS"
  backendSystemSource = "backends/system/windows/sources/windowsunit.c"
  if graphicsApi == "direct3d12":
    libs = @["-ld3d12", "-ldxgi", "-ld3dcompiler"]
    backendGpuSource = "backends/gpu/direct3d12/sources/d3d12unit.c"
  else:
    libs = @["-lopengl32", "-lgdi32"]
    backendGpuSource = "backends/gpu/opengl/sources/openglunit.c"
elif defined(macosx):
  platformDefine = "-DKORE_MACOS"
  backendSystemSource = "backends/system/macos/sources/macosunit.m"
  if graphicsApi == "metal":
    libs = @["-framework Metal", "-framework QuartzCore"]
    backendGpuSource = "backends/gpu/metal/sources/metalunit.m"
  else:
    libs = @["-framework OpenGL"]
    backendGpuSource = "backends/gpu/opengl/sources/openglunit.c"

# Include Paths
--passC: "-Iincludes"
--passC: "-Ibackends/system/linux/includes"
--passC: "-Ibackends/system/posix/includes"
--passC: "-Ibackends/gpu/opengl/includes"
--passC: "-Ibackends/gpu/vulkan/includes"
--passC: "-Ibackends/gpu/direct3d12/includes"
--passC: "-Ibackends/gpu/metal/includes"
--passC: "-Ibackends/gpu/opengl/includes/GL"
--passC: "-Isources/libs/lz4"
--passC: "-I."

# Defines
switch("passC", platformDefine)
--passC: "-DKORE_POSIX"
--passC: "-DKORE_NO_WAYLAND"
--passC: "-DKORE_NO_X11"
--passC: "-DKORE_LZ4X"
--passC: "-DGLEW_STATIC"
--passC: "-DKORE_NO_MAIN"

if graphicsApi == "opengl":
  --passC: "-DKORE_OPENGL"
  --passC: "-DKORE_EGL"
elif graphicsApi == "vulkan":
  --passC: "-DKORE_VULKAN"
elif graphicsApi == "direct3d12":
  --passC: "-DKORE_DIRECT3D12"
elif graphicsApi == "metal":
  --passC: "-DKORE_METAL"

# Libraries
for lib in libs:
  switch("passL", lib)

# Compile Kore source files (Unit Build style)
var sources = @[
  "sources/root/rootunit.c",
  "sources/gpu/gpuunit.c",
  backendSystemSource,
  "backends/system/posix/sources/posixunit.c",
  backendGpuSource,
  "sources/libs/offalloc/offalloc.c",
  "sources/libs/lz4/lz4.c"
]

if graphicsApi == "opengl":
  sources.add("backends/gpu/opengl/libs/glew/glew.c")

for src in sources:
  switch("compile", src)
