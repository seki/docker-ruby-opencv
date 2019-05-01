FROM ruby:2.6.3
MAINTAINER seki <m_seki@mac.com>

RUN apt-get update && \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libavformat-dev \
        libgtkglext1-dev \
        libpq-dev

RUN wget https://github.com/opencv/opencv/archive/2.4.13.3.zip \
&& unzip 2.4.13.3.zip \
&& mkdir /opencv-2.4.13.3/cmake_binary \
&& cd /opencv-2.4.13.3/cmake_binary \
&& cmake -DWITH_QT=OFF \
        -DWITH_OPENGL=ON \
        -DFORCE_VTK=OFF \
        -DWITH_TBB=ON \
        -DWITH_GDAL=ON \
        -DWITH_XINE=ON \
        -DBUILD_EXAMPLES=OFF \
        -DENABLE_PRECOMPILED_HEADERS=OFF .. \
&& make install \
&& rm /2.4.13.3.zip \
&& rm -r /opencv-2.4.13.3

RUN wget http://www.ess.ic.kanagawa-it.ac.jp/std_img/monoimage/mono.zip \
&& mkdir /opt/SIDBA \
&& mkdir /opt/SIDBA/mono \
&& cd /opt/SIDBA/mono \
&& unzip /mono.zip \
&& rm /mono.zip

RUN wget http://www.ess.ic.kanagawa-it.ac.jp/std_img/colorimage/color.zip \
&& mkdir /opt/SIDBA/color \
&& cd /opt/SIDBA/color \
&& unzip /color.zip \
&& rm /color.zip

# Run the image as a non-root user
RUN adduser myuser
USER myuser

RUN gem install ruby-opencv

CMD [ "irb", "-r", "opencv" ]
