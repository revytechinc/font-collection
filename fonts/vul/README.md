# Vulcan / Golic — informal web extras (not OFL)

These faces are **not** SIL Open Font License. They are informal public
grants from **Vulcan Quest** (author Zavel). They exist so the
fun.cloudbsd.cat specimen can show Golic *overlay* glyphs.

**Do not** add them to the FreeBSD / CloudBSD OS default install, the pkg
image, fontconfig, or `make install`. `install/freebsd.sh` does not copy
`fonts/vul/`. Primary OS faces remain OFL: Noto, pIqaD qolqoS, HaSta,
Alcarin.

## What is here

| Face | Role | Encoding |
|---|---|---|
| **Iyik Vulkansu** | Modern Golic display on vulcan.html | Latin-1 overlay dingbat |
| Kitaun | Handwriting extra | same overlay; vertical in native use |
| **El’ru** | Horizontal handwriting extra | same overlay; author said it did not work out well |
| Tanaf | Ceremonial extra | more glyphs; **not** Zun-compatible |
| Golsu | Teaching extra (2025 update) | overlay; full ASCII in this cut |
| **Wonil-Golsu** | Thinner Golsu companion (2025) | overlay; full ASCII in this cut |
| Dzhaleyl | Ancient-script extra | overlay; plant theme |

There is **no Unicode / CSUR Golic block**. Typing Latin keys (plus ä /
U+00E4 for “au”) produces Golic-looking glyphs. This is a dingbat mapping,
not a script encoding.

## What is not here

**Zun** (korsaya.org / Britton Watkins) is **not redistributable**. Email
skladan at korsaya.org. Do not download, vendor, or ship the Zun file.
Iyik was created as a fallback *because* Zun cannot be given away.

## License quotes (keep these next to the TTFs)

Iyik / Kitaun / El’ru / Tanaf (https://vulcanquest.wordpress.com/2019/12/22/fonts/):

> Iyik however is free to distribute.
> All of these fonts are free to distribute to anyone who wants them.

Golsu zip readme (2022) and 2025-11-17 post:

> Both fonts are free to distribute, copy, share, modify or re-post.
> Though copyrighted, all fonts may be copied, distributed, and modified.
> If you have a web page, feel free to distribute the fonts from there.

Grant ≠ trademark. Not a Paramount / CBS product. Host:
**fun.cloudbsd.cat only**.

WOFF2 files are `woff2_compress` conversions of the Original Versions.
CSS family names (Iyik Vulkansu, Kitaun, El’ru, Tanaf Kitaun, Golsu, Wonil-Golsu, Dzhaleyl)
are the author’s names, not stolen OFL reserved font names.
