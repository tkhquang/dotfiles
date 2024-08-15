# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# PATH                                      #
# ========================================= #

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Golang
if [[ -d "/usr/local/go" ]]; then
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
fi

# Yarn
if [[ -d "$HOME/.yarn/bin" ]]; then
  export PATH=$HOME/.yarn/bin:$PATH
  export PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH
fi

# Rust
if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

# Custom bin
if [[ -d "$HOME/bin_common" ]]; then
  export PATH=$HOME/bin_common:$PATH
fi

# .NET
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
