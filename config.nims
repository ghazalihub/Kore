
import os

# Platform detection
var platformDefine = "-DKORE_LINUX"
var libs = @["-lasound", "-ldl", "-ludev", "-lGL", "-lEGL", "-lX11"]

when defined(windows):
  platformDefine = "-DKORE_WINDOWS"
  libs = @["-lopengl32", "-lgdi32", "-lwinmm", "-lws2_32"]
elif defined(macosx):
  platformDefine = "-DKORE_MACOS"
  libs = @["-framework Cocoa", "-framework OpenGL", "-framework IOKit", "-framework CoreAudio"]

--passC: "-Iincludes"
--passC: "-Ibackends/system/linux/includes"
--passC: "-Ibackends/system/posix/includes"
--passC: "-Ibackends/gpu/opengl/includes"
--passC: "-Ibackends/gpu/opengl/includes/GL"
--passC: "-Isources/libs/lz4"
--passC: "-I."

switch("passC", platformDefine)
--passC: "-DKORE_POSIX"
--passC: "-DKORE_OPENGL"
--passC: "-DKORE_EGL"
--passC: "-DKORE_NO_WAYLAND"
--passC: "-DKORE_NO_X11"
--passC: "-DKORE_LZ4X"
--passC: "-DGLEW_STATIC"
--passC: "-DKORE_NO_MAIN"

for lib in libs:
  switch("passL", lib)

# Compile Kore source files (Unit Build style)
let sources = [
  "sources/root/rootunit.c",
  "sources/gpu/gpuunit.c",
  "backends/system/linux/sources/linuxunit.c",
  "backends/system/posix/sources/posixunit.c",
  "backends/gpu/opengl/sources/openglunit.c",
  "backends/gpu/opengl/libs/glew/glew.c",
  "sources/libs/offalloc/offalloc.c",
  "sources/libs/lz4/lz4.c"
]

for src in sources:
  switch("compile", src)
