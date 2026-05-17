#!/usr/bin/env bash

set -xe

POLICIES_DIR="/Library/Managed Preferences"
test -d "$POLICIES_DIR" || mkdir -p "$POLICIES_DIR"

tee "$POLICIES_DIR/com.brave.Browser.plist" > /dev/null <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

    <!-- Brave-specific features -->
    <key>BraveRewardsDisabled</key>
    <true/>
    <key>BraveWalletDisabled</key>
    <true/>
    <key>BraveVPNDisabled</key>
    <true/>
    <key>BraveAIChatEnabled</key>
    <false/>
    <key>BraveTalkDisabled</key>
    <true/>
    <key>BraveNewsDisabled</key>
    <true/>
    <key>BravePlaylistEnabled</key>
    <false/>
    <key>BraveWaybackMachineEnabled</key>
    <false/>
    <key>BraveSpeedreaderEnabled</key>
    <false/>
    <key>BraveP3AEnabled</key>
    <false/>
    <key>BraveStatsPingEnabled</key>
    <false/>
    <key>BraveWebDiscoveryEnabled</key>
    <false/>

    <!-- Chromium/Privacy settings -->
    <key>MetricsReportingEnabled</key>
    <false/>
    <key>PasswordManagerEnabled</key>
    <false/>
    <key>PasswordManagerPasskeysEnabled</key>
    <false/>
    <key>PasswordLeakDetectionEnabled</key>
    <false/>
    <key>AutofillAddressEnabled</key>
    <false/>
    <key>AutofillCreditCardEnabled</key>
    <false/>
    <key>PaymentMethodQueryEnabled</key>
    <false/>
    <key>EnableMediaRouter</key>
    <false/>
    <key>ShowCastIconInToolbar</key>
    <false/>
    <key>ShowCastSessionsStartedByOtherDevices</key>
    <false/>

    <!-- Shields & Security -->
    <key>DefaultBraveAdblockSetting</key>
    <integer>2</integer>
    <key>DefaultBraveHttpsUpgradeSetting</key>
    <integer>2</integer>
    <key>HttpsOnlyMode</key>
    <string>force_enabled</string>
    <key>DefaultBraveFingerprintingV2Setting</key>
    <integer>3</integer>
    <key>DefaultCookiesSetting</key>
    <integer>1</integer>
    <key>BlockThirdPartyCookies</key>
    <true/>
    <key>DefaultBraveRemember1PStorageSetting</key>
    <integer>1</integer>

    <!-- DNS / Network -->
    <key>DnsOverHttpsMode</key>
    <string>secure</string>
    <key>DnsOverHttpsTemplates</key>
    <string>https://base.dns.mullvad.net/dns-query</string>

    <!-- Other -->
    <key>TorDisabled</key>
    <true/>
    <key>DefaultJavaScriptJitSetting</key>
    <integer>2</integer>

</dict>
</plist>
EOF

chown root:wheel "$POLICIES_DIR/com.brave.Browser.plist"
chmod 644 "$POLICIES_DIR/com.brave.Browser.plist"

echo "Policies applied. Restarting Brave..."

echo "Done! Restart Brave."
