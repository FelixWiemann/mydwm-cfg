# Maintainer: Thule <vincenzo.frascino@proton.me>
# Contributor: Neptune <neptune650@proton.me>
# Contributor: Sergej Pupykin <pupykin.s+arch@gmail.com>
# Contributor: Dag Odenhall <dag.odenhall@gmail.com>
# Contributor: Grigorios Bouzakis <grbzks@gmail.com>

pkgname=dwm
pkgver=6.5
pkgrel=1
pkgdesc="A dynamic window manager for X"
url="https://dwm.suckless.org"
arch=('i686' 'x86_64' 'arm' 'armv7h' 'armv6h' 'aarch64')
license=('MIT')
options=(zipman)
depends=('libx11' 'libxinerama' 'libxft' 'freetype2')
source=(config.h)
sha256sums=('SKIP')

prepare() {
  cd "$srcdir/../$pkgname"
  # reset accidental changes
  git reset --hard
  git clean -f
  # get copy
  if [[ -f "$srcdir/../config.h" ]]; then
    cp -fv "$srcdir/../config.h" config.h
  fi
}

build() {
  cd "$srcdir/../$pkgname"
  make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11 FREETYPEINC=/usr/include/freetype2
}

package() {
  cd "$srcdir/../$pkgname"
  make PREFIX=/usr DESTDIR="$pkgdir" install
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -Dm644 README "$pkgdir/usr/share/doc/$pkgname/README"
}
