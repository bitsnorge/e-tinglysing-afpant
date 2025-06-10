$CommitMessage = ""
# /////////// Determine commit message \\\\\\\\\\\\\\\\\\\\\\\
if ( ($null -ne $Env:prPath) -and ($null -ne $Env:mergeCommitMessage) ) { #If booth methoods are present somthing is wrong
  Write-Output "::error title=Script-Error::Both the 'prPath' and 'mergeCommitMessage' environment variables are used, this is wrong, check the pipeline workflow"
} elseif ($null -ne $Env:prPath) { #If we have a Pull-Request Path that means that this was triggered by a pull-request, we need to find the last commit in the Pull-Request
  #Find pull-request URL:
  $mergeLessPRPath = $Env:prPath.Substring(0, $Env:prPath.indexOf("/merge")) #Trim off "/merge"
  $PullRequestUrl = "$Env:gitHubHost/$Env:repoPath/$($mergeLessPRPath.Substring($mergeLessPRPath.indexOf("pull/")))" #Combine to URL, remove "/refs" i.e only include "pull/<nr>"

  $CommitMessage = gh pr view $PullRequestUrl --json commits | ConvertFrom-Json | Select-Object -Expand commits | ForEach-Object { $_.messageHeadline } | Select-Object -Last 1

  if ($CommitMessage -match '^Merge.*') { #If a merge conflict was solved the commit message might not follow the standard, jumping one up
    Write-Output "::notify::The last commit on the pull request: $PullRequestUrl contained 'Merge' on the last commit message, this might be due to a merge-conflict resolution, checking previous to last commit message"
    $CommitMessage = gh pr view $PullRequestUrl --json commits | ConvertFrom-Json | Select-Object -Expand commits | ForEach-Object { $_.messageHeadline } | Select-Object -Last 2 | Select-Object -First 1
  }
} elseif ($null -ne $Env:mergeCommitMessage) { #If this is not null, then the commit message was a merge commit message, we need to find the final commit message of the merge branch
  if ( $Env:mergeCommitMessage -notmatch '^(Merge pull request #)[0-9]( from ).*') {
    Write-Output "::error title=Script-Error::The script has encountered an error while attempting to find the release type. The script got the commit message as input, which means that this was called as part of a push to the master branch, but the commit message did not follow the regex pattern for a merge commit, this means that somone pushed straight to master. Naughty Naughty! The commit message was: $Env:mergeCommitMessage"
    exit 1
  } else { #Find the last Pull-Request commit message using the PR number from the commit message of the merge commit message
    $NoAfterNumber = $Env:mergeCommitMessage.Substring(0, $Env:mergeCommitMessage.indexOf("from"))
    [Int]$PullRequestNumber = $NoAfterNumber.Substring($NoAfterNumber.indexOf("#") + 1)
    $PullRequestUrl = "$Env:gitHubHost/$Env:repoPath/pull/$PullRequestNumber"

    $CommitMessage = gh pr view $PullRequestUrl --json commits | ConvertFrom-Json | Select-Object -Expand commits | ForEach-Object { $_.messageHeadline } | Select-Object -Last 1

    if ($CommitMessage -match '^Merge.*') { #If a merge conflict was solved the commit message might not follow the standard, jumping one up
      Write-Output "::notify::The last commit on the pull request: $PullRequestUrl contained 'Merge' on the last commit message, this might be due to a merge-conflict resolution, checking previous to last commit message"
      $CommitMessage = gh pr view $PullRequestUrl --json commits | ConvertFrom-Json | Select-Object -Expand commits | ForEach-Object { $_.messageHeadline } | Select-Object -Last 2 | Select-Object -First 1
    }
  }
} else {
  Write-Output "::error title=Script-Error::Either the 'prPath' and 'mergeCommitMessage' environment variables must be included, found none."
}

#///////////////// Determine release type based on commit message. \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
if ( $CommitMessage -match '^doc:(\s|\S)*$') {
  $releaseType = 'doc'
} elseif ( $CommitMessage -match '^fix:(\s|\S)*$' ) {
  $releaseType = 'fix'
} elseif ( $CommitMessage -match '^feat:(\s|\S)*$' ) {
  $releaseType = 'feat'
} elseif ( $CommitMessage -match '^feat!:(\s|\S)*$' ) {
  $releaseType = 'breaking'
} else {
  Write-Output "::error title=Naming-Convention-Error::The commit message did not follow the agreed upon naming convention, the name of the lates commit was: $CommitMessage"
  exit 1
}

Write-Output "::notice::The merge was determined to be a $releaseType change"

Add-Content -Value "releaseType=$releaseType" -Path $Env:GITHUB_OUTPUT -Encoding utf8
Add-Content -Value "commitMessage=$CommitMessage" -Path $Env:GITHUB_OUTPUT -Encoding utf8