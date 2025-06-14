# Set Save Path
$PathSave = "C:\Temp"
if (-Not (Test-Path -Path $PathSave)) {
    New-Item -Path $PathSave -ItemType Directory -Force | Out-Null
}

# Cleaner flags (set to $true or $false as needed)
$Reader32PS  = $false
$Reader64PS  = $false
$Acrobat32PS = $false
$Acrobat64PS = $true

# Cleaner download URLs
$Cleaner2015ZipUrl = "https://www.adobe.com/devnet-docs/acrobatetk/tools/Labs/AcroCleaner_DC2015.zip"
$Cleaner2021ExeUrl = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2100120135/x64/AdobeAcroCleaner_DC2021.exe"

# Reusable download function
function Download-File {
    param (
        [string]$Url,
        [string]$Destination
    )
    Write-Output "Downloading: $Url"
    Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing
}

# Run 2015 cleaner (for 32-bit products)
function Run-2015Cleaner {
    param (
        [int]$ProductID  # 0 = Acrobat, 1 = Reader
    )
    $zipPath = Join-Path $PathSave "AcroCleaner_DC2015.zip"
    $exePath = Join-Path $PathSave "AdobeAcroCleaner_DC2015.exe"

    Download-File -Url $Cleaner2015ZipUrl -Destination $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $PathSave -Force
    Start-Sleep -Seconds 2
    cmd /c "`"$exePath`" /product=$ProductID /silent"
}

# Run 2021 cleaner (for 64-bit products)
function Run-2021Cleaner {
    param (
        [int]$ProductID  # 0 = Acrobat, 1 = Reader
    )
    $exePath = Join-Path $PathSave "AdobeAcroCleaner_DC2021.exe"
    if (-Not (Test-Path $exePath)) {
        Download-File -Url $Cleaner2021ExeUrl -Destination $exePath
    }
    Start-Sleep -Seconds 1
    cmd /c "`"$exePath`" /product=$ProductID /silent"
}

# Execute based on flags
if ($Reader32PS) {
    Write-Output "Uninstalling 32-bit Adobe Reader..."
    Run-2015Cleaner -ProductID 1
}
if ($Acrobat32PS) {
    Write-Output "Uninstalling 32-bit Adobe Acrobat..."
    Run-2015Cleaner -ProductID 0
}
if ($Reader64PS) {
    Write-Output "Uninstalling 64-bit Adobe Reader..."
    Run-2021Cleaner -ProductID 1
}
if ($Acrobat64PS) {
    Write-Output "Uninstalling 64-bit Adobe Acrobat..."
    Run-2021Cleaner -ProductID 0
}

# Cleanup
Write-Output "Cleaning up..."
$filesToRemove = @(
    "AcroCleaner_DC2015.zip",
    "AdobeAcroCleaner_DC2015.exe",
    "AdobeAcroCleaner_DC2021.exe"
)
foreach ($file in $filesToRemove) {
    $filePath = Join-Path $PathSave $file
    if (Test-Path $filePath) {
        Remove-Item -Path $filePath -Force -ErrorAction SilentlyContinue
    }
}

# Optionally remove leftover folders from unzipping
Get-ChildItem -Path $PathSave -Directory | Where-Object { $_.Name -like "*AcroCleaner*" } | ForEach-Object {
    Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Output "Cleanup complete."
