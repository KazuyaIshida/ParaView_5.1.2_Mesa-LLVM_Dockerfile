# Dockerfile of ParaView (v5.1.2) with Mesa-LLVM
This image has ParaView rendering servers (pvserver, pvrenderserver, pvdataserver, etc.).
- The base image is CentOS (latest).
- The install directory is /usr/local/ParaView_5.1.2
- Dependencies (MPICH, Python and FFmpeg) are also included.
- This image includes OSMesa using Gallium llvmpipe (you can do onscreen rendering).
