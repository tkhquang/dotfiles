# ========================================= #
# bash_profile                              #
# ========================================= #
# `.bash_profile` is for making sure that
# both the things in `.profile` and `.bashrc` are loaded for login shells.
# For example, `.bash_profile` could be something simple like this:
# ```sh
# . ~/.profile
# . ~/.bashrc
# ```

# Get the aliases and functions
if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if [[ -f ~/.profile ]]; then
	. ~/.profile
fi
