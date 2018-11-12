# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit prefix

DESCRIPTION="Simple vim config"
HOMEPAGE="https://github.com/wuodan/gentoo-overlay"

LICENSE="GPL-3"
SLOT="0"
# copied from app-editors/vim-core-8.0.1298.ebuild
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~m68k ~mips ppc ppc64 s390 ~sh sparc x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="app-editors/vim-core"

S="${WORKDIR}"

src_install() {
	insinto /etc/vim/
	doins "${FILESDIR}"/vimrc.local
	eprefixify "${ED}"/etc/vim/vimrc.local
}
