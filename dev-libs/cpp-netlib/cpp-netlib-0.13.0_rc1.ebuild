# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION="A collection of open-source libraries for high level network programming.."
HOMEPAGE="http://cpp-netlib.github.com/"
SRC_URI="http://downloads.cpp-netlib.org/$(get_version_component_range -3)/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCPP-NETLIB_BUILD_TESTS=OFF
		-DCPP-NETLIB_BUILD_EXAMPLES=OFF
	)
	cmake-utils_src_configure
}
