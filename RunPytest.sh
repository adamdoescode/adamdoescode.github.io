#!/usr/bin/env bash

# delete inconvenient build files if they exist
# we dont want this anyway as github makes it automatically
# see: https://stackoverflow.com/questions/31871433/why-put-the-site-directory-of-a-jekyll-site-in-gitignore
rm -rf _site

# Run pytest with the given arguments
pytest
