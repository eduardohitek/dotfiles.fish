status is-interactive; or exit

if command -qs claude
	abbr -a ccd 'CLAUDE_CODE_NO_FLICKER=1 claude --dangerously-skip-permissions'
	abbr -a cc 'CLAUDE_CODE_NO_FLICKER=1 claude --enable-auto-mode'
end
