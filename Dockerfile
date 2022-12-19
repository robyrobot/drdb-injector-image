# Pull in DRBD sources and entrypoint
FROM quay.io/piraeusdatastore/drbd9-centos8:latest as SOURCE

FROM fedora:33

# Packages needed for the DRBD build process.
RUN yum install -y gcc make coccinelle koji cpio patch perl-interpreter diffutils kmod elfutils-libelf-devel \
  && yum clean all

# Our script from above
COPY entry-override.sh /
# The DRBD sources and build script from an existing injector image
COPY --from=SOURCE /entry.sh /drbd.tar.gz /

ENV LB_HOW=compile
# Use our download script as entrypoint
ENTRYPOINT ["sh", "-e", "/entry-override.sh"]