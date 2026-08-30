#!/usr/bin/env python3
"""Generate PSF2 console fonts from OFL TTF sources.

Latin face: rasterized from Noto Sans Mono Regular (SIL OFL 1.1).
Klingon face: pIqaD glyphs from pIqaD qolqoS (SIL OFL 1.1); ASCII from Noto
Sans Mono so a loaded console remains usable. Output names do not use
Reserved Font Names (OFL Modified Versions).

Requires: python3-fonttools, python3-pil
"""
from __future__ import annotations

import struct
import sys
from pathlib import Path

from fontTools.ttLib import TTFont
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
NOTO_MONO = ROOT / "fonts/latn/noto-sans-mono/ttf/NotoSansMono-Regular.ttf"
QOLQOS = ROOT / "fonts/tlh/qolqos/ttf/pIqaD-qolqoS.ttf"
OUTDIR = ROOT / "fonts/console/psf"

PSF2_MAGIC = b"\x72\xb5\x4a\x86"
PSF2_HAS_UNICODE_TABLE = 0x01

# Required extras beyond Latin-1 (U+0000-U+00FF already covers ì ä ù).
EXTRA_LATIN = [
    # Esperanto (Latin Extended-A)
    0x0108, 0x0109, 0x011C, 0x011D, 0x0124, 0x0125,
    0x0134, 0x0135, 0x015C, 0x015D, 0x016C, 0x016D,
    # Valyrian macrons (Latin Extended-A)
    0x0100, 0x0101, 0x0112, 0x0113, 0x012A, 0x012B,
    0x014C, 0x014D, 0x016A, 0x016B,
    # Valyrian Ȳȳ (Latin Extended-B)
    0x0232, 0x0233,
    # Naʼvi glottal stop (modifier letter apostrophe)
    0x02BC,
]

PIQAD_RANGE = list(range(0xF8D0, 0xF900))  # 48 cells U+F8D0-U+F8FF


class Face:
    def __init__(self, path: Path):
        self.path = path
        self.tt = TTFont(str(path))
        self.cmap = self.tt.getBestCmap() or {}
        self._fonts: dict[int, ImageFont.FreeTypeFont] = {}

    def has(self, cp: int) -> bool:
        return cp in self.cmap

    def freetype(self, size: int) -> ImageFont.FreeTypeFont:
        if size not in self._fonts:
            self._fonts[size] = ImageFont.truetype(str(self.path), size=size)
        return self._fonts[size]


def rasterize(face: Face, cp: int, width: int, height: int, pad: int = 1) -> bytes:
    """Return PSF2 glyph bitmap (MSB-first, row padded to whole bytes)."""
    row_bytes = (width + 7) // 8
    img = Image.new("1", (width, height), 0)
    if cp == 0 or not face.has(cp):
        return _pack(img, width, height, row_bytes)

    ch = chr(cp)
    # Fit glyph into the cell: try height-based size then shrink if needed.
    size = max(height - 1, 6)
    ft = face.freetype(size)
    bbox = ft.getbbox(ch)
    if bbox is None:
        return _pack(img, width, height, row_bytes)
    gw = max(1, bbox[2] - bbox[0])
    gh = max(1, bbox[3] - bbox[1])
    avail_w = max(1, width - 2 * pad)
    avail_h = max(1, height - 2 * pad)
    scale = min(avail_w / gw, avail_h / gh, 1.0)
    if scale < 0.999:
        size = max(6, int(size * scale))
        ft = face.freetype(size)
        bbox = ft.getbbox(ch)
        if bbox is None:
            return _pack(img, width, height, row_bytes)
        gw = max(1, bbox[2] - bbox[0])
        gh = max(1, bbox[3] - bbox[1])

    x = (width - gw) // 2 - bbox[0]
    # Prefer optical vertical centering; clamp into cell.
    y = (height - gh) // 2 - bbox[1]
    draw = ImageDraw.Draw(img)
    draw.text((x, y), ch, font=ft, fill=1)
    return _pack(img, width, height, row_bytes)


