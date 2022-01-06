#!/bin/bash

# Install Firefox Developer Edition

set -euf -o pipefail

echo ">>> Installing Firefox Developer Edition..."
sudo mkdir -p /opt/firefox-developer/

curl -L "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | sudo tar --strip-components 1 -jxp -C /opt/firefox-developer/

cat << EOF | sudo tee /firefox-developer-edition.desktop > /dev/null
[Desktop Entry]
Version=1.0
Name=Firefox Developer Edition
GenericName=Web Browser
Exec=/opt/firefox-developer/firefox %u
Terminal=false
Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png
Type=Application
Categories=Network;WebBrowser;Favorites;
MimeType=text/html;text/xml;application/xhtml_xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
X-Ayatana-Desktop-Shortcuts=NewWindow;NewIncognito
EOF

# Create Symlink
# For launching Firefox from a CommandLineInterface
sudo ln -sf /opt/firefox-developer/firefox /usr/local/bin/firefox

# For auto-update feature
sudo chown -R $USER:$USER /opt/firefox-developer

# TODO: Install userChromeJS support
# https://github.com/xiaoxiaoflood/firefox-scripts

echo ">>> Firefox Developer Edition installed!"
