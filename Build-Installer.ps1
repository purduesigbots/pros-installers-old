$ai = "C:\Program Files (x86)\Caphyon\Advanced Installer 13.5\bin\x86\AdvancedInstaller.com"
$root = ".\windows"
$project = "$root\PROS.aip"

$edit = "/edit", $project
function ai {
    Write-Output ($args -join ' ')
    & $ai $args
}

New-Item -Path .\output -ItemType Directory -Force
New-Item -Path .\output\windows-web -ItemType Directory -Force
New-Item -Path .\output\windows-exe -ItemType Directory -Force



ai @edit /SetOutputLocation -buildname WebInstaller -path (Resolve-Path -Path .\output\windows-web).Path
ai @edit /SetOutputLocation -buildname ExeBuild -path (Resolve-Path -Path .\output\windows-exe).Path

ai /build $project