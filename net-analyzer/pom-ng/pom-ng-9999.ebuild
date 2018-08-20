# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="packet-o-matic is a real time packet processor"
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
IUSE="+libexif +libmagic +libjpeg zlib postgres"

DEPEND=">=dev-db/sqlite-3
		=dev-lang/lua-5.1*:*
		dev-libs/libxml2
		dev-libs/uthash
		dev-libs/xmlrpc-c
		net-libs/libmicrohttpd
		net-libs/libpcap
		libexif? ( media-libs/libexif )
		libmagic? ( sys-apps/file )
		libjpeg? ( media-libs/libjpeg-turbo )
		zlib? ( sys-libs/zlib )
		postgres? ( dev-db/postgresql:* )"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	keepdir "${EPREFIX}usr/share/${PN}/addons"
	keepdir "${EPREFIX}usr/local/share/${PN}"
}
