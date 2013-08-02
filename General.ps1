# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts
# Note: Paths here are for 64bit machines

# Change foreground colour if an admin
if (Test-IsCurrentUserAnAdministrator -and ($host.Name -eq 'ConsoleHost')) { $host.UI.RawUI.ForegroundColor = 'Green'; }

# Ensure the home environment variable is set as required by ssh etc
if($env:Home -eq $null)
{
	$homeValue = (join-path c:\users $env:UserName);

	# See http://technet.microsoft.com/en-us/library/ff730964.aspx for why we use the second command to make sure it is available immediately
	[Environment]::SetEnvironmentVariable('Home', $homeValue, 'User');
	$env:Home = $homeValue;
}

# Ensure TERM environment variable is set to avoid a less utility warning - See http://stackoverflow.com/questions/7949956/git-diff-not-working-terminal-not-fully-functional
# Had to use xterm to avoid shh issues such as when using the top command and getting a warning
$env:TERM = 'cygwin';

# Ensure the following are in the path - if they don't exist will ignore anyway
Extend-EnvironmentPath @(
	'c:\program files (x86)\git\bin',
	'c:\program files (x86)\vim\vim73\vim.exe',
	'c:\program files\microsoft sdks\windows\v7.1\bin',
	'c:\windows\microsoft.net\framework\v4.0.30319',
	'd:\utilities\node');

# Set up default ruby - included here as i expect to have on all my machines
Set-RubyEnvironment;

# Common aliases - assume they exist rather than cluttering with tests
set-alias devenv 'c:\program files (x86)\microsoft visual studio 10.0\common7\ide\devenv.exe';
set-alias gitk 'c:\program files (x86)\git\cmd\gitk.cmd';
set-alias np 'c:\program files (x86)\notepad++\notepad++.exe';
