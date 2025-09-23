#### Install appImage ( linux ):
- `wget url`
- `chmod a+x nvim.appimage`
- `sha256sum -c nvim.appimage.sha256sum`
    - se abbiamo solo il codice creare `nvim.appimage.sha256sum` e incollare il codice. `$: sha256sum nvim.appimage`
- `chmod u+x nvim.appimage`

#### Install executable ( mac ):
- `wget` nvim-macos-x86_64.tar.gz
- Run xattr -c ./nvim-macos-x86_64.tar.gz (to avoid "unknown developer" warning)
- Extract: tar xzvf nvim-macos-x86_64.tar.gz
- Run ./nvim-macos-x86_64/bin/nvim

#### Use appImage alias example (.bashrc/.zshrc):
```
alias neovim='/home/user/appimage/nvim.appimage'
```

#### fzf terminal (.bashrc/.zshrc), open directory ( ffd ) or file ( ffo ).
```
ffd() {
    local file
    file=$(fzf) && cd $(dirname "$file") && pwd && ls -la
}

ffo() {
    local file
    file=$(fzf) && neovim "$file"
}
```

