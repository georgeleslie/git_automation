#!/bin/bash

# Check if the user provided a repository name
if [ -z "$1" ]; then
  echo "Error: No repository name provided."
  echo "Usage: ./newrepo.sh <repository-name> [commit-message] [description]"
  exit 1
fi

# Variables
REPO_NAME=$1
COMMIT_MESSAGE=${2:-"Initial commit"}  # Default commit message if none provided
DESCRIPTION=${3:-"Repository created via script"}  # Default description if none provided

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
  echo "Error: GitHub CLI (gh) is not installed."
  echo "Please install GitHub CLI by following the instructions here: https://cli.github.com/"
  exit 1
fi

echo "GitHub CLI is installed."

# Create the GitHub repository using the GitHub CLI with a README and description
echo "Creating a new GitHub repository named '$REPO_NAME'..."
gh repo create "$REPO_NAME" --public --source=. --remote=origin --description "$DESCRIPTION" --readme
if [ $? -ne 0 ]; then
  echo "Error: Failed to create GitHub repository."
  exit 1
fi

echo "GitHub repository '$REPO_NAME' created successfully with a README."

# Initialize Git repository if it's not already initialized
if [ ! -d .git ]; then
  git init
  echo "Initialized empty Git repository."
fi

# Add all files to staging
git add .

# Commit changes
git commit -m "$COMMIT_MESSAGE"

# Push to the GitHub repository
git push -u origin main

echo "All changes committed and pushed to the GitHub repository '$REPO_NAME'."
