# dropkick.sh
Detect and disconnect hidden WiFi cameras in that AirBnB you're staying in

Originally up on my [log](https://julianoliver.com/output/log_2015-12-18_14-39) and
as seen on
[Motherboard](http://motherboard.vice.com/read/kill-your-airbnbs-hidden-wifi-cameras-with-this-script).

Context
-------

There have been a few too many stories lately of AirBnB hosts caught spying on
their guests with WiFi cameras, using DropCam cameras in particular. Here’s a
quick script that will detect two popular brands of WiFi cameras during your
stay and disconnect them in turn. It’s based on glasshole.sh. It should do away
with the need to rummage around in other people’s stuff, racked with paranoia,
looking for the things.

Thanks to [http://ahprojects.com](Adam Harvey) for giving me the push, not to mention for naming it.

For a plug-and-play solution in the form of a network appliance, see
[https://plugunplug.net](Cyborg Unplug).

Disclaimer
---------

For the record, I’m well aware DropCam and Withings are also sold as baby
monitors and home security products. The very fact this code exists should
challenge you to reconsider the non-sane choice to rely on anything wireless for
home security. More so, WiFi jammers - while illegal - are cheap. If you care,
use cable.

It may be illegal to use this script in the US. Due to changes in FCC regulation
in 2015, it appears intentionally de-authing WiFi clients, even in your own
home, is now classed as ‘jamming’. Up until recently, jamming was defined as the
indiscriminate addition of noise to signal - still the global technical
definition. It’s worth noting here that all wireless routers necessarily ship
with the ability to de-auth, as part of the 802.11 specification.

All said, use of this script is at your own risk. Use with caution.
 
    
