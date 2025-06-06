echo $DOCKER_EXEC_PID_FILE_PATH
docker inspect --format '{{.State.Pid}}' termux-package-builder
exit 0
TERMUX_PKG_HOMEPAGE=https://mupdf.com/
TERMUX_PKG_DESCRIPTION="Lightweight PDF and XPS viewer (library)"
TERMUX_PKG_LICENSE="AGPL-V3"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.24.10"
TERMUX_PKG_API_LEVEL=23
TERMUX_PKG_SRCURL=https://mupdf.com/downloads/archive/mupdf-${TERMUX_PKG_VERSION}-source.tar.gz
TERMUX_PKG_SHA256=939285b5f97caf770fd46cbe7e6cc3a695ab19bb5bfaf5712904549cef390b7b
TERMUX_PKG_EXTRA_MAKE_ARGS="prefix=$TERMUX_PREFIX build=release libs shared=yes tesseract=no V=1"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_BUILD_DEPENDS="openjpeg, freetype, freeglut, harfbuzz, jbig2dec, gumbo-parser"

# Automatic updates break k2pdfopt on regular basis
TERMUX_PKG_AUTO_UPDATE=false

termux_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
	sed -i "s/HAVE_OBJCOPY := yes/HAVE_OBJCOPY := no/g" $TERMUX_PKG_SRCDIR/Makerules
  sed "40 a\
long ftello(FILE *stream) { return (long)ftell(stream);}\
int fseeko(FILE *stream, off_t offset, int whence) {return fseek(stream, (long)offset, whence);}" "$TERMUX_PKG_SRCDIR/source/fitz/output.c"
}

termux_step_pre_configure() {
	rm -rf thirdparty/{freeglut,freetype,harfbuzz,jbig2dec,leptonica,libjpeg,openjpeg,tesseract,zlib}
	export USE_SYSTEM_LIBS=yes
}

termux_step_post_make_install() {
	TERMUX_PKG_EXTRA_MAKE_ARGS="${TERMUX_PKG_EXTRA_MAKE_ARGS/shared=yes/}"
	termux_step_make
	install -Dm600 -t $TERMUX_PREFIX/lib build/release*/libmupdf{-third,}.a
	ln -sf $TERMUX_PREFIX/lib/libmupdf.so.* $TERMUX_PREFIX/lib/libmupdf.so

}
curl -LO "https://github.com/John4650-hub/termux-packages/releases/download/1173.0.0/backport-static_1.0.0-1_arm.deb"
dpkg -x backport-static_1.0.0-1_arm.deb backport
cp -r backport/data/data/com.termux/files/usr/lib $TERMUX_PREFIX
