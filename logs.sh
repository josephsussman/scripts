#!/bin/bash

: '
 Download, decompress and unarchive a CloudReady log package.

Also changes removes both the intermediate tarball and the
compressed tarball.
'

set -e


logs=$1

if [[ -z $logs ]]; then
    script=$(basename "$0")
    printf "%s: missing log package name\n" "$script"
    exit 1
fi

get_logs () {
    eval "aws s3 cp s3://cloudready-logs/$logs ."
    lz4 -df "$logs"
    
    tarball=${logs%.*}
    tar xf "$tarball"

    rm -f "$logs" "$tarball"
}

get_logs;
