#!/usr/scripts/env bash

. "$(pwd)/ci/helpers.sh"
. .env.ci

[[ ${1} == "production" ]] && path="${REMOTE_PATH_PRODUCTION}" || path="${REMOTE_PATH_STAGING}"

echo_flag "Deploying ${1} to remote"

ssh_dest="${SSH_USER}@${SSH_HOST}"
rsync_dest="${SSH_USER}@${SSH_HOST}:${path}"

php=${REMOTE_PHP_EXEC:-php}

echo_title "Setting app in maintenance mode..."
ssh -tt ${ssh_dest} "cd ${path} && ${php} artisan down"

echo_title "Syncing new code..."
rsync -rltzv --delete --exclude-from=.rsyncignore ./ ${rsync_dest}

echo_title "Bringing app back up..."
ssh -tt ${ssh_dest} "cd ${path} && ${php} artisan optimize && ${php} artisan up"

echo_flag "Done!"
