function gtp -d "create a Git tag and push it to the origin remote"
    if test -z $argv
        echo "Usage: create-tag-and-push <tag_name>"
        return 1
    end

    set tag_name $argv[1]

    # Create a Git tag
    git tag $tag_name -f

    # Push the tag to the origin remote
    git push origin $tag_name -f

    echo "Tag $tag_name created and pushed to origin"
end
