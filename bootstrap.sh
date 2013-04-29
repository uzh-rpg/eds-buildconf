#! /bin/sh

CONF_REPO=rock/buildconf.git
RUBY=ruby

set -e

if ! which $RUBY > /dev/null 2>&1; then
    echo "cannot find the ruby executable. On ubuntu, you should run"
    echo "  sudo apt-get install ruby1.9.1 rubygems"
    exit 1
fi
if $RUBY --version | grep -q "1\.8"; then
    if which ruby1.9.1 > /dev/null 2>&1; then
        echo "ruby points to ruby 1.8. I am forcefully selecting ruby1.9.1 as the ruby executable"
        echo "press ENTER to continue"
        read LINE
        RUBY=ruby1.9.1
    else
        echo "you are trying to bootstrap using Ruby 1.8. This is unsupported"
        echo "please install Ruby 1.9.2 or later. On Debian and Ubuntu, it is done"
        echo "with"
        echo "  sudo apt-get install ruby1.9.1 rubygems"
        echo "I am aborting now"
        exit 1
    fi
fi

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

echo "Do you want to use the git protocol to access the build configuration ?"
echo "If the protocol is blocked by your network answer with no. The default is yes."

# Check and interprete answer of "[y|n]"
ANSWER="wrong"
until test "$ANSWER" = "y" || test "$ANSWER" = "n" || test "$ANSWER" = ""
do
    echo "Use git protocol? [y|n] (default: y)"
    read ANSWER
    ANSWER=`echo $ANSWER | tr "[:upper:]" "[:lower:]"`
done

if [ "$ANSWER" = "n" ]; then
    $RUBY autoproj_bootstrap $@ git http://git.gitorious.org/$CONF_REPO push_to=git@gitorious.org:$CONF_REPO branch=master
else
    $RUBY autoproj_bootstrap $@ git git://gitorious.org/$CONF_REPO push_to=git@gitorious.org:$CONF_REPO branch=master
fi

if test "x$@" != "xlocaldev"; then
    $SHELL -c '. $PWD/env.sh; autoproj update; autoproj fast-build'
fi

