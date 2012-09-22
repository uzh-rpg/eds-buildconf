
             Configuration of your autoproj build

- CMake
Since everything is CMake based, environment variables such as
CMAKE_PREFIX_PATH are always picked up. You can set them
in init.rb too, which will copy them to your env.sh script.

Because of cmake's aggressive caching behaviour, manual options
given to cmake will be overriden by autoproj later on. To make
such options permanent, add

  package('package_name').define "OPTION", "VALUE"

in overrides.rb. For instance, to set CMAKE_BUILD_TYPE for the rtt
package, do

  package('rtt').define "CMAKE_BUILD_TYPE", "Debug"

- Directory structure

The autoproj/ directory (this directory) contains the files and configuration
that defines the whole build. The manifest file

- Files in the autoproj/ directory

manifest:
  Simple key-value pair file in the YAML format. It lists sources for "package
  sets", other autoproj configuration directories in which packages have been
  declared for you to reuse (package_sets section). It also lists the packages
  that you actually want to build (layout section)

remotes/:
  contains a checkout of the package sets listed in the manifest. You should not
  have to go in there unless you are yourself developing a package set.

config.yml:
  Autoproj can be parametrized by build options. This file is where your
  previous choices for these options are saved. You should not change it manually.
  If you need tou change an option, run
    autoproj reconfigure

overrides.yml:
  Simple key-value pair file in the YAML format.  It allows to override branch
  information for specific packages.  Most people leave this to the default,
  unless they want to use a feature from an experimental branch. See the following
  page for a description of its contents.
    http://www.rock-robotics.org/stable/documentation/autoproj/advanced/importers.html

init.rb:
  Ruby script that contains customization code that will get executed before
  autoproj is loaded.

overrides.rb: 
  Ruby script that contains customization code that will get executed after
  autoproj is loaded, but before the build starts.
