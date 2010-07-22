# Write in this file customization code that will get executed after all the
# soures have beenloaded.
Autobuild::Package['rtt'].
    define 'BUILD_TESTING', 'OFF'
