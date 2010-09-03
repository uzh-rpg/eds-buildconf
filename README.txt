
             Configuration of your autoproj build

- CMake
Since everything is CMake based, environment variables such as
CMAKE_PREFIX_PATH are always picked up. You can set them
in init.rb too, which will copy them to your env.sh script.

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

config.yml:  Your primary source for changing build settings.
	     Warning: each run, all comments from this file are
	     removed. So if you comment out a line with '#', it
	     will not be there any more after the next run.
	     Common options:
	     	    prefix: /opt/orocos
		    rtt_corba: true
		    rtt_target: gnulinux

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
