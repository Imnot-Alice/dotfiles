#!/usr/bin/fish
rm -rf ~/.steam* ~/.pulse*
set -x HOME $HOME/.local/steam
exec /usr/bin/steam $argv
