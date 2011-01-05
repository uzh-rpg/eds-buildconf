def rock_autoproj_init

    #
    # Orocos Specific ignore rules
    #
    # Ignore log files generated from the orocos/orogen components
    ignore(/\.log$/, /\.ior$/, /\.idx$/)
    # Ignore all text files except CMakeLists.txt
    ignore(/(^|\/)(?!CMakeLists)[^\/]+\.txt$/)
    # We don't care about the manifest being changed, as autoproj *will* take
    # dependency changes into account
    ignore(/manifest\.xml$/)
    # Ignore vim swap files
    ignore(/\.sw?$/)
    # Ignore the numerous backup files
    ignore(/~$/)
    configuration_option 'ROCK_FLAVOR', 'string',
        :default => 'stable',
        :values => ['stable', 'next', 'master'],
        :doc => [
            "Which flavor of Rock do you want to use ?",
            "The 'stable' flavor is not updated often, but will contain well-tested code",
            "The 'next' flavor is updated more often, and might contain less tested code",
            "it is updated from 'master' to test new features before they get pushed in 'stable'",
            "Finally, 'master' is where the development takes place. It should generally be in",
            "a good state, but will break every once in a while",
            "",
            "See http://rock-robotics.org/startup/releases.html for more information"]

    if Autoproj.has_config_key?('ROCK_FLAVOR') && Autoproj.user_config('ROCK_FLAVOR') != 'master'
        STDERR.puts "  Due to the current status of Rock, the stable and next flavors are disabled right now"
        STDERR.puts "  I'll switch to master"
        STDERR.print "  Press ENTER to continue"
        STDIN.readline
    end
    Autoproj.change_option('ROCK_FLAVOR', 'master')
end

