TERMUX_PKG_HOMEPAGE=https://github.com/axel-download-accelerator/axel
TERMUX_PKG_DESCRIPTION="light command line download accelerator"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=2.16.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_MAINTAINER="lokesh @hax4us"
TERMUX_PKG_DEPENDS="openssl"
TERMUX_PKG_BUILD_DEPENDS="pkg-config, gettext"
TERMUX_PKG_SHA256=675a8608ffa305b98624a3c2684c84e4696572e3fd7dce6d12e0a9b61d64b67f
TERMUX_PKG_SRCURL=https://github.com/axel-download-accelerator/axel/releases/download/v${TERMUX_PKG_VERSION}/axel-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_EXTRA_CONFIGURE_ARGS=" --disable-nls"
