#!/usr/bin/env bats

load helpers

INSTALL_PS1="$REPO_ROOT/install.ps1"
TEST_WORKFLOW="$REPO_ROOT/.github/workflows/test.yml"

@test "Windows installer supports PowerShell 5.1 and forwards all shared options" {
    run grep -F '#Requires -Version 5.1' "$INSTALL_PS1"
    [ "$status" -eq 0 ]

    for option in DryRun Backup NoBackup Yes Rollback; do
        run grep -F "[switch]\$$option" "$INSTALL_PS1"
        [ "$status" -eq 0 ]
    done

    run grep -F "ContainsKey('Verbose')" "$INSTALL_PS1"
    [ "$status" -eq 0 ]
}

@test "Windows dry-run does not install a missing jq dependency" {
    run grep -F 'Install-Jq -InstallIfMissing:(-not $DryRun)' "$INSTALL_PS1"
    [ "$status" -eq 0 ]

    run grep -F 'Dry-run mode will not install it.' "$INSTALL_PS1"
    [ "$status" -eq 0 ]
}

@test "Windows installer uses the checkout when cli.sh is beside it" {
    run grep -F 'Test-Path (Join-Path $PSScriptRoot "cli.sh")' "$INSTALL_PS1"
    [ "$status" -eq 0 ]

    run grep -F '$sourceDir = $PSScriptRoot' "$INSTALL_PS1"
    [ "$status" -eq 0 ]
}

@test "Windows installer preserves the Bash installer exit code" {
    run grep -F '$exitCode = $LASTEXITCODE' "$INSTALL_PS1"
    [ "$status" -eq 0 ]

    run grep -F 'exit $exitCode' "$INSTALL_PS1"
    [ "$status" -eq 0 ]
}

@test "CI parses and dry-runs the installer on native Windows" {
    run grep -F 'runs-on: windows-2022' "$TEST_WORKFLOW"
    [ "$status" -eq 0 ]

    run grep -F 'run: .\install.ps1 -DryRun -Yes' "$TEST_WORKFLOW"
    [ "$status" -eq 0 ]
}
