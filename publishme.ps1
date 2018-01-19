Copy-Item $PSScriptRoot/readme.md $PSScriptRoot/ps-autoenv/about_PS-Autoenv.help.txt
Publish-Module -Path $PSScriptRoot/ps-autoenv -NuGetApiKey $env:PSNugetKey -Verbose