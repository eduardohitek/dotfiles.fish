function gbs -d "set upstream branch for the current branch"
    set branch (git rev-parse --abbrev-ref HEAD)

    # Set upstream for the current branch
    git branch --set-upstream-to=origin/$branch $branch
    echo "Upstream branch set to origin/$branch for $branch"
end
