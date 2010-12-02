# Write in this file customization code that will get executed before 
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
# env_add 'PATH', "/path/to/my/tool"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#

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

#
# Adds the GITORIOUS option to autoproj.
# Set using the config.yml file.
#
gitorious_long_doc = [
    "Access method to import data from gitorious (git, http or ssh)",
    "Use 'ssh' only if you have a gitorious account. Note that",
    "ssh will always be used to push to the repositories, this is",
    "only to get data from gitorious. Therefore, we advise to use",
    "'git' as it is faster than ssh and better than http"]

configuration_option 'GITORIOUS', 'string',
    :default => "git",
    :values => ["http", "ssh"],
    :doc => gitorious_long_doc do |value|

    if value == "git"
        Autoproj.change_option("GITORIOUS_ROOT", "git://gitorious.org/")
    elsif value == "http"
        Autoproj.change_option("GITORIOUS_ROOT", "http://git.gitorious.org/")
    elsif value == "ssh"
        Autoproj.change_option("GITORIOUS_ROOT", "git@gitorious.org:")
    end

    value
end

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

Autoproj.change_option("GITORIOUS_PUSH_ROOT", "git@gitorious.org:")
Autoproj.user_config('GITORIOUS')
Autoproj.user_config('ROCK_FLAVOR')

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'

