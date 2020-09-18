#!/usr/scripts/env bash

. "$(pwd)/ci/helpers.sh"

staged_files=$(git diff --cached --name-only --diff-filter=ACM | grep ".php\{0,1\}$")

if [[ "${staged_files}" = "" ]]; then
  exit 0
fi

can_commit=true

# Fix code style issues
# ~~~~~~

make style

echo -e "\n"

if [[ "$?" != 0 ]]; then
    echo_error "Code styling failed!"
    can_commit=false
else
    echo_success "Code styled"
fi

# Run tests
# ~~~~~~

make test

if [[ "$?" != 0 ]]; then
    can_commit=false
fi

# Can we commit?
# ~~~~~~

echo -e "\n"

if ! ${can_commit}; then
    echo_error "Commit aborted!"
    exit 1
else
    echo_success "Commit allowed..."
fi

exit $?
