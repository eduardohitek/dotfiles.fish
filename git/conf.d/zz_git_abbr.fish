status is-interactive; or exit

if command -qs gh
	abbr -a 'grv' 'gh repo view -w'
	abbr -a 'gpv' 'gh pr view -w'
end

abbr -a gl 'git pull --prune'
abbr -a glg "git log --graph --decorate --oneline --abbrev-commit"
abbr -a glga "glg --all"
abbr -a gp 'git push origin HEAD'
abbr -a gpa 'git push origin --all'
abbr -a gd 'git diff'
abbr -a gc 'git commit -s'
abbr -a gca 'git commit -sa'
abbr -a gco 'git checkout'
abbr -a gcob 'git checkout -b'
abbr -a gb 'git branch -v'
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gcm 'git commit -m'
abbr -a gs 'git status -sb'
abbr -a glnext 'git log --oneline (git describe --tags --abbrev=0 @^)..@'
abbr -a gw 'git switch'
abbr -a gm 'git switch (git main-branch)'
abbr -a gms 'git switch (git main-branch); and git sync'
abbr -a egms 'e; git switch (git main-branch); and git sync'
abbr -a gwc 'git switch -c'
abbr -a gru 'git remote update'
abbr -a gfa 'git fetch --all --prune'
abbr -a gst 'git status'
abbr -a gwp 'git checkout -- .'
abbr -a gcos 'git checkout TR-'
abbr -a gcobs 'git checkout -b TR-'
abbr -a gcam 'git commit --amend --no-edit'
abbr -a gclean 'git branch --merged (git main-branch) | grep -v "^[ *]*"(git main-branch)"\$" | xargs git branch -d'
