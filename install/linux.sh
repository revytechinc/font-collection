#!/bin/sh
# REVYTECH font collection — Linux installer (second platform).
# POSIX sh. Root: system paths. Non-root: user XDG paths.
#
# System (root):
#   /usr/local/share/fonts/revytech
#   /etc/fonts/conf.d/65-revytech-fonts.conf
#   /usr/share/consolefonts   (PSF2 for setfont/kbd)
# User:
#   ~/.local/share/fonts/revytech
#   ~/.config/fontconfig/conf.d/65-revytech-fonts.conf
#   ~/.local/share/consolefonts
#
# Usage: sh install/linux.sh [install|uninstall]

set -e

ACTION="${1:-install}"
CONF="65-revytech-fonts.conf"
SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPTDIR/.." && pwd)

uid=$(id -u)

if [ -n "$DESTDIR" ]; then
	PREFIX="${PREFIX:-/usr/local}"
	FONTDIR="${DESTDIR}${PREFIX}/share/fonts/revytech"
	CONFDDIR="${DESTDIR}/etc/fonts/conf.d"
	PSFDIR="${DESTDIR}/usr/share/consolefonts"
	SYSTEM=1
elif [ "$uid" -eq 0 ]; then
	PREFIX="${PREFIX:-/usr/local}"
	FONTDIR="${PREFIX}/share/fonts/revytech"
	CONFDDIR="/etc/fonts/conf.d"
	PSFDIR="/usr/share/consolefonts"
	SYSTEM=1
else
	HOME="${HOME:-$(getent passwd "$(id -un)" 2>/dev/null | awk -F: '{print $6}')}"
	HOME="${HOME:-/tmp}"
	FONTDIR="${HOME}/.local/share/fonts/revytech"
	CONFDDIR="${HOME}/.config/fontconfig/conf.d"
	PSFDIR="${HOME}/.local/share/consolefonts"
	SYSTEM=0
fi

copy_face() {
	src=$1
	dst=$2
	mkdir -p "$dst"
	(cd "$src" && tar cf - .) | (cd "$dst" && tar xf -)
}

do_install() {
	echo "Installing REVYTECH fonts to ${FONTDIR}"
	copy_face "$ROOT/fonts/tlh/qolqos" "$FONTDIR/tlh/qolqos"
	copy_face "$ROOT/fonts/tlh/hasta" "$FONTDIR/tlh/hasta"
	copy_face "$ROOT/fonts/qya/alcarin" "$FONTDIR/qya/alcarin"
	copy_face "$ROOT/fonts/latn/noto-sans" "$FONTDIR/latn/noto-sans"
	copy_face "$ROOT/fonts/latn/noto-sans-mono" "$FONTDIR/latn/noto-sans-mono"
	mkdir -p "$FONTDIR/console/psf"
	if [ -d "$ROOT/fonts/console/psf" ]; then
		copy_face "$ROOT/fonts/console/psf" "$FONTDIR/console/psf"
		mkdir -p "$PSFDIR"
		for f in "$ROOT/fonts/console/psf/"*.psf; do
			[ -f "$f" ] || continue
			cp "$f" "$PSFDIR/"
		done
	fi

	mkdir -p "$CONFDDIR"
	cp "$ROOT/fontconfig/$CONF" "$CONFDDIR/$CONF"

	if [ -z "$DESTDIR" ] && command -v fc-cache >/dev/null 2>&1; then
		fc-cache -f "$FONTDIR" || echo "warning: fc-cache failed (fonts still copied)" >&2
	else
		echo "Run fc-cache -f after installing to a live system."
	fi

	echo "Installed. fontconfig: ${CONFDDIR}/${CONF}"
	echo "PSF2 (kbd/setfont): ${PSFDIR}"
	echo "  setfont CloudBSD-Latn-8x16.psf"
	echo "  setfont CloudBSD-Piqd-16x16.psf"
}

do_uninstall() {
	echo "Removing REVYTECH fonts from ${FONTDIR}"
	rm -rf "$FONTDIR"
	rm -f "$CONFDDIR/$CONF"
	rm -f "$PSFDIR/CloudBSD-Latn-8x16.psf" "$PSFDIR/CloudBSD-Piqd-16x16.psf"
	if [ -z "$DESTDIR" ] && command -v fc-cache >/dev/null 2>&1; then
		fc-cache -f || true
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
	echo "usage: sh install/linux.sh [install|uninstall]"
	echo "root -> ${PREFIX:-/usr/local}/share/fonts/revytech and /etc/fonts/conf.d"
	echo "user -> ~/.local/share/fonts/revytech and ~/.config/fontconfig/conf.d"
	;;
*)
	echo "usage: sh install/linux.sh [install|uninstall]" >&2
	exit 2
	;;
esac
