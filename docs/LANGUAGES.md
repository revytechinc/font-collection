# Languages and script coverage

English is first. Constructed and fictional languages are kept on purpose. Vulcan / Golic ships an
informal web extra (Iyik overlay). Native Zun is not shipped.

Status keys:
* **unique script** — a non-Latin writing system with a shippable font (or a
  documented gap).
* **Latin** — romanization / official Latin orthography; covered by Noto Sans
  / Noto Sans Mono.
* **not shipped** — unique script exists but cannot be vendored.

| Language | Code | Script status | What this collection ships |
|---|---|---|---|
| English | en | Latin | Noto Sans + Noto Sans Mono (default UI / terminal) |
| Dig Adlantisag | — | unique script **not shipped** (Disney); **Latin** transcription ASCII + `sh` | Noto Latin only. No Disney fonts. |
| Dothraki | — | Latin (ASCII; digraphs) | Noto |
| Esperanto | eo | Latin (ĉĝĥĵŝŭ) | Noto |
| Lìʼfya leNaʼvi | — | Latin (ì ä ʼ U+02BC ù) | Noto |
| Quenya | qya | unique script: tengwar (CSUR-based PUA U+E000+); also Latin transcription | Alcarin Tengwar (GUI/print) + Noto Latin |
| Valyrian | — | Latin (macrons + ȳ U+0232/U+0233) | Noto |
| Valyrio | — | Latin (Low Valyrian family) | Noto |
| tlhIngan Hol | tlh | unique script: pIqaD CSUR U+F8D0–U+F8FF; also Latin xifan hol | pIqaD qolqoS (default) + optional HaSta; Noto Latin |
| Vulcan / Golic | — | unique script: **no Unicode/CSUR**; informal **Latin overlay** extra (Iyik); Zun **not shipped** | Iyik (+ Kitaun/Tanaf/Golsu/Dzhaleyl) as **web/specimen extras only**, not OFL OS default. Noto Latin transcription. Request Zun from skladan at korsaya.org. We do not redistribute Zun. |

Guidelines list (fictional / constructed subset, English first): English,
Dig Adlantisag, Dothraki, Esperanto, Lìʼfya leNaʼvi, Quenya, Valyrian,
Valyrio, tlhIngan Hol, plus Vulcan/Golic.

Natural languages in the CloudBSD i18n list (Bahasa Indonesia, Català, Deutsch,
Español, …) use the same Noto Latin/Greek/Cyrillic cut for their Latin and
Cyrillic orthographies; this collection does not vendor CJK/Arabic/etc. Noto faces.

## Unicode ranges (shipped faces)

| Face | Range |
|---|---|
| Noto Sans / Mono | Basic Latin, Latin-1, Latin Extended-A, Latin Extended-B (incl. ȳ), U+02BC |
| pIqaD qolqoS / HaSta | U+F8D0–U+F8FF (CSUR pIqaD) |
| Alcarin Tengwar | primarily U+E000–U+E07F (some extras may sit beyond U+E07F) |
| Iyik / Kitaun / Tanaf / Golsu / Dzhaleyl (web extra, not OFL) | Latin-1 overlay dingbat U+0000–00FF; **not** a Golic Unicode range |

## Console (PSF2)

| Face | File | Notes |
|---|---|---|
| CloudBSD-Latn-8x16 | `fonts/console/psf/CloudBSD-Latn-8x16.psf` | 512 glyphs, 8×16. ASCII + Latin-1 + eo + Naʼvi + Valyrian extras from Noto Sans Mono. |
| CloudBSD-Piqd-16x16 | `fonts/console/psf/CloudBSD-Piqd-16x16.psf` | 512 glyphs, 16×16. Latin-1 from Noto + U+F8D0–U+F8FF from qolqoS. |
| Tengwar | **none** | Combining tehtar need OpenType GPOS. |
| Golic native | **none** | No Unicode cmap; joining script. Iyik overlay is web-only, not PSF. |
| Atlantean native | **none** | Not redistributable. |
