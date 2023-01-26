FROM python:3.6.8

# UPDATE PACKAGE MANAGER
RUN apt-get update -y
RUN apt-get upgrade -y

# INSTALL MAKE AND COMPILATION
RUN apt-get install make g++

# INSTALL WGET
RUN apt-get install wget

# INSTALL SED
RUN apt-get install sed

# INSTALL LIBTIFF
RUN apt-get install libjpeg-dev liblzma-dev liblz-dev zlib1g-dev -y
RUN wget http://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz
RUN tar -zxvf tiff-4.1.0.tar.gz
RUN rm tiff-4.1.0.tar.gz
WORKDIR /tiff-4.1.0
RUN ./configure
RUN make
RUN make install
RUN ldconfig

# COPY PYTHON CODE
WORKDIR /app
COPY . .

# REGION INSTALL DEPENDENCIES
RUN python -m pip install --upgrade pip
RUN python -m pip install --upgrade wheel
RUN python -m pip install numpy==1.19.5
RUN python -m pip install --no-cache-dir -r requirements.txt

# REMOVE INVALID CODE MANUALLY
WORKDIR /usr/local/lib/python3.6/site-packages/libtiff
RUN sed -i 's/xrange/range/g' libtiff_ctypes.py

# RETURN TO APP WORKING DIR
WORKDIR /app