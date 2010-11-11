#! /bin/sh

if ! test -f $PWD/autoproj_bootstrap; then
    if which wget > /dev/null; then
        DOWNLOADER=wget
    elif which curl > /dev/null; then
        DOWNLOADER=curl
    else
        echo "I can find neither curl nor wget, either install one of these or"
        echo "download the following script yourself, and re-run this script"
        exit 1
    fi
    $DOWNLOADER http://doudou.github.com/autoproj/autoproj_bootstrap
fi

ruby autoproj_bootstrap $@ git git://gitorious.org/rise/build-all.git branch=master
. $PWD/env.sh
autoproj update
autoproj fast-build

