@{

  RootModule        = '.\ps-autoenv.psm1'
  ModuleVersion     = '0.5'
  Author            = 'Nick Cox'
  CompanyName       = 'n/a'
  Copyright         = '(c) 2018 Nick Cox. All rights reserved.'
  Description       = 'PowerShell implementation of [autoenv](https://github.com/kennethreitz/autoenv)'
  GUID              = 'fdf88a75-839f-42c8-9b3e-a99bc2d64ed9'
  PowerShellVersion = '3.0'
  VariablesToExport = '$autoenv'
  FunctionsToExport = @()
  CmdletsToExport   = @()
  AliasesToExport   = @()


  PrivateData       = @{

    PSData = @{
      Tags       = @('autoenv', 'productivity')
      LicenseUri = 'https://github.com/nickcox/ps-autoenv/blob/master/LICENSE'
      ProjectUri = 'https://github.com/nickcox/ps-autoenv'
    }
  }
}

