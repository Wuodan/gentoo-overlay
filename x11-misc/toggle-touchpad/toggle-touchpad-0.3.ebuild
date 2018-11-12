# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Toggles touchpads on/off. Supports Synaptics and Elantech touchpads"
HOMEPAGE="https://github.com/wuodan/gentoo-overlay"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# todo: find out what happens when both are installed
RDEPEND="${DEPEND} || (
	x11-drivers/xf86-input-synaptics
	x11-apps/xinput	)"

S="${WORKDIR}"

src_prepare() {
	default
	cp ""${FILESDIR}/${PN} .
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
}
