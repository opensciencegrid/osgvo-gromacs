FROM gromacs/gromacs

MAINTAINER Mats Rynge <rynge@isi.edu>

# required directories
RUN mkdir -p /cvmfs

# make sure we have a way to bind host provided libraries
# see https://github.com/singularityware/singularity/issues/611
RUN mkdir -p /host-libs /etc/OpenCL/vendors

# some extra singularity stuff
COPY .singularity.d /.singularity.d
RUN cd / && \
    ln -s .singularity.d/actions/exec .exec && \
    ln -s .singularity.d/actions/run .run && \
    ln -s .singularity.d/actions/test .shell && \
    ln -s .singularity.d/runscript singularity

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

