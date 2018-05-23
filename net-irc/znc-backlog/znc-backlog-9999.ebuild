# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 multilib

DESCRIPTION="The unofficial backlog module for the ZNC IRC-bouncer"
HOMEPAGE="https://github.com/FruitieX/znc-backlog"
SRC_URI=""
EGIT_REPO_URI="https://github.com/FruitieX/znc-backlog.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="net-irc/znc"
RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/$(get_libdir)/znc
	cp -R "${S}/backlog.so" "${D}/usr/$(get_libdir)/znc/backlog.so" || die "Install failed!"
}
