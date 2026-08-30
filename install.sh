#!/bin/sh
# REVYTECH font collection — platform dispatcher.
# FreeBSD is the default when uname is FreeBSD. Linux is not the primary path.
#
# Usage:
#   sh install.sh                 # detect OS, install
#   sh install.sh uninstall       # detect OS, uninstall
#   sh install.sh --help
#   PREFIX=/usr/local DESTDIR= sh install.sh
#   sh install.sh freebsd|linux|macos|windows [install|uninstall]

set -e

SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ACTION=install
FORCE=

usage() {
	cat <<'EOF'
REVYTECH font collection installer

Usage:
  sh install.sh [platform] [install|uninstall]
  sh install.sh --help

Platforms:
  freebsd   first class (default when uname is FreeBSD)
            PREFIX=/usr/local  DESTDIR=  (passthrough)
            fonts -> ${PREFIX}/share/fonts/revytech
            fontconfig -> ${PREFIX}/etc/fonts/conf.d
  linux     system (/usr/local/share/fonts/revytech) or user (~/.local/share/fonts)
  macos     ~/Library/Fonts (or /Library/Fonts if root)
  windows   %LOCALAPPDATA%\Microsoft\Windows\Fonts  (install/windows.ps1)

Env (FreeBSD / Linux staging):
  PREFIX    default /usr/local
  DESTDIR   staging root; skip live fc-cache and allow non-root install

On FreeBSD, `make install` calls install/freebsd.sh with the same layout.
EOF
}

while [ $# -gt 0 ]; do
	case "$1" in
	-h|--help|help)
		usage
		exit 0
		;;
	install|uninstall)
		ACTION=$1
		shift
		;;
	freebsd|linux|macos|windows|darwin|FreeBSD|Linux|Darwin)
		FORCE=$1
		shift
		;;
	--prefix=*)
		PREFIX=${1#--prefix=}
		export PREFIX
		shift
		;;
	--destdir=*)
		DESTDIR=${1#--destdir=}
		export DESTDIR
		shift
		;;
	PREFIX=*|DESTDIR=*)
		# allow PREFIX=/opt sh install.sh style already via env; ignore here
		shift
		;;
	*)
		echo "unknown argument: $1" >&2
		usage >&2
		exit 2
		;;
	esac
done

# PREFIX/DESTDIR passthrough to child scripts.
export PREFIX DESTDIR

os=${FORCE:-$(uname -s 2>/dev/null || echo unknown)}

case "$os" in
FreeBSD|freebsd)
	exec sh "$SCRIPTDIR/install/freebsd.sh" "$ACTION"
	;;
Linux|linux)
	exec sh "$SCRIPTDIR/install/linux.sh" "$ACTION"
	;;
Darwin|darwin|macos|macOS)
	exec sh "$SCRIPTDIR/install/macos.sh" "$ACTION"
	;;
MINGW*|MSYS*|CYGWIN*|Windows_NT|windows|Windows)
	if command -v powershell.exe >/dev/null 2>&1; then
		exec powershell.exe -ExecutionPolicy Bypass -File "$SCRIPTDIR/install/windows.ps1" -Action "$ACTION"
	fi
	if command -v pwsh >/dev/null 2>&1; then
		exec pwsh -ExecutionPolicy Bypass -File "$SCRIPTDIR/install/windows.ps1" -Action "$ACTION"
	fi
	echo "Windows installer: run install/windows.ps1 in PowerShell" >&2
	echo "  powershell -ExecutionPolicy Bypass -File install/windows.ps1 -Action $ACTION" >&2
	exit 1
	;;
*)
	echo "unrecognized OS '$os'. FreeBSD is first class." >&2
	echo "Pass an explicit platform: sh install.sh freebsd|linux|macos|windows" >&2
	usage >&2
	exit 2
	;;
esac
