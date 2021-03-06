#!/usr/bin/env bash

. /lib/svc/share/smf_include.sh

getproparg() {
 arg=$(svcprop -p $1 $SMF_FMRI)
 [[ -n "$arg" && $arg != '""' ]] && echo $arg # Solaris 10 returns "", Solaris 11 nothing
}

agentJar=$(getproparg jenkins/agentJar)
url=$(getproparg jenkins/url)
workDir=$(getproparg jenkins/workDir)
secret=$(getproparg jenkins/secret)
javaExecutable=$(getproparg jenkins/javaExecutable)

fail() {
    echo $1
    exit $SMF_EXIT_FATAL
}


[[ -z "$agentJar" || -z "$url" || -z "$workDir" || -z "$secret" ]] && fail "not all required properties were set" ]]

[ -z $javaExecutable ] && javaExecutable=java

$javaExecutable -jar "$agentJar" -jnlpUrl "$url" -secret "$secret" -workDir "$workDir"
exit $SMF_EXIT_OK
