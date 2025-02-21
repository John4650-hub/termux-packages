TERMUX_PKG_HOMEPAGE=https://github.com/John4650-hub/my-Termux-packs
TERMUX_PKG_DESCRIPTION="A timer for my personal use"
TERMUX_PKG_API_LEVEL=23
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@john4650-hub"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_SRCURL=https://github.com/John4650-hub/my-Termux-packs/archive/refs/tags/$(curl -s https://api.github.com/repos/John4650-hub/my-Termux-packs/releases/latest | jq -r .tag_name).tar.gz
TERMUX_PKG_SHA256=SKIP_CHECKSUM
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_BUILD_DEPENDS="libftxui"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
curl -L "https://maven.google.com/com/google/oboe/oboe/1.9.3/oboe-1.9.3.aar" -o oboe.aar
unzip oboe.aar -d foo/
#get lib
cp foo/prefab/modules/oboe/libs/android.armeabi-v7a/liboboe.so "$TERMUX_PREFIX/lib"
#get headers
cp -r foo/prefab/modules/oboe/include/oboe "$TERMUX_PREFIX/include"

curl -L "https://github.com/John4650-hub/my-Termux-packs/archive/refs/tags/741.0.0.zip" -o ffmpeg.zip
unzip ffmpeg.zip -d dir
cp dir/my-Termux-packs-741.0.0/src/lib/* "$TERMUX_PREFIX/lib/" -r
cp -r dir/my-Termux-packs-741.0.0/src/include/* "$TERMUX_PREFIX/include"
exit 1
