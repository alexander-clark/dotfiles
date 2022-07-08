# Alexander's Dotfiles

## Installation

`./install.sh`

This script does the following:

* Install Homebrew or update it if already installed
* Install oh-my-zsh
* Install all packages listed in the homebrew file
* Install all packages listed in the casks file
* Symlink the dotfiles in this repo to the user's home directory unless the file already exists
* Symlink a custom zsh theme
* Copy local overrides templates unless the file already exists
* Symlink vim Vundle config and install vim plugins
* Set up additional folder structure for vim
* Set up terminal colors

If you've recently run `brew update` or just want the script to run quickly for testing purposes, you can run `./install.sh -a` to skip this step (one of the slowest).

## Local customizations

`.aliases`, `.exports`, `.functions`, `.gitconfig`, `.path`, and `.tmux.conf` can all be supplemented with local-only versions in the home directory. These machine-specific settings should not be committed. E.g. `.aliases.local`.

`.gitconfig.local` and `.tmux.conf.local` have templates in this repo that will be copied (not symlinked) if local overrides don't already exist.

## OSX-specific settings

`.macos` contains a number of commands to set preferences from the command line.

TODO: make this a proper shell script

## tmux

## vim

## Secrets

`.functions` defines a few functions to make it possible to store sensitive information (passwords, API secrets, etc.) in an environment variable without storing the information directly in a file.

`set_keychain_pw my_secret_name` can be used to store the information in the apple keychain. (You will be prompted for the secret so it doesn't stay in your command line history).

Then in `.exports` or `.exports.local`, you can do this:

`export MY_ENV_VAR="$(get_keychain_pw my_secret_name)"`
