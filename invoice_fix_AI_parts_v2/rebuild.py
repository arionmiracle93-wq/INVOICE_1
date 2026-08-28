from pathlib import Path
import hashlib

ROOT = Path(__file__).resolve().parent
parts = sorted(ROOT.glob("[0-9][0-9]-*.html"))
if not parts:
    raise SystemExit("No numbered HTML parts found.")

out = ROOT / "invoice_fix_rebuilt.html"
with out.open("wb") as dst:
    for part in parts:
        dst.write(part.read_bytes())

digest = hashlib.sha256(out.read_bytes()).hexdigest()
print(f"Created: {out.name}")
print(f"Bytes:   {out.stat().st_size}")
print(f"SHA256:  {digest}")
