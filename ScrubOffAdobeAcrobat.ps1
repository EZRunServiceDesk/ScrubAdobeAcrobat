# x86 Adobe Reader
$Reader32PS = "True"
# x64 Adobe Reader
$Reader64PS = "True"
# x86 Adobe Acrobat
$Acrobat32PS = "True"
# x64 Adobe Acrobat
$Acrobat64PS = "True"

if($Reader32PS -ieq "True") {
	Write-Output "Trying to uninstall 32bit Reader" 
	cd c:\temp\
	Invoke-WebRequest -Uri "https://github.com/ServiceDeskCSI/AdobeRemovalTools/releases/download/AdobeAcroCleaner_DC2015/AdobeAcroCleaner_DC2015.exe" -OutFile c:\temp\AdobeAcroCleaner_DC2015.exe
	Start-Sleep -Seconds 1.5
	cmd /c "AdobeAcroCleaner_DC2015.exe /product=1 /silent"
}
if($Acrobat32PS -ieq "True") {
	Write-Output "Trying to uninstall 32bit Acrobat" 
	cd c:\temp\
	Invoke-WebRequest -Uri "https://github.com/ServiceDeskCSI/AdobeRemovalTools/releases/download/AdobeAcroCleaner_DC2015/AdobeAcroCleaner_DC2015.exe" -OutFile c:\temp\AdobeAcroCleaner_DC2015.exe
	Start-Sleep -Seconds 1.5
	cmd /c "AdobeAcroCleaner_DC2015.exe /product=0 /silent"
}

if($Reader64PS -ieq "True") {
	Write-Output "Trying to uninstall 64bit Reader" 
	cd c:\temp\
	Invoke-WebRequest -Uri "https://github.com/ServiceDeskCSI/AdobeRemovalTools/releases/download/AdobeAcroCleaner_DC2021/AdobeAcroCleaner_DC2021.exe" -OutFile c:\temp\AdobeAcroCleaner_DC2021.exe
	Start-Sleep -Seconds 1.5
	cmd /c "AdobeAcroCleaner_DC2021.exe /product=1 /silent"
}

if($Acrobat64PS -ieq "True") {
	Write-Output "Trying to uninstall 64bit Acrobat" 
	cd c:\temp\
	Invoke-WebRequest -Uri "https://github.com/ServiceDeskCSI/AdobeRemovalTools/releases/download/AdobeAcroCleaner_DC2021/AdobeAcroCleaner_DC2021.exe" -OutFile c:\temp\AdobeAcroCleaner_DC2021.exe
	Start-Sleep -Seconds 1.5
	cmd /c "AdobeAcroCleaner_DC2021.exe /product=0 /silent"
}
