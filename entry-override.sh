# download package matching the current kernel from build artifacts
koji download-build --rpm --arch=x86_64 kernel-devel-$(uname -r)
# unpack the kernel headers in the /opt directory. The default /usr/src directory is mounted read only at this point and cannot be used
rpm2cpio ./kernel-devel-$(uname -r).rpm | cpio -idD /opt

# set the KDIR variable, telling DRBD to search for the headers in /opt
export KDIR=/opt/usr/src/kernels/$(uname -r)
exec /entry.sh "$@"