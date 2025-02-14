TERMUX_PKG_HOMEPAGE=https://gegl.org/babl/
TERMUX_PKG_DESCRIPTION="Dynamic pixel format translation library"
TERMUX_PKG_LICENSE="LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=0.1
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.98
TERMUX_PKG_SRCURL=https://download.gimp.org/pub/babl/${_MAJOR_VERSION}/babl-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=f3b222f84e462735de63fa9c3651942f2b78fd314c73a22e05ff7c73afd23af1
TERMUX_PKG_DEPENDS="littlecms"
TERMUX_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
TERMUX_PKG_BREAKS="babl-dev"
TERMUX_PKG_REPLACES="babl-dev"
TERMUX_PKG_DISABLE_GIR=false
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-gir=true
"

termux_step_pre_configure() {
	termux_setup_gir
}
