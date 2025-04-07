# The original idea (and a couple settings) were grabbed from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://macos-defaults.com/
# https://developer.apple.com/documentation/devicemanagement/dock
# https://mynixos.com/nix-darwin/options/system.defaults


# Dock
# Icons size of 36 pixels.
defaults write com.apple.dock "tilesize" -int "36"
# Display recent apps
defaults write com.apple.dock "show-recents" -bool "false"
# Put the Dock on the left of the screen
defaults write com.apple.dock "orientation" -string "left"
# Enable Maginification
defaults write com.apple.dock "magnification" -bool "true"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Start screen saver
defaults write com.apple.dock wvous-tl-corner -int "5"
defaults write com.apple.dock wvous-tl-modifier -int "0"
# Bottom left screen corner → Desktop
defaults write com.apple.dock wvous-bl-corner -int "0"
defaults write com.apple.dock wvous-bl-modifier -int "0"


# Finder
# Always open everything in Finder's column view. This is important
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true"
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "true"
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "true"
# Keep folders on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
# Show pathbar with path
defaults write com.apple.finder "ShowPathbar" -bool "true"
# Set default path for new windows
defaults write com.apple.finder "NewWindowTarget" -string "PfHm"
# Hide tags in sidebar
defaults write com.apple.finder ShowRecentTags -bool "false"


# Enable AirDrop over Ethernet and on unsupported Macs running Lion
# sudo defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true


# Trackpad
# Click weight (threshold) - set to medium
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "1"
# Tap to click
defaults write com.apple.AppleMultitouchTrackpad "Clicking" -int "1"


# Desktop Services
# Avoid creating .DS_Store files on network volumes
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool "true"
# Avoid creating .DS_Store files on USB volumes
sudo defaults write com.apple.desktopservices DSDontWriteUSBStores -bool "true"


# Automatically quit printer app once the print jobs complete.
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool "true"

# Music song notifications will not be displayed
defaults write com.apple.Music "userWantsPlaybackNotifications" -bool "false"


# Safari
# Prevent Safari from opening ‘safe’ files automatically after downloading
sudo defaults write com.apple.Safari "DownloadsClearingPolicy" -int "0"
sudo defaults write com.apple.Safari AutoOpenSafeDownloads -bool "false"

# Set up Default encoding
sudo defaults write com.apple.Safari WebKitDefaultTextEncodingName -string 'utf-8'
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DefaultTextEncodingName -string 'utf-8'

# Set up for development.
sudo defaults write com.apple.Safari "IncludeInternalDebugMenu" -bool "true"
sudo defaults write com.apple.Safari "IncludeDevelopMenu" -bool "true"
sudo defaults write com.apple.Safari "WebKitDeveloperExtrasEnabledPreferenceKey" -bool "true"
sudo defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool "true"
defaults write NSGlobalDomain "WebKitDeveloperExtras" -bool "true"

# Show full website URL
sudo defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"


# Kill affected applications
for app in "cfprefsd" \
    "Dock" \
    "Finder" \
    "Safari" \
    "Music" \
    "Spectacle" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
