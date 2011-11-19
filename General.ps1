# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Change foreground colour if an admin
if (Test-IsCurrentUserAnAdministrator -and ($host.Name -eq 'ConsoleHost')) { $host.UI.RawUI.ForegroundColor = 'Green'; }

# Ensure the following are in the path - if they don't exist will ignore anyway
Extend-EnvironmentPath @(
	'c:\program files\git\bin', 
	'c:\program files\microsoft sdks\windows\v7.1\bin', 
	'd:\utilities\linqpad', 
	'c:\windows\microsoft.net\framework\v4.0.30319');

# Set up default ruby
Set-RubyEnvironment;

# Common aliases - assume they exist rather than clutering with tests
set-alias devenv 'c:\program files\microsoft visual studio 10.0\common7\ide\devenv.exe';
set-alias gitk 'c:\program files\git\cmd\gitk.cmd';
set-alias ie 'c:\program files\internet explorer\iexplore.exe';
set-alias notepad 'c:\program files\notepad++\notepad++.exe';
set-alias np 'c:\program files\notepad++\notepad++.exe';
set-alias vim 'c:\program files\git\share\vim\vim73\vim.exe';
