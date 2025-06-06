TERMUX_PKG_HOMEPAGE=https://www.libarchive.org/
TERMUX_PKG_DESCRIPTION="Multi-format archive and compression library"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="3.7.9"
TERMUX_PKG_API_LEVEL=23
TERMUX_PKG_SRCURL=https://github.com/libarchive/libarchive/releases/download/v$TERMUX_PKG_VERSION/libarchive-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=aa90732c5a6bdda52fda2ad468ac98d75be981c15dde263d7b5cf6af66fd009f
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libbz2, libiconv, liblzma, libxml2, openssl, zlib"
TERMUX_PKG_BUILD_DEPENDS="libc++, libcpufeatures, libxml2, liblzma, libiconv, libbz2, openssl, zlib, libarchive"
TERMUX_PKG_BREAKS="libarchive-dev"
TERMUX_PKG_REPLACES="libarchive-dev"

termux_step_pre_configure() {
        LDFLAGS+=" -L$TERMUX_PREFIX -static -static-libgcc -static-libstdc++"
}


# --without-nettle to use openssl instead:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--without-nettle
--without-lz4
--without-zstd
--disable-acl
--disable-xattr
"

termux_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=13

	local v=$(sed -En 's/^ARCHIVE_INTERFACE=`echo \$\(\(([0-9]+).*/\1/p' \
			configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		termux_error_exit "SOVERSION guard check failed."
	fi
}

termux_step_post_make_install() {
	# https://github.com/libarchive/libarchive/issues/1766
	sed -i '/^Requires\.private:/s/ iconv//' \
		$TERMUX_PREFIX/lib/pkgconfig/libarchive.pc
}
curl -L "https://grimler.se/termux-main/pool/main/libx/libxml2/libxml2_2.13.7_arm.deb" -o xml2.deb
dpkg -x xml2.deb xml2
cp -r xml2/data/data/com.termux/files/usr/* "$TERMUX_PREFIX"
