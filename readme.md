PowerShell implementation of [Autoenv](https://github.com/kennethreitz/autoenv).

What is it?
===========

If a directory contains a .autoenv file, it will automatically be executed when you cd into it. When enabled
(set $autoenv:ENABLE_LEAVE to $true), if a directory contains a .autoenv.leave file, it will automatically be executed when you leave it.

This is great for...

* auto-activating virtualenvs
* auto-deactivating virtualenvs
* project-specific environment variables


Usage
==========
```
PS> Import-Module ps-autoenv

PS> echo "echo 'whoa'" > project/.autoenv
PS> cd project
whoa
```

Install
==========
```
Install-Module ps-autoenv
Add-Content $PROFILE @("`n", "import-module ps-autoenv")
```

Configuration
============
Update these properties of $autoenv at any time:

* AUTH_FILE: Contains a list of authorized env files, defaults to ~/.autoenv_authorized
* ENV_FILENAME: Name of the .env file, defaults to .autoenv
* ENV_LEAVE_FILENAME: Name of the .env.leave file, defaults to .autoenv.leave
* ENABLE_LEAVE: Set this to a non-falsy value in order to enable leave scripts
* ASSUME_YES: Set this variable to automatically authorize the initialization of new environments