#!/bin/sh
# REVYTECH font collection — FreeBSD / CloudBSD installer (first class).
# BSD sh only. No bashisms.
#
# Layout:
#   ${DESTDIR}${PREFIX}/share/fonts/revytech   TTF/OTF/WOFF2 + OFL
#   ${DESTDIR}${PREFIX}/etc/fonts/conf.avail   65-revytech-fonts.conf
#   ${DESTDIR}${PREFIX}/etc/fonts/conf.d       symlink
#   ${DESTDIR}${PREFIX}/share/vt/fonts         PSF2 (optional; vt(4) needs vtfontcvt)
#
# Usage:
#   sh install/freebsd.sh [install|uninstall]
#   PREFIX=/usr/local DESTDIR= sh install/freebsd.sh
# Root is required unless DESTDIR is set (staging / packaging).

set -e

PREFIX="${PREFIX:-/usr/local}"
DESTDIR="${DESTDIR:-}"
ACTION="${1:-install}"

CONF="65-revytech-fonts.conf"
SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPTDIR/.." && pwd)

FONTDIR="${DESTDIR}${PREFIX}/share/fonts/revytech"
CONFDIR="${DESTDIR}${PREFIX}/etc/fonts/conf.avail"
CONFDDIR="${DESTDIR}${PREFIX}/etc/fonts/conf.d"
VTDIR="${DESTDIR}${PREFIX}/share/vt/fonts"

need_root_or_destdir() {
	if [ -n "$DESTDIR" ]; then
		return 0
	fi
	uid=$(id -u)
	if [ "$uid" -ne 0 ]; then
		echo "install/freebsd.sh: run as root, or set DESTDIR= for a staging tree." >&2
		echo "  Example: DESTDIR=/tmp/stage PREFIX=/usr/local sh install/freebsd.sh" >&2
		exit 1
	fi
}

copy_face() {
	src=$1
	dst=$2
	mkdir -p "$dst"
	# POSIX: copy directory contents with tar (no GNU cp flags).
	(cd "$src" && tar cf - .) | (cd "$dst" && tar xf -)
}

do_install() {
	need_root_or_destdir
	echo "Installing REVYTECH fonts to ${FONTDIR}"

	copy_face "$ROOT/fonts/tlh/qolqos" "$FONTDIR/tlh/qolqos"
	copy_face "$ROOT/fonts/tlh/hasta" "$FONTDIR/tlh/hasta"
	copy_face "$ROOT/fonts/qya/alcarin" "$FONTDIR/qya/alcarin"
	copy_face "$ROOT/fonts/latn/noto-sans" "$FONTDIR/latn/noto-sans"
	copy_face "$ROOT/fonts/latn/noto-sans-mono" "$FONTDIR/latn/noto-sans-mono"

	mkdir -p "$FONTDIR/console/psf"
	# Optional console bitmaps (PSF2). FreeBSD vt(4) does not load these
	# directly; keep them next to the TTF pack and also under share/vt/fonts
	# for later vtfontcvt(1). See README.
	if [ -d "$ROOT/fonts/console/psf" ]; then
		copy_face "$ROOT/fonts/console/psf" "$FONTDIR/console/psf"
		mkdir -p "$VTDIR"
		for f in "$ROOT/fonts/console/psf/"*.psf; do
			[ -f "$f" ] || continue
			cp "$f" "$VTDIR/"
		done
	fi

	mkdir -p "$CONFDIR" "$CONFDDIR"
	cp "$ROOT/fontconfig/$CONF" "$CONFDIR/$CONF"
	rm -f "$CONFDDIR/$CONF"
	# Relative symlink so DESTDIR staging still makes sense after relocate.
	ln -s "../conf.avail/$CONF" "$CONFDDIR/$CONF"

	if [ -z "$DESTDIR" ] && command -v fc-cache >/dev/null 2>&1; then
		fc-cache -fs "$FONTDIR" || fc-cache -f "$FONTDIR" || \
			echo "warning: fc-cache failed (fonts still copied)" >&2
	else
		echo "Run fc-cache -fs after installing to a live system."
	fi

	echo "Installed TTF/OTF/WOFF2 under ${FONTDIR}"
	echo "fontconfig: ${CONFDDIR}/${CONF}"
	echo "PSF2 copies (optional, not loaded by stock vt(4)): ${VTDIR}"
	echo "Convert later with vtfontcvt(1); load with vidcontrol(1). See README."
}

do_uninstall() {
	need_root_or_destdir
	echo "Removing REVYTECH fonts from ${FONTDIR}"
	rm -rf "$FONTDIR"
	rm -f "$CONFDDIR/$CONF" "$CONFDIR/$CONF"
	# Only remove PSF files we installed, not the whole vt font dir.
	rm -f "$VTDIR/CloudBSD-Latn-8x16.psf" "$VTDIR/CloudBSD-Piqd-16x16.psf"
	if [ -z "$DESTDIR" ] && command -v fc-cache >/dev/null 2>&1; then
		fc-cache -fs || fc-cache -f || true
	fi
	echo "Uninstalled."
}

case "$ACTION" in
install)
	do_install
	;;
uninstall)
	do_uninstall
	;;
-h|--help|help)
	echo "usage: sh install/freebsd.sh [install|uninstall]"
	echo "env: PREFIX=${PREFIX} DESTDIR=${DESTDIR}"
	echo "FreeBSD is the first-class platform. See also: linux.sh macos.sh windows.ps1"
	;;
*)
	echo "usage: sh install/freebsd.sh [install|uninstall]" >&2
	exit 2
	;;
esac
