#!/usr/scripts/env bash

. "$(pwd)/ci/helpers.sh"

staged_files=$(git diff --cached --name-only --diff-filter=ACM | grep ".php\{0,1\}$")

if [[ "${staged_files}" = "" ]]; then
  exit 0
fi

can_commit=true

# Fix code style issues
# ~~~~~~

echo_flag "Code styling..."

for staged in ${staged_files}; do
    ./vendor/bin/php-cs-fixer fix --quiet --allow-risky=yes "${staged}"

    if [[ $? -eq 0 ]]; then
        git add "${staged}"
        echo_success "${staged}"
    else
        can_commit=false
        break
    fi
done

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
    echo -e "\n"
    echo_error "Commit aborted!" "\n"
    exit 1
else
    echo_flag "Commit allowed..."
fi

exit $?
