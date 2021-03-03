#!/usr/bin/env bash

. /lib/svc/share/smf_include.sh

getproparg() {
 arg=$(svcprop -p $1 $SMF_FMRI)
 [ -n "$arg" ] && echo $arg
}

agentJar="$(getproparg jenkins/agentJar)"
url="$(getproparg jenkins/url)"
workDir="$(getproparg jenkins/workDir)"
secret="$(getproparg jenkins/secret)"

fail() {
    echo $1
    exit 1
}

([ -z "$agentJar" ] || [ -z "$url" ] || [ -z "$workDir" ] || [ -z "$secret" ]) && fail "not all required properties were set"

java -jar $agentJar -jnlpUrl $url -secret $secret -workDir $workDir
