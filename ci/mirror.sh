#!/usr/bin/env bash

REPO_PATH="${PROJECT_HOME}/ansible-mastodon/"

cd "${REPO_PATH}" && git pull origin main || :
git push github main -f
git push pgitlab main -f
exit 0
