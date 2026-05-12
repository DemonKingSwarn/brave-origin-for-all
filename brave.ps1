# =============================================================================
# PowerShell Script: Apply Brave Browser Privacy / Debloat Policies (Windows)
# =============================================================================
# This script sets managed policies via the Windows Registry.
# Run as Administrator.
# After running, restart Brave (or reboot) for changes to take effect.
# Check brave://policy to verify.
# =============================================================================

$PolicyPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"

# Create the policy path if it doesn't exist
if (-not (Test-Path $PolicyPath)) {
    New-Item -Path $PolicyPath -Force | Out-Null
    Write-Host "Created policy registry path." -ForegroundColor Green
}

# Helper function to set DWORD (for booleans/numbers)
function Set-BravePolicyDWord {
    param([string]$Name, [int]$Value)
    Set-ItemProperty -Path $PolicyPath -Name $Name -Value $Value -Type DWord -Force
    Write-Host "Set $Name = $Value" -ForegroundColor Cyan
}

# Helper function to set String
function Set-BravePolicyString {
    param([string]$Name, [string]$Value)
    Set-ItemProperty -Path $PolicyPath -Name $Name -Value $Value -Type String -Force
    Write-Host "Set $Name = $Value" -ForegroundColor Cyan
}

Write-Host "Applying Brave policies..." -ForegroundColor Yellow

# === Feature Disables ===
Set-BravePolicyDWord "BraveRewardsDisabled" 1
Set-BravePolicyDWord "BraveWalletDisabled" 1
Set-BravePolicyDWord "BraveVPNDisabled" 1
Set-BravePolicyDWord "BraveAIChatEnabled" 0
Set-BravePolicyDWord "BraveTalkDisabled" 1
Set-BravePolicyDWord "BraveNewsDisabled" 1
Set-BravePolicyDWord "BravePlaylistEnabled" 0
Set-BravePolicyDWord "BraveWaybackMachineEnabled" 0
Set-BravePolicyDWord "BraveSpeedreaderEnabled" 0

# === Telemetry / Reporting ===
Set-BravePolicyDWord "BraveP3AEnabled" 0
Set-BravePolicyDWord "BraveStatsPingEnabled" 0
Set-BravePolicyDWord "BraveWebDiscoveryEnabled" 0
Set-BravePolicyDWord "MetricsReportingEnabled" 0

# === Passwords & Autofill ===
Set-BravePolicyDWord "PasswordManagerEnabled" 0
Set-BravePolicyDWord "PasswordManagerPasskeysEnabled" 0
Set-BravePolicyDWord "PasswordLeakDetectionEnabled" 0
Set-BravePolicyDWord "AutofillAddressEnabled" 0
Set-BravePolicyDWord "AutofillCreditCardEnabled" 0
Set-BravePolicyDWord "PaymentMethodQueryEnabled" 0

# === Casting / Media Router ===
Set-BravePolicyDWord "EnableMediaRouter" 0
Set-BravePolicyDWord "ShowCastIconInToolbar" 0
Set-BravePolicyDWord "ShowCastSessionsStartedByOtherDevices" 0

# === Shields & Privacy Defaults ===
Set-BravePolicyDWord "DefaultBraveAdblockSetting" 2          # Aggressive = 2
Set-BravePolicyDWord "DefaultBraveHttpsUpgradeSetting" 2
Set-BravePolicyString "HttpsOnlyMode" "force_enabled"
Set-BravePolicyDWord "DefaultBraveFingerprintingV2Setting" 3 # Strict = 3
Set-BravePolicyDWord "DefaultCookiesSetting" 4               # Block 3rd-party + trackers
Set-BravePolicyDWord "DefaultBraveRemember1PStorageSetting" 2

# === DNS over HTTPS ===
Set-BravePolicyString "DnsOverHttpsMode" "secure"
Set-BravePolicyString "DnsOverHttpsTemplates" "https://base.dns.mullvad.net/dns-query"

# === Other ===
Set-BravePolicyDWord "TorDisabled" 1
Set-BravePolicyDWord "DefaultJavaScriptJitSetting" 2

Write-Host "`nAll policies applied successfully!" -ForegroundColor Green
Write-Host "Restart Brave browser (fully close it) for changes to take effect." -ForegroundColor Yellow
Write-Host "Verify at brave://policy" -ForegroundColor Yellow
