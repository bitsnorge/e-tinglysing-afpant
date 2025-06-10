$RepositoryHost = $Env:RepositoryHost.Substring($Env:RepositoryHost.indexOf("/") + 1)
$RepositoryURI = "$Env:RepositoryHost/$Env:RepositoryURI"
$CurrentRelease = gh release view --repo $RepositoryURI --json name,tagName,createdAt,body | ConvertFrom-Json

Write-Output "::notice::Latest release in this repository was a release with name: $($CurrentRelease.name), tag version: $($CurrentRelease.tagName)"

$MajorVersionNumber = [int]$CurrentRelease.tagName.split(".")[0]
$NormalVersionNumber = [int]$CurrentRelease.tagName.split(".")[1]
$MinorVersionNumber = [int]$CurrentRelease.tagName.split(".")[2]

$NewMinorVersionNumber = $MinorVersionNumber
$NewNormalVersionNumber = $NormalVersionNumber
$NewMajorVersionNumber = $MajorVersionNumber

switch ($Env:ReleaseType) {
  fix {
    $NewMinorVersionNumber = $MinorVersionNumber + 1
    Write-Output "::notice::Increasing minor version number from: $MinorVersionNumber to $NewMinorVersionNumber"
  }
  feat {
    $NewNormalVersionNumber = $NormalVersionNumber + 1
    $NewMinorVersionNumber = 0
    Write-Output "::notice::Increasing middle version number from: $NormalVersionNumber to $NewNormalVersionNumber"
    Write-Output "::notice::Resetting minor version number from: $MinorVersionNumber to $NewMinorVersionNumber"
  }
  breaking {
    $NewMajorVersionNumber = $MajorVersionNumber + 1
    $NewNormalVersionNumber = 0
    $NewMinorVersionNumber = 0
    Write-Output "::notice::Increasing major version number from: $MajorVersionNumber to $NewMajorVersionNumber"
    Write-Output "::notice::Resetting middle version number from: $NormalVersionNumber to $NewNormalVersionNumber"
    Write-Output "::notice::Resetting minor version number from: $MinorVersionNumber to $NewMinorVersionNumber"
  }
}

$NewTagVersion = "$NewMajorVersionNumber.$NewNormalVersionNumber.$NewMinorVersionNumber"

Write-Output "::notice::New version is: $NewTagVersion"

Add-Content -Value "newVersionNumber=$NewTagVersion" -Path $Env:GITHUB_OUTPUT -Encoding utf8