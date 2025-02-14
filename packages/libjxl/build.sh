TERMUX_PKG_HOMEPAGE=https://jpegxl.info/
TERMUX_PKG_DESCRIPTION="JPEG XL image format reference implementation"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.7.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/libjxl/libjxl/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=3114bba1fabb36f6f4adc2632717209aa6f84077bc4e93b420e0d63fa0455c5e
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="brotli, libc++"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DJPEGXL_FORCE_SYSTEM_BROTLI=True"

termux_step_post_get_source() {
	./deps.sh
}
