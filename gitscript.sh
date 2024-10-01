#!/bin/bash

# Check if a commit message was passed as an argument
if [ -z "$1" ]; then
  echo "Error: No commit message provided"
  echo "Usage: ./git_auto_commit.sh 'Your commit message'"
  exit 1
fi

# Check the current branch
current_branch=$(git branch --show-current)
if [ -z "$current_branch" ]; then
  echo "Error: Unable to determine current branch. Are you inside a Git repository?"
  exit 1
fi
echo "Current branch: $current_branch"

# Add all changes
git add .

# Check Git status
git_status=$(git status --short)
if [ -z "$git_status" ]; then
  echo "No changes to commit."
  exit 0
else
  echo "Changes to commit:"
  echo "$git_status"
fi

# Commit with the provided message
git commit -m "$1"

# Push to the current branch
git push origin "$current_branch"

echo "Changes committed and pushed to branch $current_branch"

