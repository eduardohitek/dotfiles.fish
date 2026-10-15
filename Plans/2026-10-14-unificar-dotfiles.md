# Plan: Unificar ~/.dotfiles com ~/dev/hitek/dotfiles.fish

**Date:** 2026-10-14
**Status:** Approved

---

## Objective

Acabar com os dois clones divergentes. O clone antigo em `~/.dotfiles` estava parado em `bb16f16` (2021) e era o que o shell carregava. O repo real passa a ser `~/dev/hitek/dotfiles.fish`, e `~/.dotfiles` vira um symlink para ele, que continua sendo o caminho de acesso usado por symlinks e variáveis universais.

---

## Implementation Steps

1. Criar a branch `chore/unificar-dotfiles` a partir da `main`.
2. Commitar as pendências em commits separados: troca de exa por eza, remoção de `vscode/`, README e CLAUDE.md.
3. Trazer do clone antigo o `htop/htoprc` (formato htop 3.x) e o `coc.nvim` no `vim/vimrc.symlink`, cada um em seu commit.
4. Mover os hosts privados do `ssh/config` (IPs da rede local, sem duplicatas, e o bloco do Teleport) para `~/.ssh/config.local`, que fica fora do repo. No repo entra só o `Include ~/.orbstack/ssh/config`.
5. Copiar os arquivos ignorados que estão em uso: `vim/vim.symlink/plugged`, `vim/vim.symlink/autoload` e `iterm/com.googlecode.iterm2.plist`.
6. Trocar `DOTFILES_ROOT` no `script/bootstrap.fish` de `pwd -P` para `$HOME/.dotfiles` e documentar o layout no `CLAUDE.md`.
7. Rodar `mv ~/.dotfiles ~/.dotfiles.old` e `ln -s ~/dev/hitek/dotfiles.fish ~/.dotfiles`.
8. Validar num fish novo, sem rodar o bootstrap: functions carregadas, `$DOTFILES`, symlinks resolvendo, `ssh -G` e o vim.
9. Fazer merge na `main` e push só com aprovação.

---

## Expected Outcomes

- Uma única fonte de verdade. Edições no repo valem no shell na hora.
- Nenhum symlink de `~` precisa ser recriado e nenhum `.backup` é gerado.
- Nenhum dado privado de SSH vai para o repo público.

---

## Risks & Considerations

- O repo é público, então o `ssh/config` precisa ser revisado antes de cada commit.
- O `~/.dotfiles.old` fica como backup até a validação ser confirmada.
- O bootstrap não é executado agora, porque o `macos/install.fish` tem um bug que desliga as completions de man. Fica para a etapa de correções.
