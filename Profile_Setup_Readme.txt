# pmcgrath @ 20/03/2010
# Place this content in the $Profile.AllUsersAllHosts file so all users and all hosts have access to this
#	copy-item Profile_Setup_Readme.txt $profile.AllUsersAllHosts

# May need to consider the dot sourcing sequence in future in which case we can use a numeric prefix on the script file names
# May also look into using powershell modules

# Dot source all script files in the d:\poshprofile folder
push-location;
get-childitem d:\poshprofile *.ps1 | sort name | % { . $_.FullName; }
pop-location;