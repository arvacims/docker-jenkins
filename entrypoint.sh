#!/bin/bash
set -e

echo 'Generating SSH key ...'
/usr/local/bin/generate_key.sh

if [ -e '/usr/share/jenkins/ref/plugins.txt' ]; then
    echo 'Installing plugins ...'
    /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
fi

echo 'Starting Jenkins ...'
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
    exec tini -- /usr/local/bin/jenkins.sh "$@"
fi
exec "$@"
