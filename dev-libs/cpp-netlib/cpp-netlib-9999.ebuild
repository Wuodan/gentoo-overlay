# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="A collection of open-source libraries for high level network programming.."
HOMEPAGE="http://cpp-netlib.github.com"

EGIT_REPO_URI="https://github.com/cpp-netlib/${PN}.git"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	epatch "${FILESDIR}/${P}-Uri.patch"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCPP-NETLIB_BUILD_TESTS=OFF
		-DCPP-NETLIB_BUILD_EXAMPLES=OFF
		-DUri_BUILD_TESTS=OFF
		-DUri_DISABLE_LIBCXX=ON
	)
	cmake-utils_src_configure
}
