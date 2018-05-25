#!/usr/bin/env bash

cd ~/.atom/

if [ -d .apm ]; then
    rm -rf .apm
fi
if [ -d packages ]; then
    rm -rf packages
fi
if [ -f config.cson ]; then
    rm config.cson
fi
if [ -f github.cson ]; then
    rm github.cson
fi
if [ -f init.coffee ]; then
    rm init.coffee
fi
if [ -f keymap.cson ]; then
    rm keymap.cson
fi
if [ -f snippets.cson ]; then
    rm snippets.cson
fi
if [ -f styles.less ]; then
    rm styles.less
fi
if [ -f package-deps-state.json ]; then
    rm package-deps-state.json
fi

ln -s ~/Dropbox/Applications/Atom/.apm .apm
ln -s ~/Dropbox/Applications/Atom/packages packages
ln -s ~/Dropbox/Applications/Atom/config.cson config.cson
ln -s ~/Dropbox/Applications/Atom/github.cson github.cson
ln -s ~/Dropbox/Applications/Atom/init.coffee init.coffee
ln -s ~/Dropbox/Applications/Atom/keymap.cson keymap.cson
ln -s ~/Dropbox/Applications/Atom/snippets.cson snippets.cson
ln -s ~/Dropbox/Applications/Atom/styles.less styles.less
ln -s ~/Dropbox/Applications/Atom/package-deps-state.json package-deps-state.json

cd ~
