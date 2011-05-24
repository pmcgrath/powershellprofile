# Functions
function Set-BrowserProxyUsage
(
	[switch] $useProxy
)
{
	$useProxySettingValueForIE = 0;
	if ($useProxy) { $useProxySettingValueForIE = 1; }

	push-location;
	
	set-location HKCU:\"software\microsoft\windows\currentversion\internet settings";
	set-itemproperty . ProxyEnable $useProxySettingValueForIE;
	
	pop-location;
}

function Extend-EnvironmentPath
(
	[string[]] $additions
)
{
	$additions | % { if (! ($env:Path.Contains($_))) { $env:Path += ";$_"; }}
}

function Set-RubyEnvironment
(
	[string] $version	= '192_p136'
)
{
	$newRubyEnvironmentPath = "c:\ruby\ruby$version\bin";
	if (! (test-path $newRubyEnvironmentPath)) { throw "Path for ruby v$version does not exist ($newRubyEnvironmentPath)"; }
	
	# Can use this to see current version if any's load paths - helps to identify the location : ruby -e 'puts $:'
	$existingRubyPath = $env:path.Split(';') | ? { $_ -like "*\ruby*\bin" } | select -first 1;  # Ignores the fact that you may have multiple path entries for ruby
	
	if ($existingRubyPath) 	{ $env:Path = $env:Path.Replace($existingRubyPath, $newRubyEnvironmentPath); }
	else 					{ Extend-EnvironmentPath @($newRubyEnvironmentPath); }
}

function Test-IsCurrentUserAnAdministrator
{
	(new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole("Administrators");
}

# Change foreground colour if an admin
if (Test-IsCurrentUserAnAdministrator -and ($host.Name -eq 'ConsoleHost')) { $host.UI.RawUI.ForegroundColor = 'Red'; }

# Ensure the following are in the path - if they don't exist will ignore anyway
$pathAdditions = @();
$pathAdditions += 'c:\program files\git\bin';									# Git
$pathAdditions += 'c:\windows\microsoft.net\framework\v4.0.30319';				# .Net 4.0
Extend-EnvironmentPath $pathAdditions;

# Set up default ruby
Set-RubyEnvironment;

# Common aliases - assume they exist rather than clutering with tests
set-alias np "c:\program files\notepad++\notepad++.exe";
set-alias ie "c:\program files\internet explorer\iexplore.exe";
