#!/bin/sh
# REVYTECH font collection — macOS installer.
# Copies TTF/OTF into Font Book paths. WOFF2 is not required for Font Book.
# fontconfig on Mac is optional (Homebrew fontconfig); native path is Library/Fonts.
#
# User (default): ~/Library/Fonts
# Root:           /Library/Fonts
#
# Usage: sh install/macos.sh [install|uninstall]

set -e

ACTION="${1:-install}"
SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPTDIR/.." && pwd)

uid=$(id -u)
if [ "$uid" -eq 0 ]; then
	FONTDIR="/Library/Fonts"
else
	HOME="${HOME:-/tmp}"
	FONTDIR="${HOME}/Library/Fonts"
fi

# Stamp file so uninstall only removes faces we copied (not other user fonts).
STAMP="${FONTDIR}/.revytech-font-collection.list"

install_one() {
	src=$1
	base=$(basename "$src")
	cp "$src" "$FONTDIR/$base"
	echo "$base" >> "$STAMP"
}

do_install() {
	mkdir -p "$FONTDIR"
	: > "$STAMP"
	echo "Installing REVYTECH TTF/OTF to ${FONTDIR}"
	# Font Book reads a flat directory of TTF/OTF. Skip WOFF2.
	# Use find -print (POSIX) rather than GNU -printf.
	find "$ROOT/fonts" \( -name '*.ttf' -o -name '*.otf' \) -type f | while IFS= read -r f; do
		install_one "$f"
	done
	echo "Installed. Open Font Book to confirm."
	echo "Optional fontconfig (Homebrew): copy fontconfig/65-revytech-fonts.conf"
	echo "  into /usr/local/etc/fonts/conf.d or ~/.config/fontconfig/conf.d"
}

do_uninstall() {
	if [ ! -f "$STAMP" ]; then
		echo "No stamp file ${STAMP}; nothing to uninstall (or fonts were copied by hand)." >&2
		exit 1
	fi
	echo "Removing REVYTECH TTF/OTF from ${FONTDIR}"
	while IFS= read -r base; do
		[ -n "$base" ] || continue
		rm -f "$FONTDIR/$base"
	done < "$STAMP"
	rm -f "$STAMP"
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
	echo "usage: sh install/macos.sh [install|uninstall]"
	echo "user -> ~/Library/Fonts   root -> /Library/Fonts"
	echo "WOFF2 is not copied (Font Book uses TTF/OTF)."
	;;
*)
	echo "usage: sh install/macos.sh [install|uninstall]" >&2
	exit 2
	;;
esac
