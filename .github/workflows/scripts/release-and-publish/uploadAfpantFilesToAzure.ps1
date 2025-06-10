New-Item -Path "./" -Name "actions-tmp" -ItemType "Directory" | Out-Null
New-Item -Path "./actions-tmp" -Name "xslt" -ItemType "Directory" | Out-Null
New-Item -Path "./actions-tmp" -Name "xsd" -ItemType "Directory" | Out-Null
New-Item -Path "./actions-tmp" -Name "xml" -ItemType "Directory" | Out-Null
Get-ChildItem -Path 'spesifikasjoner/afpant/' -Recurse -Include *.xslt | ForEach-Object -Process { Copy-Item $_.VersionInfo.FileName ./actions-tmp/xslt/ }
Get-ChildItem -Path 'spesifikasjoner/afpant/' -Recurse -Include *.xsd | ForEach-Object -Process { Copy-Item $_.VersionInfo.FileName ./actions-tmp/xsd }
Get-ChildItem -Path 'spesifikasjoner/afpant/' -Recurse -Include *.xml | ForEach-Object -Process { Copy-Item $_.VersionInfo.FileName ./actions-tmp/xml }
Get-ChildItem -Path 'actions-tmp' -Recurse -Include "*.*" | ForEach-Object -Process { Write-Output "::notice::Uploading file: $($_.Name.Substring($_.Name.lastIndexOf('/') + 1))" }