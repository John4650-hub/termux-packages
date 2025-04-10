TERMUX_PKG_HOMEPAGE=https://github.com/John4650-hub/my-Termux-packs
TERMUX_PKG_DESCRIPTION="A pdfViewer using pdfmium"
TERMUX_PKG_API_LEVEL=23
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@john4650-hub"
TERMUX_PKG_VERSION=1.0.0
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
cp foo/lib/libpdfium.so "$TERMUX_LIB_DIR"
# get headers
# ok
cp -r foo/include/* "$TERMUX_INCLUDE_DIR"
# get opencv

curl -LO "https://github.com/nihui/opencv-mobile/releases/download/v32/opencv-mobile-2.4.13.7-android.zip"
unzip "opencv-mobile-2.4.13.7-android.zip" -d ./
cp -r opencv-mobile-2.4.13.7-android/sdk/native/jni/include/* "$TERMUX_INCLUDE_DIR"
cp -r opencv-mobile-2.4.13.7-android/sdk/native/libs/armeabi-v7a/* "$TERMUX_LIB_DIR"

#get libomp.a //depended on by opencv
curl -L "https://grimler.se/termux-ma,in/pool/main/c/clang/clang_20.1.2_arm.deb" -o llvm.deb
dpkg -x llvm.deb llvm
cp llvm/data/data/com.termux/files/usr/lib/libomp.a "$TERMUX_LIB_DIR"

#get tesseract
curl -L "https://grimler.se/termux-main/pool/main/t/tesseract/tesseract_5.5.0-2_arm.deb" -o tesseract.deb
dpkg -x tesseract.deb tesseract
cp -r tesseract/data/data/com.termux/files/usr/* "$TERMUX_PREFIX"

#get leptonica
curl -L "https://grimler.se/termux-main/pool/main/l/leptonica-static/leptonica-static_1.85.0_arm.deb" -o leptonica.deb
dpkg -x leptonica.deb leptonica
cp -r leptonica/data/data/com.termux/files/usr/* "$TERMUX_PREFIX"

