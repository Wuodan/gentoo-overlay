# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Web interface for POM-NG"
HOMEPAGE="http://www.packet-o-matic.org/"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gmsoft-tuxicoman/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/gmsoft-tuxicoman/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="net-analyzer/pom-ng"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/local/share/pom-ng
	doins -s *
}
