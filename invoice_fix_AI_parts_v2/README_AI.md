# invoice_fix.html — AI-Friendly Parts

## Tujuan

`invoice_fix.html` asli berukuran **49,071 bytes** dan terdiri dari **843 baris**. File ini dipecah menjadi **8 part**, masing-masing maksimal **6,500 bytes (~6.5 KB)**.

Struktur asli **tidak diubah**. Part adalah potongan byte dari file asli sehingga bisa digabungkan kembali menjadi `invoice_fix.html` yang identik.

Source SHA-256:

`49006fd605d8bbbd0d7f7563b7ec65ed2c05c64853930e19113214ea3efee6cf`

## Cara membaca untuk AI / GitHub fetching

**Jangan menganggap setiap part sebagai dokumen HTML yang berdiri sendiri.** Part-part ini adalah fragmen berurutan.

Urutan wajib:

1. `01-document-head-and-css-a.html`
2. `02-css-b-and-document-body.html`
3. `03-embedded-logo-a.html`
4. `04-embedded-logo-b.html`
5. `05-body-and-script-start.html`
6. `06-javascript-a.html`
7. `07-javascript-b.html`
8. `08-javascript-end.html`

Untuk memahami fungsi tertentu, AI sebaiknya membaca part berdasarkan area:

| Area | Part | Keterangan |
|---|---|---|
| HTML document + CSS | 01–02 | Struktur awal, CSS, dan awal body |
| Embedded logo | 03–04–05 (awal) | Base64 logo sangat panjang dan sengaja dipertahankan apa adanya |
| Invoice body | 05 | Bill-to, tabel, totals, pembayaran, syarat, action bar |
| JavaScript | 06–08 | Logic aplikasi, event, kalkulasi, keyboard navigation, init |
| Penutup dokumen | 08 | `</script>`, `</body>`, `</html>` |

## Catatan penting tentang logo Base64

HTML asli memiliki satu baris `<img>` yang berisi logo PNG dalam format Base64. Baris ini sangat panjang sehingga tidak mungkin dipertahankan sebagai satu baris jika setiap part harus <= 6,500 bytes.

Karena itu, **part 03, 04, dan awal part 05 merupakan sambungan dari SATU baris Base64 yang sama**.

Jangan:
- menambahkan newline di antara part,
- menghapus karakter,
- melakukan formatting/pretty-print,
- atau menggabungkan part secara manual dengan editor yang mengubah line ending.

Untuk AI, anggap `03 → 04 → 05` sebagai satu sequence kontinu.

## Rebuild

### Windows

Jalankan:

`rebuild.bat`

Script akan menghasilkan:

`invoice_fix_rebuilt.html`

Kemudian SHA-256 hasil rebuild dapat dibandingkan dengan SHA-256 source di atas.

### Python

Jalankan:

`python rebuild.py`

## Verifikasi integritas

`MANIFEST.json` berisi:
- urutan part,
- ukuran byte,
- perkiraan rentang baris sumber,
- SHA-256 setiap part,
- SHA-256 file sumber.

Target hasil gabungan:

`49006fd605d8bbbd0d7f7563b7ec65ed2c05c64853930e19113214ea3efee6cf`

Jika SHA-256 berbeda, berarti ada part yang hilang, berubah, atau urutannya salah.

## Prinsip untuk AI coding agent

Jika AI diminta memperbaiki bagian tertentu:

1. Baca `MANIFEST.json`.
2. Identifikasi area berdasarkan tabel di atas.
3. Fetch part yang relevan.
4. Jika perubahan menyentuh batas antar-part, fetch **kedua part yang bersebelahan**.
5. Untuk perubahan JavaScript, biasanya fetch `06–08`.
6. Untuk perubahan CSS, biasanya fetch `01–02`.
7. Jangan mengubah bagian Base64 logo kecuali memang diminta.
8. Jika perlu menghasilkan HTML utuh, rebuild dengan urutan numerik dan verifikasi SHA-256.

## File sumber

Source asli yang digunakan adalah `invoice_fix.html`. Struktur awalnya adalah HTML5 dengan `<head>`, CSS inline, body invoice, lalu JavaScript inline.

# AI QUICK WORKFLOW

## Before coding

1. Read `AI_INSTRUCTIONS.md`.
2. Read `README_AI.md`.
3. Read `MANIFEST.json`.
4. Identify the relevant part(s).
5. Fetch adjacent parts when code crosses a boundary.

## Important

The numbered HTML files are fragments of one HTML source. They are **not standalone HTML documents**.

A fragment can legally end in the middle of a tag, string, CSS rule, JavaScript function, or Base64 data. Do not "repair" that fragment in isolation.

## Safe edit loop

```text
MAP → FETCH → UNDERSTAND → EDIT → REBUILD → VALIDATE
```

For a small edit:

```text
MAP → FETCH RELEVANT PART → FETCH BOUNDARY CONTEXT IF NEEDED → EDIT
```

For a broad refactor:

```text
READ ALL RELEVANT PARTS → MAP DEPENDENCIES → EDIT → REBUILD → VALIDATE
```

## GitHub / AI fetching recommendation

If an AI agent is working through GitHub, start with:

```text
AI_INSTRUCTIONS.md
README_AI.md
MANIFEST.json
```

Then fetch the smallest relevant numbered part(s).

If the requested code is cut at the end or beginning of a part, fetch the neighboring part before reasoning about syntax or behavior.

## Do not

- Treat each `.html` part as an independent page.
- Reorder parts.
- Re-split the repository without a reason.
- Format or minify all parts for a small change.
- Modify Base64/data URI content casually.
- Add HTML/script/style wrappers to incomplete fragments.
- Assume a filename represents a JavaScript module.

## Rebuild

Use `rebuild.bat` on Windows or `rebuild.py` with Python.

The rebuild order must come from `MANIFEST.json`.

## Change reporting

When possible, report the exact part and logical area changed, for example:

```text
Part: 06-javascript-a.html
Area: updateSomething()
Related: 07-javascript-b.html
```
