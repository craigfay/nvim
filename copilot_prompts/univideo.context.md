
Our org uses several video players and several analytics services for our web
apps. For intance, we might use JW Player or the Core Video SDK (CVSDK) to play
video, and send data about video playback to services like Adobe Heartbeat,
Parsely, or mParticle.

UniVideo is a virtual video player, which is an abstraction we use to limit the
amount of video player to analytics service integrations. Instead of writing
one integration for every combination of video player and analytics service, we
write "player adapters" that convert each player's native events and asset
metadata to the UniVideo interface, so that it looks like we only have one
video player, called UniVideo.

Then, we write "product adapters", which basically define event listeners,
which subscribe to instances of the UniVideo player, and use the emitted data
to send network requests to some 3rd party, usually using their JavaScript SDK.

"UniVideo Core" is our name for the script that exposes global values that
enable the player and product adapters to produce and consume univideo events.

