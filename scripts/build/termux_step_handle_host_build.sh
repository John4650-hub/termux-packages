termux_step_handle_host_build() {
	[ "$TERMUX_PKG_METAPACKAGE" = "true" ] && return
	[ "$TERMUX_PKG_HOSTBUILD" = "false" ] && return

	cd "$TERMUX_PKG_SRCDIR"
	local HOST_BUILD_PATCHES=$(find $TERMUX_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.beforehostbuild | sort)
	for patch in $HOST_BUILD_PATCHES; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" "$patch" | patch --silent -p1
	done

	if [ ! -f "$TERMUX_HOSTBUILD_MARKER" ]; then
		rm -Rf "$TERMUX_PKG_HOSTBUILD_DIR"
		mkdir -p "$TERMUX_PKG_HOSTBUILD_DIR"
		cd "$TERMUX_PKG_HOSTBUILD_DIR"
		termux_step_host_build
		touch "$TERMUX_HOSTBUILD_MARKER"
	fi
}
