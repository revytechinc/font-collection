# REVYTECH font collection
# Compatible with BSD make (bmake) and GNU make.
# FreeBSD is first class: `make install` uses the same layout as install/freebsd.sh.

PREFIX ?= /usr/local
DESTDIR ?=

.PHONY: all install uninstall woff2 psf

all:
	@echo "Fonts are pre-vendored. Targets: install, uninstall, woff2, psf"
	@echo "FreeBSD: make install PREFIX=/usr/local   or: sh install.sh"

install:
	PREFIX="$(PREFIX)" DESTDIR="$(DESTDIR)" sh install/freebsd.sh install

uninstall:
	PREFIX="$(PREFIX)" DESTDIR="$(DESTDIR)" sh install/freebsd.sh uninstall

# Rebuild WOFF2 from TTF (requires woff2_compress). Alcarin WOFF2 is upstream.
woff2:
	woff2_compress fonts/tlh/qolqos/ttf/pIqaD-qolqoS.ttf
	mv -f fonts/tlh/qolqos/ttf/pIqaD-qolqoS.woff2 fonts/tlh/qolqos/woff2/pIqaD-qolqoS.woff2
	woff2_compress fonts/tlh/hasta/ttf/Klingon-pIqaD-HaSta.ttf
	mv -f fonts/tlh/hasta/ttf/Klingon-pIqaD-HaSta.woff2 fonts/tlh/hasta/woff2/Klingon-pIqaD-HaSta.woff2
	woff2_compress fonts/latn/noto-sans/ttf/NotoSans-Regular.ttf
	mv -f fonts/latn/noto-sans/ttf/NotoSans-Regular.woff2 fonts/latn/noto-sans/woff2/NotoSans-Regular.woff2
	woff2_compress fonts/latn/noto-sans/ttf/NotoSans-Bold.ttf
	mv -f fonts/latn/noto-sans/ttf/NotoSans-Bold.woff2 fonts/latn/noto-sans/woff2/NotoSans-Bold.woff2
	woff2_compress fonts/latn/noto-sans-mono/ttf/NotoSansMono-Regular.ttf
	mv -f fonts/latn/noto-sans-mono/ttf/NotoSansMono-Regular.woff2 fonts/latn/noto-sans-mono/woff2/NotoSansMono-Regular.woff2
	woff2_compress fonts/latn/noto-sans-mono/ttf/NotoSansMono-Bold.ttf
	mv -f fonts/latn/noto-sans-mono/ttf/NotoSansMono-Bold.woff2 fonts/latn/noto-sans-mono/woff2/NotoSansMono-Bold.woff2

psf:
	python3 scripts/gen-psf.py
