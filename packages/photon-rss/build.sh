TERMUX_PKG_HOMEPAGE=https://git.sr.ht/~ghost08/photon
TERMUX_PKG_DESCRIPTION="An RSS/Atom reader with the focus on speed, usability and a bit of unix philosophy"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=53f440659b3871d233eddc700ad8f10e2b67b6f2
TERMUX_PKG_VERSION=2022.11.17
# This repository does not accept ".git" suffix:
TERMUX_PKG_SRCURL=https://git.sr.ht/~ghost08/photon
TERMUX_PKG_SHA256=SKIP_CHECKSUM
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"

termux_step_get_source() {
	termux_git_clone_src
}

termux_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$TERMUX_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$TERMUX_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

termux_step_pre_configure() {
	termux_setup_golang

	go mod init || :
	go mod tidy
}
