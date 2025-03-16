# The original idea (and a couple settings) were grabbed from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://macos-defaults.com/

# Finder
# Always open everything in Finder's column view. This is important.
sudo defaults write com.apple.Finder FXPreferredViewStyle clmv
# Set the Finder prefs for showing a few different volumes on the Desktop.
sudo defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
sudo defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
sudo defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# Keep folders on top
sudo defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Show pathbar with paths
sudo defaults write com.apple.finder "ShowPathbar" -bool "true"



# Safari
# Set up for development.
sudo defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
sudo defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
sudo defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
sudo defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# Show full website URL
sudo defaults write com.apple.safari ShowFullURLInSmartSearchField -bool true

# Dock
# Icons size of 36 pixels.
sudo defaults write com.apple.dock tilesize -int 36
# Display recent apps
sudo defaults write com.apple.dock show-recents -bool false
# Put the Dock on the left of the screen
sudo defaults write com.apple.dock orientation -string left

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
# sudo defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

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
sudo defaults write com.apple.dock wvous-tl-corner -int 5
sudo defaults write com.apple.dock wvous-tl-modifier -int 0
# Bottom left screen corner → Desktop
sudo defaults write com.apple.dock wvous-bl-corner -int 4
sudo defaults write com.apple.dock wvous-bl-modifier -int 0


# Trackpad
# Click weight (threshold) - set to medium
sudo defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "1"


# Desktop Services
# Avoid creating .DS_Store files on network or USB volumes
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Avoid creating .DS_Store files on network or USB volumes
sudo defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


# Kill affected applications
for app in "cfprefsd" \
    "Dock" \
    "Finder" \
    "Safari" \
    "Spectacle" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
