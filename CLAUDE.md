# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Fish shell dotfiles (forked from caarlos0/dotfiles.fish). There is no build, lint, or test suite.

**Layout on this machine:** the real clone is `~/dev/hitek/dotfiles.fish`, and `~/.dotfiles` is a symlink to it. `~/.dotfiles` is the stable path: `00-dotfiles/install.fish` hardcodes `DOTFILES=~/.dotfiles`, the bootstrap uses `$HOME/.dotfiles` as `DOTFILES_ROOT` (deliberately not resolved with `pwd -P`), and every symlink in `~` points through it. Edits in the repo take effect immediately — there is no second copy to sync. Never reintroduce a separate clone at `~/.dotfiles`.

Private machine config stays out of this public repo: SSH hosts go in `~/.ssh/config.local`, fish secrets in `~/.localrc.fish`.

## Install / apply changes

```fish
./script/bootstrap.fish   # idempotent; aborts if ~/.dotfiles doesn't exist
```

To test a single topic, run its installer directly, e.g. `./git/install.fish`. After editing a function file, open a new shell (or `source` the file) to pick it up.

## Architecture: topical layout

Each top-level directory is a "topic" (git, docker, eza, java, …). The bootstrap discovers files by convention, so adding a file in the right place is usually all that's needed:

- `<topic>/install.fish` — run by bootstrap for every topic (glob `*/install.fish`, alphabetical; `00-dotfiles` runs first to set universal vars like `DOTFILES`, `EDITOR`, `PROJECTS`). Must be executable with a `#!/usr/bin/env fish` shebang. Installers are where `set -Ux` universal variables, `fish_add_path` entries and `git config --global` settings live — never abbreviations (see conf.d below). They must be safe to re-run; guard tool-specific setup with `command -qs <tool>`. A topic with nothing to install has no `install.fish`.
- `<topic>/functions/*.fish` — every such directory is prepended to `fish_function_path` (not copied/linked), so functions are autoloaded straight from the repo. One function per file, filename = function name, with `-d "description"`.
- `<topic>/conf.d/*.fish` — symlinked into `~/.config/fish/conf.d/` by basename (run on every shell start, in alphabetical order across all files there; `config.fish` runs after them). Abbreviations go in `<topic>/conf.d/zz_<topic>_abbr.fish`, starting with `status is-interactive; or exit`: since fish 3.6 `abbr -a` is no longer universal, so one defined in an installer vanishes when it exits. The `zz_` prefix makes them load last, so they win over third-party conf.d files (e.g. Kaku's) that define the same names.
- `<topic>/*.symlink` — symlinked to `~/.<name>` (e.g. `git/gitconfig.local.symlink` → `~/.gitconfig.local`). Works for directories too (`vim/vim.symlink`, `nvim.symlink`).
- `bin/` — added to `fish_user_paths`; executables here are available on PATH. `git-*` scripts become git subcommands (`git sync`, `git main-branch`).
- Non-conventional links (fisher plugins list, `bat/config`, `htop/htoprc`, `ssh/config`) are wired explicitly in `install_dotfiles` in `script/bootstrap.fish`.
- `fisher/plugins` is the Fisher plugin list (linked to `fish_plugins`).
- `~/.localrc.fish` (outside the repo) is linked into conf.d for machine-local secrets/overrides.

Existing files at link targets are backed up with a `.backup` suffix (`.local` for ssh config).

## Conventions

- `.editorconfig`: tabs (size 4) for everything except `*.md`/`*.yml` (2 spaces).
- Commit messages are in Portuguese with a conventional prefix, e.g. `feat: adicionando função para ...`.
- Theme across tools is Dracula.
