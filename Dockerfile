# This Dockerfile creates an image of "ParaView_5.1.2 with OpenGL and OSMesa using llvmpipe, X Window System, MPICH, Python and FFmpeg".

# FROM CentOS
FROM centos:latest

# MAINTAINER is ishidakauya
MAINTAINER ishidakazuya

# ADD the script for installation of ParaView
COPY install.sh /root

# Install modules
RUN yum -y update \
&& yum -y install mpich mpich-devel gcc gcc-c++ make git python-devel numpy llvm llvm-devel boost boost-devel mesa* \
&& yum -y groupinstall "X Window System" \
&& git clone https://github.com/FFmpeg/FFmpeg /FFmpeg \
&& cd /FFmpeg \
&& ./configure --disable-yasm --enable-shared \
&& make -j8 \
&& make install \
&& rm -rf /FFmpeg \
&& cd / \
&& curl -O https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz \
&& tar -xvf cmake-3.6.2.tar.gz \
&& rm -f cmake-3.6.2.tar.gz \
&& cd /cmake-3.6.2 \
&& ./configure \
&& gmake -j8 \
&& gmake install \
&& cd / \
&& rm -rf /cmake-3.6.2 \
&& git clone https://github.com/Kitware/ParaView.git /root/ParaView_src \
&& mkdir /root/build \
&& mv /root/install.sh /root/build 

# ADD the directory of mesa-llvm
ADD mesa-llvm.tar.bz2 /

# Install ParaView and uninstall extra tools
WORKDIR /root/ParaView_src
RUN git config submodule.VTK.url https://github.com/Kitware/VTK.git \
&& git checkout v5.1.2 \
&& git submodule init \
&& git submodule update \
&& cd /root/build \
&& bash install.sh \
&& rm -rf /root/ParaView_src \
&& rm -rf /root/build \
&& yum -y remove gcc gcc-c++ make git \
&& yum clean all \
&& cd /root

# Set PATH
ENV PATH=$PATH:/usr/lib64/mpich/bin

# CMD is /bin/bash
CMD /bin/bash

