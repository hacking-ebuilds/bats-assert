# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A helper library providing common assertions for bats / bats-core"
HOMEPAGE="https://github.com/jasonkarns/bats-assert-1"
LICENSE="CC0-1.0"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jasonkarns/bats-assert-1.git"
	EGIT_COMMIT="v2.0.0"
else
	SRC_URI="https://github.com/jasonkarns/${PN}-1/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-1-${PV}"
fi

KEYWORDS=""
IUSE="test"
SLOT="0"

RESTRICT="!test? ( test )"

RDEPEND="dev-util/bats-support"
DEPEND="test? ( ${RDEPEND} )"

src_test() {
	TEST_DEPS_DIR="/usr/lib" /usr/bin/bats --tap test || die "Tests failed"
}

src_install() {
	einstalldocs

	insinto /usr/lib/"${PN}"
	doins load.bash

	insinto /usr/lib/"${PN}"/src
	doins src/*
}
