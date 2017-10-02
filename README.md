# Dockerfile of ParaView (v5.1.2) with Mesa-LLVM
This image has ParaView rendering servers (pvserver, pvrenderserver, pvdataserver, etc.).
- OS is CentOS (latest).
- The install directory is /usr/local/ParaView_5.1.2
- MPICH and Python are also included.
- This image includes OSMesa using Gallium llvmpipe.
(It can do onscreen rendering even if your OpenGL driver is not supported by ParaView)
