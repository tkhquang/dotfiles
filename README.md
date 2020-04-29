# dotfiles

My personal dotfiles.

[Fedora 30 KDE Plasma]

For migration references only. Created in a hurry, expecting mistakes.

## Post-Installion TODOS

1. Tilix
    - `Ctrl+Alt+R` by default conflicts with KDE's "Manually Invoke Action On Current Clipboard" Global Shortcut -> Remove the Global Shortcut
    - To start Tilix maximized:
        1. Open`/usr/share/applications/com.gexperts.Terminix.desktop`.
        2. Add `--maximize` to the Exec commands.
        3. Make sure `DBusActivatable` is set to `false`.
        4. Remove -> Add Global Shortcut for Tilix again.
        5. Logout -> Login for the changes to take effects.
    - To add `Open Tilix Here` entry in Context Menu for Dolphin:
        1. Create `~/.local/share/kservices5/ServiceMenus/openTilixHere.desktop`
        2. Save

            ```desktop
              [Desktop Entry]
              Type=Service
              ServiceTypes=KonqPopupMenu/Plugin
              MimeType=inode/directory
              Actions=openTilix;
              X-KDE-Priority=TopLevel
              X-KDE-StartupNotify=false
              Icon=com.gexperts.Tilix

              [Desktop Action openTilix]
              Name=Open Tilix Here
              Icon=com.gexperts.Tilix
              Exec=tilix --maximize -w %f
            ```

2. ibus configs
3. Rust
4. Docker*
5. [userChomeJS](https://github.com/xiaoxiaoflood/firefox-scripts)
6. Steam
7. [Change Lockscreen
   format](https://askubuntu.com/questions/783184/how-to-display-kde-lock-screen-time-in-24-hour-format#comment1729228_784181)
