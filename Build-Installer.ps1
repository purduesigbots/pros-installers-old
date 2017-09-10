$ai = "C:\Program Files (x86)\Caphyon\Advanced Installer 13.5\bin\x86\AdvancedInstaller.com"
$root = ".\windows"
function ai {
    Write-Output ($args -join ' ')
    & $ai $args
}

ai /build "$root\PROS.aip"