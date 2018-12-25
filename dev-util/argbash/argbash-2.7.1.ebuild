# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bash argument parsing code generator"
HOMEPAGE="https://github.com/matejak/argbash"
SRC_URI="https://github.com/matejak/argbash/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="	>=app-shells/bash-3.0
			>=sys-devel/autoconf-2.63"

src_install() {
	einstalldocs
	cd resources || die "'cd resources' failed"
	emake PREFIX="${D}"/usr install
}
