#### Install appImage ( linux ):
- `wget url`
- `chmod a+x nvim.appimage`
- `sha256sum -c nvim.appimage.sha256sum`
    - se abbiamo solo il codice creare `nvim.appimage.sha256sum` e incollare il codice. `$: sha256sum nvim.appimage`
- `chmod u+x nvim.appimage`

#### Use appImage alias example (.bashrc/.zshrc):
```
alias neovim='/home/user/appimage/nvim.appimage'
```

#### fzf terminal (.bashrc/.zshrc), open directory.
```
fcd() {
    local file
    file=$(fzf) && cd $(dirname "$file") && pwd && ls -la
}
```

#### fzf terminal (.bashrc/.zshrc), open file in neovim.
```
ffo() {
    local file
    file=$(fzf) && neovim "$file"
}
```
