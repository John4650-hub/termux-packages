TERMUX_PKG_HOMEPAGE=https://github.com/John4650-hub/my-Termux-packs
TERMUX_PKG_DESCRIPTION="A pdfViewer using pdfmium"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@john4650-hub"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_API_LEVEL=23
TERMUX_PKG_SRCURL=https://github.com/John4650-hub/my-Termux-packs/archive/refs/tags/$(curl -s https://api.github.com/repos/John4650-hub/my-Termux-packs/releases/latest | jq -r .tag_name).tar.gz
TERMUX_PKG_SHA256=SKIP_CHECKSUM
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_DEPENDS="libpng"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_INCLUDE_DIR="$TERMUX_PREFIX/include"
TERMUX_LIB_DIR="$TERMUX_PREFIX/lib"
#download pdfium-no-v8
curl -L "https://github.com/bblanchon/pdfium-binaries/releases/latest/download/pdfium-android-arm.tgz" -o pdfium-android-arm.tgz
mkdir foo/ && cd foo
tar -xvzf ../pdfium-android-arm.tgz
cd ..
# get lib
cp -r foo/lib/ "$TERMUX_PREFIX"
# get headers
# ok
cp -r foo/include "$TERMUX_PREFIX"

mkdir argparse
 cd argparse
 curl -LO "https://raw.githubusercontent.com/p-ranav/argparse/refs/heads/master/include/argparse/argparse.hpp"
 cd ..
 cp -r argparse "$TERMUX_INCLUDE_DIR/"

curl -LO "https://grimler.se/termux-main-21/pool/main/m/mupdf-static/mupdf-static_1.16.1-1_arm.deb"
dpkg -x mupdf-static_1.16.1-1_arm.deb mupdf_static
cp -r mupdf_static/data/data/com.termux/files/usr/* "$TERMUX_PREFIX"

curl -L "https://github.com/JamyJones/Heavy-runner/releases/download/0.1293.0/libMuPDF.so" -o "$TERMUX_PREFIX/lib/libmupdf.so"

