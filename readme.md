PowerShell implementation of [autoenv](https://github.com/kennethreitz/autoenv) directory based environments.

What is it?
===========

If a directory contains a .autoenv file, it will automatically be executed when you cd into it. When enabled (set `$autoenv:ENABLE_LEAVE` to `$true`), if a directory contains a .autoenv.leave file, it will automatically be executed when you leave it.

This is great for...

* auto-activating virtualenvs
* auto-deactivating virtualenvs
* project-specific environment variables


Usage
==========
```
PS> Import-Module ps-autoenv
PS> "echo 'whoa'" > project/.autoenv
PS> cd project
whoa
```

Install
==========
```
PS> Install-Module ps-autoenv
PS> Add-Content $PROFILE @("`n", "import-module ps-autoenv")
```

Configuration
============
Update these properties of `$autoenv` at any time:

* AUTH_FILE: Location of a text file which contains a list of authorized env files;
defaults to ~/.autoenv_authorized
* ENV_FILENAME: Name of the enter file; defaults to .autoenv
* ENV_LEAVE_FILENAME: Name of the leave file; defaults to .autoenv.leave
* ENABLE_LEAVE: Set this to a non-falsy value in order to enable leave scripts
* ASSUME_YES: Set this to $true to automatically authorize the initialization of new environments