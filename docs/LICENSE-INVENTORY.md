# REVYTECH font collection — license inventory

**Date:** 2026-08-30; Iyik web-extra ship 2026-08-31 (America/Chicago)  
**Scope:** Verify redistributable licenses for the REVYTECH font collection (includes the CloudBSD constructed-language faces). Work performed on the box only; no clones onto user machines; no credentials/tokens/SSH keys read.  
**Method:** Upstream LICENSE/OFL pages, project pages, GitHub raw license files, CSUR registry. Quotes are short excerpts from those sources.

**Decision key**

| Decision | Meaning |
|---|---|
| **YES** | Formal, inspectable license grants redistribution (and typically bundling with software). Safe to vendor if OFL/GPL/MS-PL/Bitstream Vera terms are followed. |
| **YES (informal)** | Author publicly said “free to distribute,” but there is no OFL/GPL/MIT file. Legal risk for an OS image; do not treat as a primary ship face. |
| **NO** | Not redistributable, or redistribution is so encumbered that we must not vendor. |

**Trademark vs font license (applies to several rows):** A font’s SIL OFL / GPL / WTFPL grant covers *font software*. It does **not** license CBS/Paramount “Klingon,” Disney Atlantis, or the Tolkien Estate’s tengwar *script as a commercial product identity*. Keep names/marks out of marketing copy; ship as script coverage.

---

## 1. Klingon pIqaD (PRIORITY)

**Script encoding (all Unicode pIqaD fonts below):** ConScript Unicode Registry, BMP PUA **U+F8D0–U+F8FF**.

