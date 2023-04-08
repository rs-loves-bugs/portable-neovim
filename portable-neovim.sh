#!/usr/bin/env sh

rm -rf /tmp/.pnvim

mkdir -p /tmp/.pnvim/.config/
mkdir -p /tmp/.pnvim/.local/share
mkdir -p /tmp/.pnvim/.local/state
mkdir -p /tmp/.pnvim/.cache

curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -O
tar zxf nvim-linux64.tar.gz 
mv ./nvim-linux64 /tmp/.pnvim/dist
rm nvim-linux64.tar.gz

# Convert Mason bin links from absolute path to relative
find ~/.local/share/nvim/mason/bin -type l | while read l; do
    target="$(realpath "$l")"
    ln -fs "$(realpath --relative-to="$(dirname "$(realpath -s "$l")")" "$target")" "$l"
done

cp -r ~/.config/nvim /tmp/.pnvim/.config/
cp -r ~/.local/share/nvim /tmp/.pnvim/.local/share/

# Convert Mason bin links back to absolute path, might not be necesarry but eh 
find ~/.local/share/nvim/mason/bin -type l | while read l; do
    ln -sf "$(readlink -f "$l")" "$l"
done

tar -czf /tmp/pnvim.tar.gz -C /tmp/.pnvim .
cp ./pnvim.template ./pnvim
sed -i "s|REPLACEME|$HOME|" ./pnvim
base64 /tmp/pnvim.tar.gz >> ./pnvim
chmod +x ./pnvim
rm -rf /tmp/pnvim.tar.gz /tmp/.pnvim
