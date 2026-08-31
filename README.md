# REVYTECH font collection

English first. Generic, redistributable font collection packaged by
**REVYTECH, Inc.** for FreeBSD / CloudBSD first, then Linux, macOS, and
Windows. English UI, Latin-script constructed languages, Klingon pIqaD
(CSUR), and Quenya tengwar (CSUR-based PUA) render without pulling
non-redistributable fonts.

Packaging: Copyright REVYTECH, Inc., BSD 3-Clause (`LICENSE`).
Fonts: keep their original SIL OFL 1.1 (`OFL.txt` next to each face).

Full license evidence: `docs/LICENSE-INVENTORY.md`.
Language/script matrix: `docs/LANGUAGES.md`.
Upstream URLs and trademark notes: `NOTICE`, `THIRD_PARTY.md`.

Install: `sh install.sh` (detects OS) or `make install` on FreeBSD.

A FreeBSD package may appear later in a REVYTECH pkg repository; until then
use `make install` / `sh install.sh`. This tree is not a full ports collection.

## Live specimen

The public web specimen is **https://fun.cloudbsd.cat** only.
Pages in `www/` (`index.html` hub, language specimens, `css/specimen.css`,
self-hosted `www/fonts/*.woff2`). Origin nginx: `www/nginx.example.conf`.

## What is included

| Slot | Face | Files | Unicode |
|---|---|---|---|
| Default pIqaD | **pIqaD qolqoS** (dadap) | TTF + WOFF2 | CSUR **U+F8D0–U+F8FF** |
| Display pIqaD (extra) | **Klingon pIqaD HaSta** (Evertype) | TTF + WOFF2 | CSUR **U+F8D0–U+F8FF** |
| Tengwar | **Alcarin Tengwar** Regular + Bold | OTF + WOFF + WOFF2 | CSUR-based **U+E000–U+E07F** |
| Latin UI | **Noto Sans** Regular + Bold | TTF + WOFF2 | Latin, Ext-A, ȳ, U+02BC |
| Terminal | **Noto Sans Mono** Regular + Bold | TTF + WOFF2 | same |
| Console PSF2 | CloudBSD-Latn-8x16, CloudBSD-Piqd-16x16 | PSF2 | see § Console |

**Not shipped:** Zun, Iyik, Tengwar Annatar, Disney Atlantean dingbats, WTFPL
pIqaDqoq as primary, Mandel/vaHbo’.

Every custom face is actually used: fontconfig selects Noto / qolqoS / Alcarin;
the web specimen `@font-face`s every family (including HaSta and bold cuts);
installers copy TTF/OTF (and WOFF2 on FreeBSD/Linux); PSF2 is generated from
Noto Sans Mono + qolqoS.

### Vulcan / Golic

There is **no native Unicode Golic font** we can redistribute. Do not download
Zun or Iyik into this tree. Latin transcription uses Noto. For personal native
Golic typesetting, request **Zun** by email from **skladan at korsaya.org**.
This collection does **not** redistribute Zun.

### Dig Adlantisag

Latin Standard Transcription only (ASCII + digraph `sh`). No Disney fonts.

## Languages (English first)

English (en), Dig Adlantisag, Dothraki, Esperanto (eo), Lìʼfya leNaʼvi,
Quenya (qya), Valyrian, Valyrio, tlhIngan Hol (tlh), Vulcan / Golic.

Constructed/fictional languages are kept on purpose. See `docs/LANGUAGES.md`.

### Latin coverage required of Noto

| Language | Points |
|---|---|
| English | ASCII |
| Esperanto | Ĉĉ Ĝĝ Ĥĥ Ĵĵ Ŝŝ Ŭŭ (U+0108–0109, 011C–011D, 0124–0125, 0134–0135, 015C–015D, 016C–016D) |
| Dothraki | ASCII (optional pedagogical acutes in Latin-1) |
| Lìʼfya leNaʼvi | ìÌ äÄ ùÙ and **ʼ U+02BC** |
| Valyrian / Valyrio | Āā Ēē Īī Ōō Ūū and **Ȳȳ U+0232/U+0233** |
| Dig Adlantisag, Vulcan Latin, Dothraki | ASCII (+ `sh`) |

## 1. FreeBSD — first class

