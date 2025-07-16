# Variables
$CertCN = "Blue Tech Code Signing"
$Timestamp = "http://timestamp.digicert.com"
$RootDir = Split-Path (Get-Location) -Parent
$FilePath = Join-Path $RootDir "releases\winfix.ps1"
$SignPath = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe"

# Initial message
Write-Host "Started process!" -ForegroundColor Cyan

# Digitally sign file
Write-Host ""
& $SignPath sign /td sha256 /tr $Timestamp /fd sha256 /n $CertCN $FilePath

# Checking if file was signed
$Signature = Get-AuthenticodeSignature -FilePath $FilePath
$FileStatus = $Signature.Status

# Verificar si la firma es válida
if ($FileStatus -eq "Valid") {
    Write-Host ""
    Write-Host "The script was digitally sign!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "The script could not be digitally sign!" -ForegroundColor Red
    Write-Host "Please check the certificate. The status was: $FileStatus"
    Write-Host ""
}
