# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set the environment variables
ENV mosdepth_version 0.2.8
ENV htslib_version 1.9

# run update
RUN apt-get update -y && apt-get install -y \
    libnss-sss \
    curl \
    less \
    vim  \
    wget \
    unzip \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libnss-sss \
    libbz2-dev \
    liblzma-dev \
    bzip2 \
    libcurl4-openssl-dev \
    git \
    bwa \
    cmake

# install htslib
WORKDIR /usr/local/bin/
RUN curl -SL https://github.com/samtools/htslib/releases/download/${htslib_version}/htslib-${htslib_version}.tar.bz2 \
    > /usr/local/bin/htslib-${htslib_version}.tar.bz2
RUN tar -xjf /usr/local/bin/htslib-${htslib_version}.tar.bz2 -C /usr/local/bin/
RUN cd /usr/local/bin/htslib-${htslib_version}/ && ./configure
RUN cd /usr/local/bin/htslib-${htslib_version}/ && make
RUN cd /usr/local/bin/htslib-${htslib_version}/ && make install
ENV LD_LIBRARY_PATH /usr/local/bin/htslib-${htslib_version}/

# install mosdepth
WORKDIR /usr/local/bin
RUN curl -fsSL https://github.com/brentp/mosdepth/releases/download/v0.2.8/mosdepth -o /usr/bin/mosdepth \
&& chmod +x /usr/bin/mosdepth

WORKDIR /usr/local/bin/
ENTRYPOINT ["mosdepth"]
