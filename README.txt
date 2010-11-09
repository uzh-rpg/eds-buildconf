
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

- Config files
There are various file that influence your build:

*.yml files: are simple 'key: value' pairs in the YAML format to set
             config options. This list is limited to what autoproj
	     knows.

*.rb  files: are ruby scripts that can influence any part of the 
             autoproj program, without modifying autoproj itself.
             This is only for advanced users that understand ruby
	     and the internals of autoproj.

- Configuration options

config.yml:  Save build configuration. You should not change it
             manually. If you need to change an option, run an
             autoproj operation with --reconfigure, as for
             instance
                  autoproj build --reconfigure

overrides.yml:
	     Override branch information for specific packages.
	     Most people leave this to the default, unless they
	     want to use a feature from an experimental branch.

- Influencing Autoproj ruby code:

init.rb:     Write in this file customization code that will get executed
	     before autoproj is loaded.

overrides.rb: 
	     Write in this file customization code that will get
	     executed after autoproj loaded.
