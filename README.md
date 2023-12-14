# dotfiles

This repository contains dotfiles for customizing the macOS environment, particularly for developers. It includes .zprofile and .zshrc configurations that enhance the shell experience, manage dependencies, and streamline development workflows.

## Prerequisites
* macOS with Homebrew installed.
* Relevant development tools (Ruby, PHP, Composer, Yarn, etc.) based on your project requirements.

## Installation
1. Clone this repository to your local machine.
2. Copy the .zprofile and .zshrc files to your home directory.
```bash
cp -t ~/ .zprofile .zshrc .gitconfig .gitignore_global
```
3. Source the files in your current shell session.
```bash
source ~/.zprofile
source ~/.zshrc
```

## Usage
* The configurations and aliases defined in these dotfiles are designed to optimize the development workflow on macOS.
* Customize the files according to your preferences and environment.
