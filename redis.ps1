# pmcgrath @ 29/08/2012
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Redis environment - Based on this - https://github.com/MSOpenTech/redis and http://blogs.msdn.com/b/interoperability/archive/2013/04/22/redis-on-windows-stable-and-reliable.aspx
#						git clone https://github.com/MSOpenTech/redis.git
#						Ensure we are on the correct branch i.e. git checkout -t origin/2.6
#						Open with VS2010
#							Switch to Release and x64
#							Build
#						Run the following - dir d:\utilities\redis\redis\msvs\x64\Release *.exe | % { copy-item $_.fullname d:\utilities\redis -force }

# Ensure the following are in the path - if they don't exist will ignore anyway
Extend-EnvironmentPath @("d:\utilities\redis");
