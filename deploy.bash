#!/bin/bash

# Temporarily store uncommited changes
git stash

# Verify correct branch
git checkout hakyll 

# Build new files
stack exec joshtaylorblog clean
stack exec joshtaylorblog build

# Get previous files
git fetch --all
git checkout master

# Overwrite existing files with new files
cp -a _site/. .

# Commit
git add -A
git commit -m "Publish."

# Push
git push origin master:master

# Restoration
git checkout develop
