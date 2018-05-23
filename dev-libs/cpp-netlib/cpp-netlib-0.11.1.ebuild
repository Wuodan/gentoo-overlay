# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A collection of open-source libraries for high level network programming.."
HOMEPAGE="http://cpp-netlib.github.com/"
SRC_URI="https://github.com/cpp-netlib/cpp-netlib/archive/${P}-final.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-final"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCPP-NETLIB_BUILD_TESTS=OFF
		-DCPP-NETLIB_BUILD_EXAMPLES=OFF
	)
	cmake-utils_src_configure
}
