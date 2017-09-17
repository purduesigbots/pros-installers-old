$ai = "C:\Program Files (x86)\Caphyon\Advanced Installer 13.5\bin\x86\AdvancedInstaller.com"
$root = ".\windows"
$editor64 = ".\pros-editor-64-windows\PROS Editor x64"
$editor32 = ".\pros-editor-32-windows\PROS Editor"
$cli64 = ".\pros-cli-64-windows"
$cli32 = ".\pros-cli-32-windows"

$edit = "/edit", "$root\PROS.aip"

function ai {
    Write-Output ($args -join ' ')
    & $ai $args
}

Write-Output "Renaming $editor64 to 64"
Rename-Item $editor64 64
$editor64 = "$editor64\..\64"

Write-Output "Renaming $editor32 to 32"
Rename-Item $editor32 32
$editor32 = "$editor32\..\32"

$win_ver = (Get-Content .\win_version -Raw).Trim()
ai @edit /SetVersion $win_ver

ai @edit /SetCurrentFeature CLI32
ai @edit /AddFolder "APPDIR\cli" $cli32 -install_in_parent_folder

ai @edit /SetCurrentFeature CLI64
ai @edit /AddFolder "APPDIR\cli" $cli64 -install_in_parent_folder

ai @edit /SetCurrentFeature Editor32
ai @edit /AddFolder "APPDIR\editor" $editor32 -install_in_parent_folder
ai @edit /AddFileAssociation "PROS.Editor32.pros" -ext pros -cmd "APPDIR\editor\32\pros-editor.exe" -verbarg """%1\\.."""
ai @edit /NewShortcut -name "PROS Editor" -dir SHORTCUTDIR -target "APPDIR\editor\32\pros-editor.exe"

ai @edit /SetCurrentFeature Editor64
ai @edit /AddFolder "AppDir\editor" $editor64 -install_in_parent_folder
ai @edit /AddFileAssociation "PROS.Editor64.pros" -ext pros -cmd "APPDIR\editor\64\pros-editor.exe" -verbarg """%1\\.."""
ai @edit /NewShortcut -name "PROS Editor x64" -dir SHORTCUTDIR -target "APPDIR\editor\64\pros-editor.exe"