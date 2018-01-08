# openvpn-flexscript
OpenVPN supports user defined scripts, which are being called on specific events (e.g. interface up, client connect, client.disconnect, etc.). This is an advanced scripting framework, dealing with some of the complexity in larger deployments. 

## Abstract

OpenVPN is a popular cross platform software for creating secure tunnels over SSL/TLS. It is extremely flexible, which is on some parts archived by being extensible through hooks, which can call scripts or binaries on specific events during runtime. 

Communication with these hooks is implemented using:

1.  environment variables ( forwarding information from the OpenVPN instance to the script)
1. temporary file ( channelling back from script to OpenVPN instance)
1.  return value ( channeling back from the script to OpenVPN instance)


When running OpenVPN, it is recommended to drop root privileges on the running instance of the OpenVPN process. In a more complex setup, it also might be necessary to take actions e.g. on client connection or disconnect, which require root privileges. E.g.: 

1. altering firewall rules
1. manipulating routing tables

The hook scripts mostly will inherit the user and group membership by the OpenVPN process calling, which will not enable the script to perform tasks requiring root privileges. openvpn-flexscript will implement a two stage setup, using sudo to elevate user privileges in a restricted manner.

On tunnel restart, the reconnecting tunnels can impose a huge load on the machine as multiple connect / disconnect script instances have to be run simultaneously. The ideal solution to this problem would be to have a server process running, which has read all the configuration and serves the configuration to simplistic clients. As this is to complex to implement I tried to take the scripting approach and did take the following counter measures:

1. using /bin/sh as shell, as bash is more resource hungry
1. starting as few subshells as possible
1. instead sourcing scripts (called plugins) 
1. concatenating all plugins into one single file to minimize disc access
1. optional: only calling the root instance if necessary


