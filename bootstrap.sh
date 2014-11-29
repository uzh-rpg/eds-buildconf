#! /bin/sh

CONF_URL=${CONF_URL:=http://github.com/rock-core/buildconf.git}
RUBY=ruby
AUTOPROJ_BOOTSTRAP_URL=http://rock-robotics.org/stable/autoproj_bootstrap

if test -n "$1" && test "$1" != "dev" && test "$1" != "localdev"; then
    RUBY=$1
    shift 1
    RUBY_USER_SELECTED=1
fi

set -e

if ! which $RUBY > /dev/null 2>&1; then
    echo "cannot find the ruby executable. On ubuntu, you should run"
    echo "  sudo apt-get install ruby1.9.1 rubygems"
    exit 1
fi


if ! $RUBY --version | grep -q "1\.9\.3"; then
    if test "$RUBY_USER_SELECTED" = "1"; then
        cat <<EOMSG
You selected $RUBY as the ruby executable, and it is not providing Ruby 1.9.3
1.9.3 is still the recommended Ruby version for Rock, so use at your own risk

Press ENTER to continue or CTRL+C to quit
EOMSG
        read LINE
    elif which ruby1.9.1 > /dev/null 2>&1; then
        cat <<EOMSG
ruby --version reports
  `$RUBY --version`
The recommended version for Rock is ruby 1.9.3, and I detected that ruby1.9.1
provides it. I am forcefully selecting it as the ruby executable. You can force
the use of another Ruby executable by passing it on the command line, as e.g.
  sh bootstrap.sh ruby2.0

Press ENTER to continue with ruby1.9.1 and CTRL+C to quit
EOMSG
        read LINE
        RUBY=ruby1.9.1
    else
        cat <<EOMSG
ruby --version reports
  `$RUBY --version`
The recommended version for Rock is ruby 1.9.3. I don't know if you have it
installed, and if you do what name it has. You will have to select a Ruby
executable by passing it on the command line, as e.g.
  sh bootstrap.sh ruby19
EOMSG
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
    $DOWNLOADER $AUTOPROJ_BOOTSTRAP_URL
fi

CONF_URL=${CONF_URL#*//}
CONF_SITE=${CONF_URL%%/*}
CONF_REPO=${CONF_URL#*/}

PUSH_TO=git@$CONF_SITE:$CONF_REPO
until [ -n "$GET_REPO" ]
do
    echo -n "Which protocol do you want to use to access $CONF_REPO on $CONF_SITE? [git|ssh|http] (default: git) "
    read ANSWER
    ANSWER=`echo $ANSWER | tr "[:upper:]" "[:lower:]"`
    case "$ANSWER" in
        "ssh") GET_REPO=git@$CONF_SITE:$CONF_REPO ;;
        "http") GET_REPO=https://$CONF_SITE/$CONF_REPO ;;
        "git"|"") GET_REPO=git://$CONF_SITE/$CONF_REPO ;;
    esac
done

$RUBY autoproj_bootstrap $@ git $GET_REPO push_to=$PUSH_TO branch=master

if test "x$@" != "xlocaldev"; then
    $SHELL -c '. $PWD/env.sh; autoproj update; autoproj fast-build'
fi