These faces are for X11, Wayland, and GUI apps via fontconfig. Console `vt(4)`
is a separate path (see § Console).

```sh
# from this directory (FreeBSD)
sh install.sh
# or
make install PREFIX=/usr/local DESTDIR=
fc-cache -fs
fc-list | grep -e 'Noto Sans' -e 'pIqaD' -e 'Alcarin'
```

`make install` and `install/freebsd.sh` copy TTF/OTF/WOFF2 under
`${PREFIX}/share/fonts/revytech` and install
`fontconfig/65-revytech-fonts.conf` into `${PREFIX}/etc/fonts/conf.d`
(via `conf.avail` + symlink). PSF2 is also copied to
`${PREFIX}/share/vt/fonts` for later `vtfontcvt(1)` — stock `vt(4)` does
not load Linux PSF2 directly.

Uninstall:

```sh
make uninstall
# or
sh install.sh uninstall
```

The conf:

* prefers **Noto Sans** / **Noto Sans Mono** for `sans-serif` / `monospace`
* prepends **pIqaD qolqoS** when `lang=tlh` or the charset contains **U+F8D0**
* prepends **Alcarin Tengwar** when `lang=qya` or the charset contains **U+E000**
* HaSta is installed but is a display extra (does not steal the tlh default)

Verify:

```sh
fc-match sans
fc-match :lang=tlh
fc-match ':charset=f8d0'
fc-match ':charset=e000'
```

Staging without touching the live system (ports / packaging):

```sh
make install DESTDIR=/tmp/stage PREFIX=/usr/local
```

## 2. Linux

```sh
sh install.sh          # root: /usr/local/share/fonts/revytech + /etc/fonts/conf.d
                       # user: ~/.local/share/fonts/revytech + ~/.config/fontconfig/conf.d
sh install.sh uninstall
```

GUI terminals (kitty, gnome-terminal, konsole, xterm with fontconfig) pick up
Noto Sans Mono after `fc-cache`. They will **not** shape tengwar tehtar
reliably; they **will** show pIqaD PUA if the font is selected or is a fallback.

Linux kernel console (`setfont`, kbd):

```sh
# Latin constructed languages + English
setfont CloudBSD-Latn-8x16.psf

# pIqaD CSUR (also includes Latin-1 from Noto for usability)
setfont CloudBSD-Piqd-16x16.psf
```

The application must emit **UTF-8** code points (U+F8D0+ for pIqaD, not a
Latin “dingbat Klingon” overlay).

## 3. macOS

```sh
sh install.sh            # copies TTF/OTF to ~/Library/Fonts
sudo sh install.sh       # /Library/Fonts
sh install.sh uninstall
```

WOFF2 is not copied — Font Book uses TTF/OTF. fontconfig on Mac is optional
(Homebrew); the native path is Library/Fonts.

## 4. Windows

```powershell
powershell -ExecutionPolicy Bypass -File install\windows.ps1
powershell -ExecutionPolicy Bypass -File install\windows.ps1 -Action uninstall
```

Copies TTF/OTF to `%LOCALAPPDATA%\Microsoft\Windows\Fonts` and registers
them in HKCU. Administrators can instead copy the same files to
`C:\Windows\Fonts`. scoop/choco are not required.

## 5. Web `@font-face` and `unicode-range`

Live specimen: **https://fun.cloudbsd.cat**. Pages live under `www/` (English
first). Every family is declared with `unicode-range` in `www/css/specimen.css`
and shown on its own page. The specimen is self-contained: WOFF2 copies sit in
`www/fonts/` (same files as `fonts/.../woff2/`). Example jail snippet:
`www/nginx.example.conf` (`server_name fun.cloudbsd.cat` only; origin :80
serves files; public HTTPS is Cloudflare orange-cloud Universal SSL).

Minimal stacked example (collection-tree paths; the specimen uses `../fonts/`
from `www/css/`):

```css
@font-face {
  font-family: "REVYTECH Collection";
  src: url("../fonts/latn/noto-sans/woff2/NotoSans-Regular.woff2") format("woff2");
  unicode-range: U+0000-024F, U+02BC;
  font-weight: 400;
}
@font-face {
  font-family: "REVYTECH Collection";
  src: url("../fonts/tlh/qolqos/woff2/pIqaD-qolqoS.woff2") format("woff2");
  unicode-range: U+F8D0-F8FF;
}
@font-face {
  font-family: "REVYTECH Collection";
  src: url("../fonts/qya/alcarin/woff2/AlcarinTengwar-Regular.woff2") format("woff2");
  unicode-range: U+E000-E07F;
}
```

