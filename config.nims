
import os

--passC: "-Iincludes"
--passC: "-Ibackends/system/linux/includes"
--passC: "-Ibackends/system/posix/includes"
--passC: "-Ibackends/gpu/opengl/includes"
--passC: "-Ibackends/gpu/opengl/includes/GL"
--passC: "-Isources/libs/lz4"
--passC: "-I."

--passC: "-DKORE_LINUX"
--passC: "-DKORE_POSIX"
--passC: "-DKORE_OPENGL"
--passC: "-DKORE_EGL"
--passC: "-DKORE_NO_WAYLAND"
--passC: "-DKORE_NO_X11"
--passC: "-DKORE_LZ4X"
--passC: "-DGLEW_STATIC"
--passC: "-DKORE_NO_MAIN"

--passL: "-lasound"
--passL: "-ldl"
--passL: "-ludev"
--passL: "-lGL"
--passL: "-lEGL"

# Compile Kore source files
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
