#!/bin/bash

# Install Firefox Developer Edition

set -euf -o pipefail

echo ">>> Installing Firefox Developer Edition..."
sudo mkdir -p /opt/firefox-developer/

curl -L "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | sudo tar --strip-components 1 -jxp -C /opt/firefox-developer/

sudo sh -c "echo '[Desktop Entry]
Version=1.0
Name=Firefox Developer Edition
GenericName=Web Browser
Exec=/opt/firefox-developer/firefox %u
Terminal=false
Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png
Type=Application
Categories=Network;WebBrowser;Favorites;
MimeType=text/html;text/xml;application/xhtml_xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
X-Ayatana-Desktop-Shortcuts=NewWindow;NewIncognito' >> /usr/share/applications/firefox-developer-edition.desktop"

# Create Symlink
# For launching Firefox from a CommandLineInterface
sudo ln -sf /opt/firefox-developer/firefox /usr/local/bin/firefox

# TODO: Install userChromeJS support
# https://github.com/xiaoxiaoflood/firefox-scripts

echo ">>> Firefox Developer Edition installed!"

