# shell

## The ultimate order

`.zshenv` → [`.zprofile` if login] → [`.zshrc` if interactive] → [`.zlogin` if login] → [`.zlogout` sometimes].

When a user logs in, environment variables are set from various places.  That includes /etc/profile (for all users).

Then all the files in the /etc/profile.d directory.

Then ~/.bash_profile, then ~/.bashrc.

***When setting `$PATH` in `.zshenv`, if other files are sourced after this file they will override the values.***

### Where to put a setting

- If it is needed by a **command run non-interactively**: `.zshenv`
- If it should be **updated on each new shell**: `.zshenv`
- If it runs a command which **may take some time to complete**: `zprofile`
- If it is related to **interactive usage**: `.zshrc`
- If it is **a command to be run when the shell is fully setup**: `.zlogin`
- If it **releases a resource** acquired at login: `.zlogout`
