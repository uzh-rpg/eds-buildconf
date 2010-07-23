# Write in this file customization code that will get executed before all the
# soures are loaded.

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
# env_set 'VAR', "value"
#
# Variables set like this are exported in the generated env.sh scripts.

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

configuration_option 'GIT_ROOT', 'string',
    :default => "git://gitorious.com/orocos",
    :doc => "The root under which git packages will be searched for"

