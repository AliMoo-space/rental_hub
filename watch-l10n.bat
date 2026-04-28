@echo off
REM Flutter Gen L10n Auto Watch - Windows batch script
REM This script watches the l10n folder and regenerates on any changes

echo Watching l10n folder for changes...
echo Press Ctrl+C to stop

:watch
for /f %%A in ('powershell -Command "(Get-Item lib\l10n\*.arb | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime.Ticks"') do set lastTick=%%A

:loop
timeout /t 1 /nobreak > nul
for /f %%A in ('powershell -Command "(Get-Item lib\l10n\*.arb | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime.Ticks"') do set currentTick=%%A

if not "%lastTick%"=="%currentTick%" (
  echo.
  echo ARB file changed - regenerating localization...
  flutter gen-l10n
  for /f %%A in ('powershell -Command "(Get-Item lib\l10n\*.arb | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime.Ticks"') do set lastTick=%%A
  echo Waiting for changes...
)

goto loop
