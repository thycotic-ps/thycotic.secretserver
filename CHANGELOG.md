# 0.xx.0

* Add alias for Invoke-RestApi: `itra`

# 0.19.0

* Update `about_tsssecret`
* `Get-TssSecret` add example for using `GetCredential()` method
* `Get-TssSecret` add alias `gts`
* `New-TssSession` add alias `nts`
* `Set-TssSession` restructure use of function
    * Removed `Property` parameter
    * Added params to set Email settings on a secret
* `Get-TssVersion` added
* `Get-TssFolder` added

# 0.18.0

* `Get-TssSession` updated to use `TssSecret` class
* `Get-TssSession` added `GetCredential()` method
* `Set-TssSession` add `Clear` param to clear field values

# 0.17.0

* `Invoke-TssRestApi` - parse response for code/message API error object
* Functions - adjust error handling on endpoint calls
* `Get-TssSession` - add integration test, set OutputType

# 0.16.0

* `Set-TssSession `- Correct WhatIf output

# 0.15.0

* `TssSession`
    * Updated properties
    * Added two new methods: `SessionRefresh()` and `SessionExpire()`
    * Added help on class: `Get-Help about_tsssession`

# 0.14.0

* Standardized error handling on endpoint call
* Minor adjusted types and formats
* Add test for `Get-TssSecretTemplate`
* Added test run to build process

# 0.13.0

* Removed `Get-TssSession`
* `Find-TssSecret` renamed to `Search-TssSecret`
* Added `TssSession` class
* New `TssSession` parameter added to all public functions
* Added unit test
* Added format and types file
* `Get-TssSecret` - Modified output
* `Search-TssSecret` - Added `IncludeInactive` parameter

# 0.12.0

* `New-TssSession` - add comment-based help
* `Get-TssSession` - add comment-based help
* `TestTssSession` - update throw message

# 0.11.0

* Rename `TssSession` object property `AuthToken` to `AccessToken`
* Created build script

# 0.10.0

* `Find-TssSecret` fix bug on restricted

# 0.9.0

* `Find-TssSecret` set to include restricted

# 0.8.0

* Added `Get-TssSecretTemplate`

# 0.7.0

* Added `Set-TssSecret`
* `Get-TssSecret` - format doc example, rework workflow, error handling, add Comment support
* Added TSL1.2 setting for Secret Server Cloud
* `Disable-TssSecret` add status property
* `Find-TssSecret` format output

# 0.6.0

* Rename `Remove-TssSecret` to `Disable-TssSecret`
* Added alias `Remove-TssSecret`

# 0.5.0

* Added `Remove-TssSecret`

# 0.4.0

* Added `Find-TssSecret`

# 0.3.0

* Enhancement to `New-TssSession` (parameter and session validating)

# 0.2.0

* Added `Invoke-TssRestApi`
* Added `New-TssSession`

# 0.1.0

Initial Commit
