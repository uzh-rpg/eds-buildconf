#! /bin/sh

CONF_REPO=rock/buildconf.git
RUBY=ruby1.8

set -e

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
    $DOWNLOADER http://rock-robotics.org/stable/autoproj_bootstrap
fi

echo "Do you want to use the git protocol to access the build configuration?"
echo "If the protocol is blocked by your network answer with no."

# Check and interprete answer of "[y|n]"
ANSWER=""
until [ "$ANSWER" = "y" ] || [ "$ANSWER" = "n" ] 
do
	echo "Use git protocol? [y|n]"
	read ANSWER
	ANSWER=`echo $ANSWER | tr "[:upper:]" "[:lower:]"`
done

if [ "$ANSWER" = "y" ]; then
    $RUBY autoproj_bootstrap $@ git git://gitorious.org/$CONF_REPO push_to=git@gitorious.org:$CONF_REPO branch=master
else
    $RUBY autoproj_bootstrap $@ git http://git.gitorious.org/$CONF_REPO push_to=git@gitorious.org:$CONF_REPO branch=master
fi

if test "x$@" != "xlocaldev"; then
    . $PWD/env.sh
    autoproj update
    autoproj fast-build
fi

