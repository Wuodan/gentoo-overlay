# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit bash-completion-r1 eutils git-r3 systemd user

DESCRIPTION="A C++ daemon for monero and the i2p network"
HOMEPAGE="https://getkovri.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/monero-project/kovri.git"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS=""
IUSE="vanilla static"

# upstream uses dev-libs/crypto++-7.0
# upstream uses dev-libs/cpp-netlib-0.13.x (release branch or rc1.tar.gz)
RDEPEND="
	dev-libs/boost
	dev-libs/openssl
	!vanilla? (
		>=dev-libs/cpp-netlib-0.13.0_rc1
		>=dev-libs/crypto++-7
	)"
DEPEND="${DEPEND}
	dev-libs/cmake"

KOVRI_USER=kovri
KOVRI_GROUP=kovri

DOCS=(
	"${HOME}"/.kovri/config/kovri.conf
	"${HOME}"/.kovri/config/tunnels.conf )
PATCHES=(
	"${FILESDIR}"/kovri-install_move_catch.patch
	"${FILESDIR}"/kovri-install_utils_optional.patch )

pkg_setup(){
	enewgroup "${KOVRI_GROUP}"
	enewuser "${KOVRI_USER}" -1 -1 /var/lib/run/kovri "${KOVRI_GROUP}"

	if ! use vanilla ; then
		PATCHES=(
			${PATCHES[@]}
			"${FILESDIR}/release_without_static_cryptopp.patch"
		)
	fi
}

src_compile(){
	if use static; then
		emake release-static || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	default

	# lib
	dolib.so build/libclient-connections.so.0

	# bin
	dobin "${HOME}/bin/${PN}"
	# dobin "${HOME}/bin/${PN}-util"
	newbashcomp "${HOME}/bin/${PN}-bash.sh" ${PN}
	
	# config
	insinto /etc/kovri
	doins "${HOME}"/.kovri/config/kovri.conf
	doins "${HOME}"/.kovri/config/tunnels.conf

	# grant kovri group read and write access to config files
	fowners "root:${KOVRI_GROUP}" \
		/etc/kovri/kovri.conf \
		/etc/kovri/tunnels.conf
	fperms 660 \
		/etc/kovri/kovri.conf \
		/etc/kovri/tunnels.conf

	# working directory
	keepdir /var/lib/kovri
	insinto /var/lib/kovri
	doins -r "${HOME}"/.kovri/client/*
	fowners "${KOVRI_USER}:${KOVRI_GROUP}" /var/lib/kovri/
	fperms 700 /var/lib/kovri/

	# add /var/lib/kovri/certificates to CONFIG_PROTECT
	doenvd "${FILESDIR}/99kovri"

	# openrc and systemd daemon routines
	newconfd "${FILESDIR}/kovri.confd" kovri
	newinitd "${FILESDIR}/kovri.initd" kovri
	systemd_newunit "${FILESDIR}/kovri.service" kovri.service

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}/kovri.logrotate" kovri

	einstalldocs
}
