# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic xdg

DESCRIPTION="Periodic table viewer with detailed information on the chemical elements"
HOMEPAGE="https://github.com/ginggs/gelemental/"
SRC_URI="https://github.com/ginggs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-cpp/glibmm:2"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

PATCHES=(
	)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cxxflags -std=c++11 #566450

	econf \
		--disable-static \
		$(use_enable doc api-docs)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
