TERMUX_PKG_HOMEPAGE=https://github.com/nohajc/termux-adb
TERMUX_PKG_DESCRIPTION="Run adb and fastboot in Termux without root permissions"
TERMUX_PKG_LICENSE="Apache-2.0, MIT"
TERMUX_PKG_MAINTAINER="nohajc"
TERMUX_PKG_VERSION=0.2.0
TERMUX_PKG_REVISION=5
TERMUX_PKG_GIT_BRANCH="master"
TERMUX_PKG_SRCURL=https://github.com/nohajc/vendor-adb-patched/archive/refs/heads/master.zip
#TERMUX_PKG_SRCURL=file:///home/builder/termux-packages/termux-dev/android-tools.git
TERMUX_PKG_SHA256=SKIP_CHECKSUM
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="brotli, libc++, liblz4, libprotobuf, libusb, termux-api, zlib, zstd"
TERMUX_PKG_BUILD_DEPENDS="googletest, pcre2"

termux_step_pre_configure() {
	termux_setup_protobuf
	termux_setup_golang
	termux_setup_rust
}

termux_step_make() {
	(cd ../src/libtermuxadb && \
		cargo build --jobs "$TERMUX_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" --release && \
		cp target/*/release/libtermuxadb.a ../vendor/)

	local QUIET_BUILD=
	if [ "$TERMUX_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	if test -f build.ninja; then
		ninja -w dupbuild=warn -j $TERMUX_MAKE_PROCESSES
	elif ls ./*.cabal &>/dev/null; then
		termux-ghc-setup -j$TERMUX_MAKE_PROCESSES build
	elif ls ./*akefile &>/dev/null || [ ! -z "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
		if [ -z "$TERMUX_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j $TERMUX_MAKE_PROCESSES $QUIET_BUILD
		else
			make -j $TERMUX_MAKE_PROCESSES $QUIET_BUILD ${TERMUX_PKG_EXTRA_MAKE_ARGS}
		fi
	fi
}
