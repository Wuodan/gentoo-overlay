# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="https://github.com/pentoo/pentoo-installer"
EGIT_REPO_URI="https://github.com/wuodan/${PN}.git"
EGIT_BRANCH="config-file"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

PDEPEND="dev-util/dialog
	sys-apps/util-linux
	sys-block/parted
	sys-boot/efibootmgr
	sys-boot/grub:2[multislot(-),grub_platforms_efi-32,grub_platforms_efi-64]
	sys-boot/os-prober
	sys-boot/shim
	sys-boot/mokutil
	app-crypt/pinentry[gtk,ncurses]
	sys-fs/squashfs-tools
	x11-misc/wmctrl
	net-misc/rsync
	app-misc/jq
	sys-fs/growpart"
#	X? ( x11-misc/xdialog )

DOCS="config-samples"

src_install() {
	dodir /usr/ /usr/share/
	cp -R "${S}"/sbin "${ED}"/usr/ || die "Copy files failed"
	cp -R "${S}"/share/pentoo-installer "${ED}"/usr/share/ || die "Copy files failed"
	exeinto /root/Desktop/
	doexe share/applications/pentoo-installer.desktop
	exeinto /etc/skel/Desktop/
	newexe share/applications/sudo-pentoo-installer.desktop pentoo-installer.desktop
	use doc && einstalldocs
}
