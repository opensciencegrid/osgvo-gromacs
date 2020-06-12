FROM gromacs/gromacs

MAINTAINER Mats Rynge <rynge@isi.edu>

# extra packages we need
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        curl \
        python-pip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# stashcp
RUN pip install --upgrade pip==9.0.3 && \
    pip install setuptools && \
    pip install stashcp

# required directories
RUN for MNTPOINT in \
        /cvmfs \
        /hadoop \
        /hdfs \
        /lizard \
        /mnt/hadoop \
        /mnt/hdfs \
        /xenon \
        /spt \
        /stash2 \
    ; do \
        mkdir -p $MNTPOINT ; \
    done

# make sure we have a way to bind host provided libraries
# see https://github.com/singularityware/singularity/issues/611
RUN mkdir -p /etc/OpenCL/vendors

# some extra singularity stuff
COPY .singularity.d /.singularity.d

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

