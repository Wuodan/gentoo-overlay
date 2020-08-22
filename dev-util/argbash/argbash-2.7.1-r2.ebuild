# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bash argument parsing code generator"
HOMEPAGE="https://github.com/matejak/argbash"
SRC_URI="https://github.com/matejak/argbash/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Argbash"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=app-shells/bash-3.0
		>=sys-devel/autoconf-2.63"

S="${WORKDIR}/${P}/resources"

src_prepare() {
	default
	sed -Ei 's#m4dir=/\$\(PREFIXED_LIBDIR\)#m4dir=/\$(EROOT)usr/lib#' Makefile || die 'sed failed'
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install failed"
	cd .. || die "'cd ..' failed"
	einstalldocs
}
