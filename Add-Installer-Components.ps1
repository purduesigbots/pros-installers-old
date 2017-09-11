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

$win_ver = (Get-Content .\win_version -Raw).Trim()
Write-Output "Setting version to $win_ver"
ai @edit /SetVersion $win_ver
ai @edit /SetProductCode -langid 1033

ai @edit /SetCurrentFeature CLI32
ai @edit /AddFolder "APPDIR\cli" $cli32 -install_in_parent_folder
ai @edit /NewEnvironment -name PATH -value "[cli_Dir]" -install_operation CreateUpdate -system_variable

ai @edit /SetCurrentFeature CLI64
ai @edit /AddFolder "APPDIR\cli" $cli64 -install_in_parent_folder
ai @edit /NewEnvironment -name PATH -value "[cli_Dir]" -install_operation CreateUpdate -system_variable

ai @edit /SetCurrentFeature Editor32
ai @edit /AddFolder "APPDIR\editor" $editor32 -install_in_parent_folder
ai @edit /AddFileAssociation "[|ProductName]" -ext pros -cmd "APPDIR\editor\PROS Editor\pros-editor.exe" -verbarg """%1\\.."""

ai @edit /SetCurrentFeature Editor64
ai @edit /AddFolder "AppDir\editor" $editor64 -install_in_parent_folder
ai @edit /AddFileAssociation "[|ProductName]" -ext pros -cmd "APPDIR\editor\PROS Editor x64\pros-editor.exe" -verbarg """%1\\.."""