Set-StrictMode -Version latest

$script:currentDir = $pwd
$script:currentEnvDir = $null

$global:autoenv = New-Object PSObject -Property ([ordered]@{
  AUTH_FILE = '~/.autoenv_authorized'
  ENV_FILENAME = '.autoenv'
  ENV_LEAVE_FILENAME = '.autoenv.leave'
  ENABLE_LEAVE = $true
  ASSUME_YES = $false
})

function AuthorizeFile($filePath) {
  if (-not (Test-Path $autoenv.AUTH_FILE)) {
    New-Item $autoenv.AUTH_FILE
  }

  if ((Get-Content $autoenv.AUTH_FILE) -contains $filePath) {
    return $true
  }

  Write-Warning 'PS-AutoEnv wants to authorize the following script:'
  Write-Host ('=' * 60) -ForegroundColor Red
  Get-Content $filePath | Write-Host -ForegroundColor Green
  Write-Host ('=' * 60) -ForegroundColor Red

  if ($autoenv.ASSUME_YES -eq $true) {
    Write-Host "$([char]0x2713) Auto authorized `n" -ForegroundColor DarkYellow
    $filePath >> $autoenv.AUTH_FILE
    return $true
  }

  switch (Read-Host "Authorize file ($filePath) ( y / n )") {
    "y" {
      $filePath >> $autoenv.AUTH_FILE
      return $true
    }
    Default {
      return $false
    }
  }
}

function RunScript($scriptFile) {
  if (AuthorizeFile $scriptFile.FullName) {
    Write-Verbose "Running script: $scriptFile"

    #Set $PSScriptRoot for convenience
    $block = "param (`$PSScriptRoot)`n" + (Get-Content $scriptFile.FullName -Raw)
    $output = Invoke-Command `
      -ScriptBlock ([scriptblock]::Create(($block))) `
      -ArgumentList $scriptFile.DirectoryName
    Write-Host $output
  }
}

function LeaveDirectory($dir) {
  Write-Verbose "Leaving directory: $dir"
  if (
    $autoenv.ENABLE_LEAVE -and (
    $leaveFile = Get-ChildItem $dir $autoenv.ENV_LEAVE_FILENAME)) {
    RunScript $leaveFile
    $script:currentEnvDir = $null
  }
}

function EnterDirectory($dir) {
  Write-Verbose "Entered directory: $dir"
  if ($enterFile = Get-ChildItem $dir $autoenv.ENV_FILENAME) {
    RunScript $enterFile
    $script:currentEnvDir = $dir
  }
}

function AutoEnv($newDir) {
  try {
    if ($newDir -eq $currentDir) {
      return
    }

    LeaveDirectory $currentDir
    EnterDirectory $newDir

    $script:currentDir = $newDir
  }
  catch {
    Write-Warning $_.Exception.Message
  }
}

$validateAttr = (new-object ValidateScript { AutoEnv $_; return $true })

(Get-Variable PWD).Attributes.Add($validateAttr)

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
  $null = (Get-Variable pwd).attributes.Remove($validateAttr)
  $global:autoenv = $null
}

Export-ModuleMember -Variable $autoenv
