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

#### fzf terminal (.bashrc/.zshrc), open directory ( ffd ) or file ( ffo ) or useripgrp and open in neovim.
```
ffd() {
    local file
    file=$(fzf) && cd $(dirname "$file") && pwd && ls -la
}

ffo() {
    local file
    file=$(fzf) && neovim "$file"
}

ffrg() {
    local file
    local line
    local result
    local exclude_dirs=('node_modules' '.git' 'vendor' '.next' 'dist' 'build' '.DS_Store')
    local rg_args=()

    # Costruisce gli argomenti per escludere le cartelle
    for dir in "${exclude_dirs[@]}"; do
        rg_args+=(--glob="!$dir")
    done

    result=$(rg --color=always --line-number --no-heading --smart-case "" "${rg_args[@]}" | fzf --height 50% --ansi --reverse --preview 'bat --color=always --highlight-line {2} {1} 2>/dev/null || cat {1}' --preview-window=right:60%:wrap --delimiter=: --nth=1,2,3)

    if [[ -n "$result" ]]; then
        file=$(echo "$result" | cut -d: -f1)
        line=$(echo "$result" | cut -d: -f2)

        if [[ -f "$file" ]]; then
            neovim "+$line" "$file"
        else
            echo "Errore: '$file' non è un file valido"
        fi
    fi
}
```

