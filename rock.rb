def rock_autoproj_init(flavor)

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

    Autoproj.change_option('ROCK_FLAVOR', flavor)
end

