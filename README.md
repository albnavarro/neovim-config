### PERSONAL NEOVIM CONFIG

#### Use appImage alias example (.bashrc/.zshrc):
```
alias neovim='/home/user/appimage/nvim.appimage'
```

## Install separately ( with Mason ):
- eslint_d
- prettierd
- stylelint
- stylua
- codespell

## Final Mason installed package:
- css-lsp
- emmet-ls
- eslint_d
- html-lsp
- lua-language-server
- prettierd
- stylelint
- stylua
- svelte-language-server
- typescript-language-server
- json-lsp
<!-- - stylelint-lsp -->
<!-- - eslint-lsp -->

## Fzf-lua Dependencies:

- zfz: https://github.com/junegunn/fzf
- BurntSushi/ripgrep.
- sharkdp/fd ( optional )

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

## Blink Dependencies
- curl

## Treesitter dependencies:
npm install -g tree-sitter-cli