def _pack(img: Image.Image, width: int, height: int, row_bytes: int) -> bytes:
    pix = img.load()
    out = bytearray()
    for y in range(height):
        row = 0
        bits = 0
        for x in range(width):
            row = (row << 1) | (1 if pix[x, y] else 0)
            bits += 1
            if bits == 8:
                out.append(row)
                row = 0
                bits = 0
        if bits:
            row <<= (8 - bits)
            out.append(row)
        # row_bytes already accounted: if width%8==0, bits==0 after loop
        while len(out) % row_bytes:
            out.append(0)
        # The while is per-row only if we track row start:
    # Rebuild cleanly to avoid the while bug
    out = bytearray()
    for y in range(height):
        rowvals = [0] * row_bytes
        for x in range(width):
            if pix[x, y]:
                rowvals[x // 8] |= 0x80 >> (x % 8)
        out.extend(rowvals)
    return bytes(out)


def utf8_map_entry(codepoints: list[int]) -> bytes:
    """PSF2 unicode table entry: UTF-8 sequences terminated by 0xFF."""
    parts = []
    for i, cp in enumerate(codepoints):
        if i:
            parts.append(b"\xfe")
        if 0 < cp <= 0x10FFFF:
            parts.append(chr(cp).encode("utf-8"))
    parts.append(b"\xff")
    return b"".join(parts)


def write_psf2(path: Path, glyphs: list[bytes], umap: list[list[int]],
               width: int, height: int) -> None:
    length = len(glyphs)
    charsize = ((width + 7) // 8) * height
    header = struct.pack(
        "<4sIIIIIII",
        PSF2_MAGIC,
        0,  # version
        32,  # headersize
        PSF2_HAS_UNICODE_TABLE,
        length,
        charsize,
        height,
        width,
    )
    blob = bytearray(header)
    for g in glyphs:
        if len(g) != charsize:
            raise ValueError(f"glyph size {len(g)} != {charsize}")
        blob.extend(g)
    for cps in umap:
        blob.extend(utf8_map_entry(cps))
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(blob)
    print(f"wrote {path} ({len(blob)} bytes, {length} glyphs, {width}x{height})")


def build_latin(noto: Face, width: int = 8, height: int = 16, nglyphs: int = 512) -> None:
    mapping: list[int] = list(range(256))  # U+0000-U+00FF
    for cp in EXTRA_LATIN:
        if cp not in mapping:
            mapping.append(cp)
    if len(mapping) > nglyphs:
        raise SystemExit(f"latin map {len(mapping)} > {nglyphs}")
    while len(mapping) < nglyphs:
        mapping.append(-1)

    glyphs = []
    umap: list[list[int]] = []
    missing = []
    for cp in mapping:
        if cp < 0:
            glyphs.append(rasterize(noto, 0, width, height))
            umap.append([])
            continue
        required = (0x20 <= cp <= 0x7E) or (0xA0 <= cp <= 0xFF and cp != 0xAD) or cp in EXTRA_LATIN
        if required and not noto.has(cp):
            missing.append(hex(cp))
        glyphs.append(rasterize(noto, cp if noto.has(cp) else 0, width, height))
        umap.append([cp] if cp else [])
    if missing:
        raise SystemExit(f"Noto Sans Mono missing required cps: {missing}")
    write_psf2(OUTDIR / "CloudBSD-Latn-8x16.psf", glyphs, umap, width, height)


def build_piqad(qolqos: Face, noto: Face, width: int = 16, height: int = 16,
                nglyphs: int = 512) -> None:
    # 0-255: Latin-1 from Noto (console usability). 256-303: CSUR pIqaD.
    mapping: list[tuple[int, Face]] = []
    for cp in range(256):
        mapping.append((cp, noto))
    for cp in PIQAD_RANGE:
        mapping.append((cp, qolqos))
    while len(mapping) < nglyphs:
        mapping.append((-1, noto))
    if len(mapping) > nglyphs:
        raise SystemExit("piqad map too long")

    glyphs = []
    umap = []
    present = 0
    for cp, face in mapping:
        if cp < 0:
            glyphs.append(rasterize(face, 0, width, height))
            umap.append([])
            continue
        use_face = face if face.has(cp) or cp == 0 else noto
        if cp and use_face.has(cp):
            present += 1
        glyphs.append(rasterize(use_face, cp if use_face.has(cp) else 0, width, height))
        umap.append([cp] if cp else [])
    print(f"piqad: {present} mapped code points with glyphs")
    write_psf2(OUTDIR / "CloudBSD-Piqd-16x16.psf", glyphs, umap, width, height)


def main() -> int:
    if not NOTO_MONO.is_file() or not QOLQOS.is_file():
        print("missing TTF sources", file=sys.stderr)
        return 1
    noto = Face(NOTO_MONO)
    qolqos = Face(QOLQOS)
    build_latin(noto)
    build_piqad(qolqos, noto)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
