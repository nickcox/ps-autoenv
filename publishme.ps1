Copy-Item $PSScriptRoot/readme.md src/about_PS-Autoenv.help.txt
Publish-Module -Path $PSScriptRoot/src -NuGetApiKey $env:PSNugetKey -Verbose