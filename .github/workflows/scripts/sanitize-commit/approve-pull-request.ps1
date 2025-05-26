#Find PR URL
$mergeLessPRPath = $Env:prPath.Substring(0, $Env:prPath.indexOf("/merge")) #Trim off "/merge"
$PullRequestUrl = "$Env:gitHubHost/$Env:repoPath/$($mergeLessPRPath.Substring($mergeLessPRPath.indexOf("pull/")))" #Combine to URL, remove "/refs" i.e only include "pull/<nr>"

switch ($Env:releaseType) {
  doc {
    Write-Output "::notice::The latest commit indicates a documentation change. Merging this pull-request will not alter the version number."
    gh pr comment $PullRequestUrl --body "The naming is confirmed. The latest commit indicates a documentation change. Merging this pull-request will not alter the version number."
    exit 0
  } fix {
    Write-Output "::notice::The latest commit: $Env:commitMessage indicates a fix change. Merging this pull-request will increase the minor (0.0.x) version number."
    gh pr comment $PullRequestUrl --body "The naming is confirmed. The latest commit: '$Env:commitMessage' indicates a fix change. Merging this pull-request will increase the minor (0.0.x) version number."
    exit 0
  } feat {
    Write-Output "::notice::The latest commit: $Env:commitMessage indicates a non-breaking feature change. Merging this pull-request will increase the middle (0.x.0) version number."
    gh pr comment $PullRequestUrl --body "The naming is confirmed. The latest commit: '$Env:commitMessage' indicates a non-breaking feature change. Merging this pull-request will increase the middle (0.x.0) version number."
    exit 0
  } breaking {
    Write-Output "::notice::The latest commit: $Env:commitMessage indicates a breaking feature change. Merging this pull-request will increase the major (x.0.0) version number."
    gh pr comment $PullRequestUrl --body "The naming is confirmed. The latest commit: '$Env:commitMessage' indicates a breaking feature change. Merging this pull-request will increase the major (x.0.0) version number."
    exit 0
  }
}