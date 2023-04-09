## Portable Neovim

Ever want to quickly run neovim on a newly created server but don't want to spend too much time installing and setting up neovim?  

This proof of concept script will create a one file bundle from the latest neovim stable linux 64bit and the neovim config you use on the systen you run it. All your custom settings, plugins, treesitter parsers, lsp servers, linters, formatters are bundled. 

### Usage:

```sh
./portable-neovim.sh
```
The script will create a file `pnvim` is an executable script that you can put anywhere you want to run neovim. I usually just rename it to `nvim` and scp it to `/usr/bin/neovim` where I need it.

Caveats:
 - for now this only supports linux 64 bit
 - this assumes your neovim config uses the default config and data directories(`~/.config/nvim` and `~/.local/share/nvim`) 
 - this assumes you're using Mason to setup your lsp/linters/formatters etc.
 - no Mason requirements(python, node, etc.) are bundled, you'll probably need to install them for some tools to work(some lsp servers, linters, formatters etc.)