Alcarin still needs a browser shaper for tehtar (GPOS). pIqaD is non-joining.
HaSta is a second pIqaD family on the same CSUR range (display extra).

## Console limitations and FreeBSD vt(4)

PSF2 is a dumb bitmap: no OpenType, no combining marks, no joining.

| Script | Console? |
|---|---|
| English, Esperanto, Dothraki, Naʼvi, Valyrian, Atlantean Latin, Vulcan Latin | Yes — `CloudBSD-Latn-8x16.psf` |
| pIqaD | Awkward but possible — `CloudBSD-Piqd-16x16.psf` (512 glyphs) |
| Tengwar | **No** — tehtar are combining marks that need GPOS |
| Golic native | **No** — joining / no Unicode |
| Atlantean native | **No** — not redistributable |

**FreeBSD `vt(4)`** does not load Linux PSF2 directly. Convert with `vtfontcvt(1)`
if you have BDF/HEX, or use a GUI/login class with fontconfig TTF. Stock vt
fonts do not cover CSUR PUA. Practical path:

1. Use TTF + fontconfig for Xorg/Wayland (this collection).
2. Keep the syscons/vt font as a Latin bitmap for the kernel console.
3. Optional: `vtfontcvt` a custom `.fnt` from these PSF/TTF sources later;
   do not expect tengwar or Golic there. `vidcontrol(1)` loads a converted
   `.fnt`, not the raw PSF2.

PSF files are OFL **Modified Versions** rasterized from Noto Sans Mono and
pIqaD qolqoS. Names **CloudBSD-Latn** / **CloudBSD-Piqd** avoid Reserved Font
Names. Rebuild: `make psf` (python3 + fontTools + Pillow).

## License table

| Component | License | Copyright |
|---|---|---|
| This collection (layout, Makefile, installers, conf, docs, specimen, PSF scripts) | BSD 3-Clause | REVYTECH, Inc. |
| pIqaD qolqoS | SIL OFL 1.1 | Daniel Dadap; RFN `pIqaD qolqoS` |
| Klingon pIqaD HaSta | SIL OFL 1.1 | Mike Neff, Michael Everson |
| Alcarin Tengwar | SIL OFL 1.1 | Toshi Omagari; RFN `Alcarin` |
| Noto Sans / Mono | SIL OFL 1.1 | The Noto Project Authors |
| Console PSF2 | SIL OFL 1.1 (Modified Version) | derived; no RFN used |

U+F8FF in qolqoS: mention https://hol.kag.org (see NOTICE).
Font license ≠ CBS / Disney / Tolkien / Paramount trademark license.

## Layout

```
install.sh                     dispatcher (FreeBSD first)
install/freebsd.sh             first-class installer + uninstall
install/linux.sh
install/macos.sh
install/windows.ps1
fonts/tlh/qolqos/{ttf,woff2}/ + OFL.txt
fonts/tlh/hasta/{ttf,woff2}/   HaSta display extra
fonts/qya/alcarin/{otf,woff,woff2}/ + OFL.txt
fonts/latn/noto-sans/{ttf,woff2}/ + OFL.txt
fonts/latn/noto-sans-mono/{ttf,woff2}/ + OFL.txt
fonts/console/psf/
fontconfig/65-revytech-fonts.conf
www/index.html                 specimen hub (open this locally)
www/*.html                     language pages + faces.html
www/css/specimen.css
www/fonts/*.woff2              self-contained copies (same as fonts/.../woff2)
www/nginx.example.conf         fun.cloudbsd.cat origin :80
www/demo.html                 redirect to index.html
samples/*.txt
docs/LICENSE-INVENTORY.md
docs/LANGUAGES.md
scripts/gen-psf.py
```

## Rebuild notes

WOFF2 (qolqoS, HaSta, Noto) was produced with `woff2_compress` from the TTF.
Alcarin WOFF/WOFF2 are the upstream files (not reconverted). PSF: `make psf`.