Assigned (CSUR, https://evertype.com/standards/csur/klingon.html):

- Letters: U+F8D0–U+F8E9 (a b ch D e gh H I j l m n ng o p q Q r S t tlh u v w y ʼ)
- Unused: U+F8EA–U+F8EF, U+F8FA–U+F8FC
- Digits: U+F8F0–U+F8F9
- Punctuation: U+F8FD COMMA, U+F8FE FULL STOP, U+F8FF MUMMIFICATION GLYPH

Linux historically registered this block in `Documentation/unicode.txt` (H. Peter Anvin). KLI-endorsed. ISO 15924 script code `Piqd` / 293 exists; Klingon is **not** in the official Unicode Standard (proposals only).

### 1.1 pIqaD qolqoS (dadap/pIqaD-fonts) — **RECOMMENDED PRIMARY**

| Field | Value |
|---|---|
| Name | pIqaD qolqoS (DanIlmoH / Daniel Dadap) |
| URL | https://github.com/dadap/pIqaD-fonts |
| License file | https://raw.githubusercontent.com/dadap/pIqaD-fonts/master/LICENSE |
| README | https://raw.githubusercontent.com/dadap/pIqaD-fonts/master/README.md |
| Releases | https://github.com/dadap/pIqaD-fonts/releases |
| License | **SIL Open Font License 1.1** (Reserved Font Name `"pIqaD qolqoS"`) |
| Redistributable | **YES** |
| Unicode range | CSUR **U+F8D0–U+F8FF** |
| TTF/OTF | **Yes — recommend** |
| WOFF2 | **Yes — convert from TTF under OFL** (format change is a Modified Version; keep OFL + do not use reserved name if metrics/glyphs change) |
| PSF | **Possible** (see console section): ~40 LTR non-joining glyphs |

**Quoted evidence**

> Copyright (c) 2018, Daniel Dadap (daniel@dadap.net), with Reserved Font Name "pIqaD qolqoS". This Font Software is licensed under the SIL Open Font License, Version 1.1.

> The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and/or sold with any software …

> using the encoding for Klingon pIqaD registered in the ConScript Unicode Registry … from code points U+F8D0 to U+F8FF.

**Notes**

- Sans-style, drawn from scratch in BirdFont except U+F8FF.
- **U+F8FF contamination caveat:** README says the mummification/Empire glyph was copied from qurgh’s “pIqaD” font (`https://hol.kag.org/pIqaDFontsNormalAndWeb.zip`), whose site asks: *“These [fonts] are free to use, but we ask that this page is mentioned if they are used in a commercial product.”* That is **not** OFL. For a strict ship, either (a) mention hol.kag.org for that one glyph, or (b) omit/redraw U+F8FF (an OFL Modified Version; then cannot keep the reserved name without permission).
- “Klingon is a registered trademark of CBS Studios Inc.” (README). Font license ≠ trademark license.

### 1.2 DIn pIqaD / pIqaDqoq (fuddl) — optional WOFF

| Field | Value |
|---|---|
| Name | DIn pIqaD (repo: pIqaDqoq) |
| URL | https://github.com/fuddl/pIqaDqoq (also https://github.com/fuddl/DIn-pIqaD) |
| License file | https://raw.githubusercontent.com/fuddl/pIqaDqoq/master/LICENSE and https://raw.githubusercontent.com/fuddl/DIn-pIqaD/master/LICENSE |
| License | **WTFPL v2** |
| Redistributable | **YES** (permissive; some distros dislike WTFPL as a license *name*) |
| Unicode range | CSS `unicode-range: U+F8D0-F8E9,U+F8F0-F8F9,U+F8FD-F8FF` (CSUR; skips unused cells) |
| TTF/OTF | Yes if present in repo |
| WOFF2 | **WOFF already shipped** as `dist/DIn pIqaD.woff` — convert to WOFF2 if wanted |
| PSF | Same as other CSUR pIqaD: possible |

**Quoted evidence**

> DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE Version 2, December 2004 … 0. You just DO WHAT THE FUCK YOU WANT TO.

README (project page) documents web embedding and the CSUR range above.

**Notes:** Prefer dadap OFL for the OS image. Keep fuddl as a WOFF/web optional extra if WTFPL is acceptable.

### 1.3 Evertype Klingon pIqaD HaSta / Mandel / vaHbo’ — **YES, OFL display faces**

Project page: https://www.evertype.com/fonts/tlh/  
Designers: Mike Neff (qa’vaj) 2004–2005, edited by Michael Everson 2009. Encoding: CSUR pIqaD.

| Face | TTF zip | OFL licence page | Reserved Font Names |
|---|---|---|---|
| **HaSta** (‘viewscreen’, KLI-style) | https://evertype.com/fonts/tlh/klingon-piqad-hasta.zip | https://evertype.com/fonts/tlh/klingon-piqad-hasta-licence.html | `pIqaD HaSta` / `Klingon pIqaD HaSta` |
| **Mandel** (Klinzhai glyphs refit as pIqaD) | https://evertype.com/fonts/tlh/klingon-piqad-mandel.zip | https://evertype.com/fonts/tlh/klingon-piqad-mandel-licence.html | `pIqaD Klinz` / `Klingon pIqaD Mandel` |
| **vaHbo’** (whimsical ‘lava’) | https://evertype.com/fonts/tlh/klingon-piqad-vahbo'.zip | https://evertype.com/fonts/tlh/klingon-piqad-vahbo'-licence.html | `pIqaD fusion` / `Klingon pIqaD vaHbo’` |

| Field | Value |
|---|---|
| License | **SIL OFL 1.1** (pages are titled “Shareware Licence” but the body is the standard OFL) |
| Redistributable | **YES** |
| Unicode range | CSUR **U+F8D0–U+F8FF** |
| TTF/OTF | **Yes — TTF** |
| WOFF2 | Convert under OFL |
| PSF | Possible (HaSta is the best bitmap candidate of the three) |

**Quoted evidence (HaSta; Mandel and vaHbo’ are the same OFL with different reserved names):**

> This Font Software is licensed under the SIL Open Font License, Version 1.1.

> The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and/or sold with any software …

> The encoding of all of these fonts conforms to the ConScript Unicode Registry registration for Klingon pIqaD.

**Notes:** HaSta is the conventional “screen” face (used e.g. in the Haynes Bird of Prey manual). Mandel is a different glyph tradition (Klinzhai). Ship **HaSta as optional display**, qolqoS as UI/default. Bundle each OFL HTML/text with the font.

### 1.4 Other Klingon (not requested, recorded)

- **Bing pIqaD** (Shawn Steele): MS-PL. Blog: https://learn.microsoft.com/en-us/archive/blogs/shawnste/piqad-font-for-bings-klingon-translator — redistributable under MS-PL if you still have the zip; not needed if qolqoS/HaSta ship.
- **qurgh / hol.kag.org:** “free to use” + commercial-mention request — **do not vendor** as a primary face.

---

## 2. Vulcan Golic (gotavlu-zukitaun)

Golic Vulcan is a **joining / contextual** modern script (plus ceremonial calligraphy and handwriting). There is **no CSUR/Unicode block**. Existing fonts overlay Latin / Windows-1252 code points (e.g. Alt+0228 for a multi-letter “au” glyph). That is a dingbat mapping, not a script encoding.

### 2.1 Zun (korsaya.org, Britton Watkins) — **DO NOT VENDOR**

| Field | Value |
|---|---|
| Name | Zun (font name `zun`) |
| URL | http://korsaya.org/ (and http://korsaya.org/2012/01/a-new-vulcan-font/) |
| How obtained | **Email request only** to skladan ‹at› korsaya ‹dot› org |
| License | Proprietary freeware; no redistribution grant |
| Redistributable | **NO** |
| Unicode range | Not Unicode; Latin/ANSI overlay for Golic typesetting |
| TTF/OTF / WOFF2 / PSF | **Do not ship** |

**Quoted evidence**

korsaya.org homepage:

> I continue to provide the ZUN font to several people on average each week and though it is still technically in beta … please feel free to request it from me via traditional e-mail at skladan ‹at› korsaya ‹dot› org if you are interested in having it.

Zun User’s Manual (beta), as reproduced in public copies:

> The font, Zun, and this documentation are provided as a free service to the Golic Vulcan enthusiast community without warranty or any guarantee.

> You may not modify the font in any way without the express written permission of Britton Watkins (aka: Briht’uhn) of [korsaya.org]. Zun may not be sold for monetary income by anyone for any reason.

Vulcan Quest (third party, confirming the distribution model):

> It can be obtained from SKLADAN @KORSAYA .ORG by e-mail request. … it is not my creation to give away.

**Verdict:** Confirmed **not redistributable**. Do **not** recommend vendoring. Users who want Zun must request it themselves.

### 2.2 Iyik Vulkansu (vulcanquest) — informal redistribute; **not recommended as primary**

| Field | Value |
|---|---|
| Name | Iyik Vulkansu (“Iyik”; “Modern Vulcan”) |
| Project page | https://vulcanquest.wordpress.com/2019/12/22/fonts/ |
| Zip | https://drive.google.com/open?id=16tLCiEGhsjB_kO_wIOHylEYcGLdp5oBh |
| License file in zip | **None found.** No OFL.txt / GPL / MIT. The *only* license text is the blog post. |
| License | Informal public permission to distribute |
| Redistributable | **YES (informal)** — not a clean OS-vendoring license |
| Unicode range | **Not Unicode.** Author: Iyik uses the same key/Alt-code mapping as Zun (example: Alt+0228 → same “au” glyph as Zun’s U+00E4 slot). Also maps extra “au” to capital W (Zun-incompatible). |
| TTF/OTF | TTF in the Google Drive zip (author-made in FontForge, “using korsaya.org as a guide”) |
| WOFF2 | **Shipped as specimen extra** (`fonts/vul/iyik/woff2/Iyik-Vulkansu.woff2`). Format conversion only. |
| PSF | Poor: Latin overlay dingbat; **do not** make a console face. |

**Quoted evidence (this *is* the actual license text):**

> The last font is Iyik Vulkansu or Iyik for short. … This font is created as a backup. In case someone can not get a hold of Zun, they won’t be left without a usable font for learning. Zun is superior, and I have a copy, but it is not my creation to give away. … Iyik however is free to distribute.

> All of these fonts are free to distribute to anyone who wants them. The fonts may be found in this zip file here: https://drive.google.com/open?id=16tLCiEGhsjB_kO_wIOHylEYcGLdp5oBh

**Notes**

- Grant is **redistribution only**; no statement about modification, embedding, sublicensing, or relicensing.
- Glyphs were drawn to imitate Zun as a fallback. That is **not** a copy of the Zun *file*, but a conservative OS vendor may still want to avoid shipping a lookalike of a non-redistributable face.
- Same post also licenses Kitaun, El’ru, Tanaf under the same informal sentence — same caveats.
- **Recommendation (updated 2026-08-31):** Ship Iyik as a **web/specimen extra only** (`fonts/vul/`, `www/fonts/`, fun.cloudbsd.cat). Do **not** add it to `make install`, fontconfig, or the FreeBSD pkg image as a primary/OFL face. Keep Zun’s email path. Render Latin transcription with Noto beside the overlay. CSS family `Iyik Vulkansu` is not an OFL RFN.

### 2.3 Kitaun and Tanaf (same 2019 zip as Iyik)

Same informal sentence (“All of these fonts are free to distribute to anyone who wants them.”). Shipped as extras next to Iyik. Tanaf is **not** Zun-compatible. Not OFL. Not OS default.

### 2.4 Golsu and Dzhaleyl (later Vulcan Quest packages)

2022 Golsu zip readme: “Both fonts are free to distribute, copy, share, modify or re-post.” 2025-11-17 updated-fonts post: “Though copyrighted, all fonts may be copied, distributed, and modified. If you have a web page, feel free to distribute the fonts from there.” Shipped as extras (`fonts/vul/golsu`, `fonts/vul/dzhaleyl`). Not OFL. Not OS default. **Zun still not shipped.**

---

## 3. Quenya / Tengwar

Tengwar is **not** in official Unicode. Free Tengwar Font Project / Everson 2001 CSUR-style mapping: **PUA U+E000–U+E07D** (tehtar as combining marks). Proper rendering needs OpenType anchors / GPOS; a dumb bitmap console cannot place tehtar.

### 3.1 Tengwar Annatar (Johan Winge) — **do not recommend**

| Field | Value |
|---|---|
| Name | Tengwar Annatar |
| URL (historical) | https://web.archive.org/web/20130729210254/home.student.uu.se/j/jowi4905/fonts/annatar.html |
| License text copies | https://github.com/luxcem/ttf-tengwar-annatar ; tngandoc.pdf mirrors |
| License | **Freeware, not OFL.** Unmodified-full-archive redistribution; **commercial use requires sending the author a free copy of the final product** |
| Redistributable | **NO for an OS image** (commercial copy-back; no modification; Tolkien Estate note) |
| Mapping | Daniel S. Smith / Latin overlay (not CSUR PUA) |
| TTF/OTF / WOFF2 / PSF | Do not ship |

**Quoted evidence**

> The Tengwar Annatar type family … is the property of the creator, Johan Winge, copyright © 2004–2005. It is distributed as freeware, meaning that you may download it, free of charge, and use it in any non-commercial publication or product.

> You may redistribute this font under the following terms: That all files, without exceptions, in the original distribution are included in unmodified form, and that no fee is charged …

> In the case of commercial use, this font may be used in a commercial project of yours, as long as I am provided, at your expense, with a free copy of the final product. This also applies, but is not limited, to share- or freeware compilations.

> Please note that for you to use J. R. R. Tolkien’s tengwar script in a commercial production you may have to have permission from the Tolkien Estate.

**Verdict:** Confirmed freeware-not-OFL with commercial copy-back. **Do not recommend.**

### 3.2 Alcarin Tengwar (Toshi Omagari) — **RECOMMENDED OFL TENGWAR**

| Field | Value |
|---|---|
| Name | Alcarin Tengwar |
| URL | https://github.com/Tosche/Alcarin-Tengwar |
| License file | https://raw.githubusercontent.com/Tosche/Alcarin-Tengwar/main/OFL.txt |
| Designer notes | https://tosche.net/fonts/alcarin-tengwar |
| License | **SIL OFL 1.1** (Reserved Font Name `Alcarin`) |
| Redistributable | **YES** |
| Unicode range | Custom mapping **based on Free Tengwar / CSUR PUA**, primarily **U+E000–U+E07F**; README warns some extras go **beyond U+E07F** and may migrate |
| TTF/OTF | **OTF (autohinted) + variable TTF** in repo (`Fonts Static`, `Fonts Variable`) |
| WOFF2 | **Yes — web fonts in the repo** |
| PSF | **No** (combining tehtar, ligatures, ZWJ, anchors) |

**Quoted evidence**

> Copyright (c) 1 January 2022, Toshi Omagari (https://tosche.net\|tosche@mac.com), with Reserved Font Name Alcarin. This Font Software is licensed under the SIL Open Font License, Version 1.1.

> The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. … can be bundled, embedded, redistributed and/or sold with any software …

> Alcarin Tengwar is released under Open Font License 1.1.

> The glyph mapping … uses my custom mapping based on Free Tengwar’s (http://freetengwar.sourceforge.net/mapping.html).

**Notes:** Does not contain Latin (except a Noto Serif subset added so macOS lists the font). Pair with Noto/DejaVu for roman text. Brill is a *design pair*, **not** OFL — do not vendor Brill.

### 3.3 Free Tengwar Font Project / Tengwar Telcontar

| Field | Value |
|---|---|
| Name | Free Tengwar Font Project (Tengwar Telcontar, FreeMonoTengwar, …) |
| URL | https://freetengwar.sourceforge.net/ (SourceForge project: https://sourceforge.net/projects/freetengwar/) |
| License | SourceForge metadata: **GPLv3 and OFL 1.1**. Tengwar Telcontar is widely packaged as **GPL-3.0 + font embedding exception** (AUR `ttf-tengwar-telcontar`: Licenses: GPL3; font name table “distributed under the terms of the GNU General Public License”). |
| Redistributable | **YES** (copyleft if you take the GPL Telcontar build) |
| Unicode range | CSUR-style **U+E000–U+E07D** (project mapping page) |
| TTF/OTF | Yes |
| WOFF2 | Convert |
| PSF | **No** (tehtar) |

Project site (indexed; live fetch from this box was Cloudflare-blocked):

> The Free Tengwar Font Project is free software: You can redistribute it and/or modify it under the terms of the GNU General Public License … version 3 … As a special exception, if you create a document which uses a Free Tengwar Font Project font, and embed that font … that font does not by itself cause the resulting document to be covered by the GNU General Public License. … Please note that for you to use J. R. R. Tolkien’s tengwar script in a commercial production you may need permission from the Tolkien Estate.

**Recommendation:** Prefer **Alcarin (OFL)** over Telcontar (GPL) for a BSD-licensed OS image so the font does not impose GPL on modified font files. Telcontar remains a valid CSUR-compatible alternative if GPL-3 font exception is acceptable.

### 3.4 Greifswalder Tengwar (Peter Wiegel)

| Field | Value |
|---|---|
| Name | Greifswalder Tengwar |
| URL | https://peter-wiegel.de/greifswaldertengwar.html |
| Zip | http://www.peter-wiegel.de/Fonts/greifswaldert.zip |
| Author license page | https://www.peter-wiegel.de/Fonts/index.html |
| License | Author states self-drawn fonts are **CC and/or GPL-with-font-exception and/or SIL OFL**; “Eine Kopie ist dem jeweiligen Archiv hinzugefügt.” Fontspace lists this face as **SIL OFL**. Confirm OFL.txt **inside the zip** before shipping. |
| Redistributable | **YES, pending zip-license check** |
| Unicode range | **Daniel S. Smith ASCII/Latin mapping** (Tengwar Scribe compatible) — **not** CSUR PUA |
| TTF/OTF | TTF |
| WOFF2 | Convert |
| PSF | No (tehtar overlays on ASCII; would smash Latin console) |

**Quoted evidence**

> Alle hier bereitgestellten Fonts stelle ich unter der Creative Commons-Lizenz, GPL mit Font-Exception und/oder SIL Open Font License zur Verfügung und damit auch frei für kommerzioelle Projekte nutzbar … Eine Kopie ist dem jeweiligen Archiv hinzugefügt.

> Auch diese Schrift folgt wieder der mittlerweile als Standard etablierten Belegung nach Daniel S. Smith

**Notes:** Do not use as the Unicode/CSUR Tengwar face. Optional only if a Smith-mapped desktop font is wanted.

---

## 4. Atlantean / Dig Adlantisag

| Field | Value |
|---|---|
| Name | Atlantean script (film *Atlantis: The Lost Empire*) |
| Language | Dig Adlantisag (Marc Okrand); script by John Emerson + Okrand for **Walt Disney Feature Animation** |
| Native-script fonts | “Atlantean” TTF and similar dingbats; font name-table copyright commonly **“Version 1.2, Copyright 1999, The Walt Disney Company”** |
| Redistributable | **NO** |
| Unicode range | **None.** Native script is not in Unicode/CSUR. Fan fonts map glyphs onto **Basic Latin** as a cipher. |
| TTF/OTF / WOFF2 / PSF | **Do not ship any Atlantean-script font** |

**Quoted evidence**

Wikipedia (*Atlantean language*): created “specially for the Walt Disney Feature Animation film Atlantis: The Lost Empire”; “script created expressly for the movie by John Emerson with the help of Marc Okrand.”

Fan-site copyright page (http://atlanteandragon.itgo.com/copyright.htm):

> Atlantis: The Lost Empire and all related logos, titles, and characters are copyright Disney Enterprises, all rights reserved. The Atlantean font is also by Disney.

**Latin transcription (what we *will* ship):** Okrand “Standard Transcription” is **ASCII Latin plus the digraph `sh`**. Inventory: a b g d e u w h i y k l m n o p r s sh t (and numerals spelled in Latin). No unique diacritics. **Noto / DejaVu cover this fully.** Reader’s Script uses extra English-friendly spellings (ah, kh, ee, …) — still Latin.

**PSF:** Latin transcription **yes**; native boustrophedon script **no** (copyright + dingbat).

---

## 5. Latin-script conlangs (Noto / DejaVu)

These languages have **no native non-Latin script in Unicode**. One OFL Latin family covers all of them.

### 5.1 Noto Sans / Noto Sans Mono — **RECOMMENDED LATIN + TERMINAL**

| Field | Value |
|---|---|
| Name | Noto Sans, Noto Sans Mono (Noto Serif optional) |
| Source repo | https://github.com/notofonts/latin-greek-cyrillic |
| OFL file | https://raw.githubusercontent.com/notofonts/latin-greek-cyrillic/main/OFL.txt |
| Google Fonts | https://fonts.google.com/noto ; specimens Noto Sans / Noto Sans Mono |
| Older tree | https://github.com/notofonts/noto-fonts (archived; SPDX OFL-1.1) |
| License | **SIL OFL 1.1** |
| Redistributable | **YES** |
| TTF/OTF | Yes (static + variable) |
| WOFF2 | Yes (Google Fonts / repo web builds) |
| PSF | **Yes** — subset needed code points into a 256- or 512-glyph PSF |

**Quoted evidence**

> Copyright 2022 The Noto Project Authors (https://github.com/notofonts/latin-greek-cyrillic) This Font Software is licensed under the SIL Open Font License, Version 1.1.

> The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. … can be bundled, embedded, redistributed and/or sold with any software …

Noto docs: “All Noto fonts are licensed under the Open Font License.”

### 5.2 DejaVu (Sans / Sans Mono) — **YES, but not OFL**

| Field | Value |
|---|---|
| Name | DejaVu fonts |
| URL | https://github.com/dejavu-fonts/dejavu-fonts |
| License page | https://dejavu-fonts.github.io/License.html |
| License file | https://raw.githubusercontent.com/dejavu-fonts/dejavu-fonts/master/LICENSE |
| License | **Bitstream Vera + Arev** (DejaVu changes public domain). **Not SIL OFL.** |
| Redistributable | **YES** |
| TTF/OTF | Yes |
| WOFF2 | Convert |
| PSF | **Yes** — classic Linux console choice |

**Quoted evidence**

> Fonts are (c) Bitstream (see below). DejaVu changes are in public domain. Glyphs imported from Arev fonts are (c) Tavmjong Bah (see below)

> Permission is hereby granted, free of charge, to any person obtaining a copy of the fonts … to reproduce and distribute the Font Software, including without limitation the rights to use, copy, merge, publish, distribute, and/or sell copies of the Font Software …

> The Font Software may be sold as part of a larger software package but no copy of one or more of the Font Software typefaces may be sold by itself.

Rename derivatives away from “Bitstream” / “Vera” / “Arev”. Shipping unmodified *DejaVu* names is the normal distro practice.

### 5.3 Required code points by language

#### Esperanto (eo)

Circumflex / breve letters (Latin Extended-A):

| Glyph | Code | Glyph | Code |
|---|---|---|---|
| Ĉ ĉ | U+0108 U+0109 | Ĝ ĝ | U+011C U+011D |
| Ĥ ĥ | U+0124 U+0125 | Ĵ ĵ | U+0134 U+0135 |
| Ŝ ŝ | U+015C U+015D | Ŭ ŭ | U+016C U+016D |

Plus ASCII a–z except q w x y unused. Optional: spesmilo ₷ U+20B7 (rare; skip for PSF).

Noto Sans / DejaVu: **covered**.

#### Dothraki (lekh Dothraki)

No native script. Peterson romanization is **ASCII-only** (deliberately). Digraphs: ch sh zh th kh; geminates tth ssh zzh cch kkh; q = uvular stop. Optional stress acute (á é í ó) in some pedagogical text — Latin-1 `U+00E1` etc. if wanted.

**Required:** Basic Latin. **Optional:** Latin-1 Supplement acutes. Noto/DejaVu: **covered**.

#### Lìʼfya leNaʼvi

Latin + two vowels + glottal stop:

| Glyph | Code | Role |
|---|---|---|
| ì Ì | U+00EC U+00CC | near-close front |
| ä Ä | U+00E4 U+00C4 | /æ/ |
| ʼ | **U+02BC** MODIFIER LETTER APOSTROPHE (preferred; letter, not punctuation). Fallbacks: U+2019, U+0027 | glottal stop (tìftang) |
| ù Ù | U+00F9 U+00D9 | Reef Naʼvi /ʊ/ (newer) |

Digraphs px tx kx ts ng aw ew ay ey. Ejective/affricate sequences are ASCII.

Noto/DejaVu: **covered** (include U+02BC in the PSF map).

#### Valyrian / Valyrio (High Valyrian)

Peterson did **not** ship a native glyph system for GoT; on-screen letters used Latin. Official romanization = Latin + **macron long vowels**:

| Glyph | Code | Glyph | Code |
|---|---|---|---|
| Ā ā | U+0100 U+0101 | Ē ē | U+0112 U+0113 |
| Ī ī | U+012A U+012B | Ō ō | U+014C U+014D |
| Ū ū | U+016A U+016B | Ȳ ȳ | U+0232 U+0233 |

Also short **y** (rounded /y/) in Basic Latin. G always hard; j as /j/. No ǵ in the official orthography.

**Ȳ/ȳ is Latin Extended-B** — confirm the chosen Noto/DejaVu cut includes U+0232/U+0233 (Noto Sans does; include in PSF).

#### English / terminals

Noto Sans Mono **or** DejaVu Sans Mono. Prefer Noto if the pack should be uniformly OFL; DejaVu if you want the familiar Linux console metric.

---

## 6. Console / PSF feasibility

PSF/PSF2 = bitmap, typically 256 or 512 glyphs, 8×16 (or 8×8/8×14). Combining marks, cursive joining, and OpenType ligatures **do not work**. Unicode mapping in PSF2 is a simple cmap, not a shaper.

| Script | PSF? | Why |
|---|---|---|
| Esperanto, Dothraki, Naʼvi, Valyrian, Atlantean *Latin*, English | **YES** | Non-joining Latin. 512-glyph PSF easily holds Latin-1 + Ext-A + ȳ + U+02BC. |
| Klingon pIqaD (CSUR PUA) | **YES, awkward** | ~40 LTR, non-joining, no combining. Linux already documented this PUA. Needs a 512-glyph PSF (or a dedicated console face) because 256 is full if you also keep Latin. Console apps must emit U+F8D0+ (not Latin “Klingon fonts”). |
| Tengwar | **NO** | Tehtar are combining marks that must GPOS-anchor on tengwar; ligatures (silme, sa-rince, ZWJ). A bitmap would be unreadable or require a huge precomposed set. |
| Vulcan Golic | **NO** | Joining/contextual; some vertical; vowel-as-diacritic handwriting; no Unicode cmap. |
| Atlantean native | **NO** | Disney copyright; dingbat-on-ASCII would destroy Latin console. |

**PSF ship recommendation:** one `Latn` console font from Noto Sans Mono or DejaVu Sans Mono covering the Latin table in §5.3; optional second PSF `Piqd` mapping U+F8D0–U+F8FF from qolqoS bitmaps. Do not attempt Tengwar/Vulcan/Atlantean native PSF.

---

## Per-candidate summary table

| Name | URL | License | Redistributable | Unicode range | TTF/OTF | WOFF2 | PSF | Notes |
|---|---|---|---|---|---|---|---|---|
| **pIqaD qolqoS** | https://github.com/dadap/pIqaD-fonts | SIL OFL 1.1 | **YES** | U+F8D0–U+F8FF | **yes** | convert | possible | **Primary Klingon.** RFN `pIqaD qolqoS`. Redraw/omit U+F8FF or mention hol.kag.org. |
| **DIn pIqaD / pIqaDqoq** | https://github.com/fuddl/pIqaDqoq | WTFPL v2 | **YES** | U+F8D0–F8E9, F8F0–F8F9, F8FD–F8FF | yes | **WOFF in repo** | possible | Optional; OFL is cleaner for BSD. |
| **Klingon pIqaD HaSta** | https://www.evertype.com/fonts/tlh/ + hasta zip/licence | SIL OFL 1.1 | **YES** | U+F8D0–U+F8FF | **TTF yes** | convert | possible | Best KLI-style display face. |
| **Klingon pIqaD Mandel** | same / mandel zip+licence | SIL OFL 1.1 | **YES** | U+F8D0–U+F8FF | TTF | convert | possible | Klinzhai shapes; extra, not default. |
| **Klingon pIqaD vaHbo’** | same / vahbo' zip+licence | SIL OFL 1.1 | **YES** | U+F8D0–U+F8FF | TTF | convert | possible | Whimsical; extra. |
| **Zun** | http://korsaya.org/ (email only) | Proprietary; no-mod, no-resale, email distribution | **NO** | Latin overlay, not Unicode | do not ship | no | no | **Do not vendor.** |
| **Iyik Vulkansu** | https://vulcanquest.wordpress.com/2019/12/22/fonts/ zip on Google Drive | Informal “free to distribute” only | **YES (informal)** | Latin/ANSI overlay matching Zun | TTF in zip | **web extra** | no | Specimen only; not OFL OS default. |
| **Tengwar Annatar** | Winge freeware (archive URL above) | Freeware + commercial copy-back | **NO** (for OS) | Smith Latin overlay | do not ship | no | no | Confirmed not OFL. |
| **Alcarin Tengwar** | https://github.com/Tosche/Alcarin-Tengwar | SIL OFL 1.1 | **YES** | CSUR-based U+E000+ | **OTF/TTF yes** | **yes in repo** | **no** | **Primary Tengwar.** |
| **Tengwar Telcontar / FTFP** | https://freetengwar.sourceforge.net/ | GPL-3 + font exception (Telcontar); project also lists OFL | **YES** | U+E000–U+E07D | yes | convert | no | Prefer Alcarin for OFL. |
| **Greifswalder Tengwar** | https://peter-wiegel.de/greifswaldertengwar.html | OFL/GPL-font-ex/CC (confirm zip) | **YES*** | Smith ASCII overlay | TTF | convert | no | Not CSUR; don’t make default. |
| **Atlantean script fonts** | Disney 1999 name-table | Disney copyright | **NO** | none / Latin dingbat | no | no | no | Latin transcription only. |
| **Noto Sans / Sans Mono** | https://github.com/notofonts/latin-greek-cyrillic | SIL OFL 1.1 | **YES** | Latin, Ext-A, Ext-B ȳ, U+02BC, … | **yes** | **yes** | **yes** | **Primary Latin + terminal.** |
| **DejaVu Sans / Sans Mono** | https://github.com/dejavu-fonts/dejavu-fonts | Bitstream Vera + Arev (not OFL) | **YES** | same Latin needs | yes | convert | **yes** | Terminal alternative. |

---

## Recommended ship set

One primary face per unique **script**, plus one Latin family for all romanized conlangs.

| Slot | Ship | Format | Why |
|---|---|---|---|
| **Klingon pIqaD (primary)** | **pIqaD qolqoS** (dadap) | TTF + WOFF2; optional PSF cmap | OFL 1.1, CSUR U+F8D0–U+F8FF, GitHub LICENSE inspectable. |
| **Klingon pIqaD (display, optional)** | **Klingon pIqaD HaSta** (Evertype) | TTF + OFL HTML | OFL 1.1, conventional KLI shapes. Mandel/vaHbo’ only if you want extras. |
| **Vulcan Golic** | **Iyik web extra** + Noto Latin. Zun still email-only. | WOFF2 in `www/fonts/` and `fonts/vul/` | Zun **NO**. Iyik informal-only overlay; **not** OFL OS default. |
| **Tengwar (primary)** | **Alcarin Tengwar** | OTF + WOFF2 from upstream | Clear OFL.txt, CSUR-based PUA, combining tehtar. GUI/print only. |
| **Atlantean** | **Latin transcription only** | (covered by Noto) | Disney owns the script/font. |
| **Esperanto, Dothraki, Naʼvi, Valyrian, English UI** | **Noto Sans** | TTF/OTF + WOFF2 | OFL 1.1; all required Latin code points. |
| **Terminals / PSF** | **Noto Sans Mono** (OFL) *or* **DejaVu Sans Mono** (Vera) | TTF + one PSF2 | PSF subset: ASCII + eo (ĉĝĥĵŝŭ) + Naʼvi (ìäʼù) + Valyrian macrons + ȳ. Optional second PSF for pIqaD PUA. |

**Do not ship:** Zun, Iyik as a supported **OS/pkg** font (web extra is OK), Tengwar Annatar, any Disney Atlantean dingbat, Greifswalder as the Unicode Tengwar, Brill (pairs with Alcarin but is not OFL).

**License hygiene when vendoring OFL faces**

1. Copy `OFL.txt` / Evertype licence HTML next to each font.  
2. Honor Reserved Font Names on Modified Versions (including WOFF2 *if* you alter glyphs/metrics; a pure compress is generally still a “Modified Version” under OFL definitions — keep the RFN only if you are distributing the Original Version or have permission).  
3. Do not sell the fonts standalone.  
4. Mention hol.kag.org if you keep dadap’s U+F8FF glyph, or redraw it.  
5. CBS / Disney / Tolkien Estate marks are out of scope of these font licenses.

**Verification gaps (non-blocking)**

- SourceForge live HTML for Free Tengwar was Cloudflare-blocked from this box; Telcontar GPL + exception is corroborated by AUR, font name tables, and search-indexed project text. Alcarin already satisfies “at least one clearly OFL Tengwar.”
- Greifswalder: author-site dual-license statement verified; open the zip’s bundled licence before a final ship if you include it (we do not recommend including it).
- Iyik Google Drive zip **was** fetched 2026-08-31 (`16tLCiEGhsjB_kO_wIOHylEYcGLdp5oBh`). Zip contains no OFL; license text is the WordPress post (quoted in `fonts/vul/iyik/LICENSE.txt`). 2025 updated-fonts zip (`10FaK0AjKIlCsooUzOVyMCsSbwcniLGH-`) supplied Golsu/Dzhaleyl extras. Zun was not downloaded.
