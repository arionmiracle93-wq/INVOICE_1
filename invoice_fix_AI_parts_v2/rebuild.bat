@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -Command "$files = Get-ChildItem -File -Filter '*.html' | Where-Object { $_.Name -match '^\d{2}-' } | Sort-Object Name; $out = [IO.File]::Create('invoice_fix_rebuilt.html'); try { foreach($f in $files) { $b=[IO.File]::ReadAllBytes($f.FullName); $out.Write($b,0,$b.Length) } } finally { $out.Close() }"
if errorlevel 1 (
  echo Rebuild failed.
  exit /b 1
)
echo Created invoice_fix_rebuilt.html
certutil -hashfile invoice_fix_rebuilt.html SHA256
echo.
pause
