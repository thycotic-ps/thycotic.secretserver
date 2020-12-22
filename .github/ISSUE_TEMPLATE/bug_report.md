---
name: Bug report
about: Create a report to help us improve
title: ''
labels: bug
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. PowerShell script:

```powershell
copy/paste code
```

1. Error/issue observed:

```powershell
# copy paste $error | select *
```

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment (please complete the following information):**

```powershell
<!-- paste output of $PSVersionTable -->
```

***Host information:***

[ ] Powershell.exe
[ ] pwsh.exe
[ ] PowerShell ISE
[ ] VS Code (Insiders/Stable)

<!--
VS Code, please provide output of the following:

& {"### VSCode version: $(code -v)"; "`n### VSCode extensions:`n$(code --list-extensions --show-versions | Out-String)"; "`n### PSES version: $($pseditor.EditorServicesVersion)"; "`n### PowerShell version:`n$($PSVersionTable | Out-String)"}

If you are using VS Code Insiders Edition:

& {"### VSCode version: $(code-insiders -v)"; "`n### VSCode extensions:`n$(code-insiders --list-extensions --show-versions | Out-String)"; "`n### PSES version: $($pseditor.EditorServicesVersion)"; "`n### PowerShell version:`n$($PSVersionTable | Out-String)"}
-->

**Additional context**
Add any other context about the problem here.
