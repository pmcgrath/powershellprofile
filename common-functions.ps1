# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Common functions - should be the first file sourced 
function Set-BrowserProxyUsage
(
	[switch] $useProxy
)
{
	$useProxySettingValueForIE = 0;
	if ($useProxy) { $useProxySettingValueForIE = 1; }

	push-location;	
	set-location 'HKCU:\software\microsoft\windows\currentversion\internet settings';
	set-itemproperty . ProxyEnable $useProxySettingValueForIE;
	pop-location;
}

function Extend-EnvironmentPath
(
	[string[]] $additions
)
{
	$additions | % { if (! ($env:Path.Contains($_))) { $env:Path += ";$_"; }}	# Can see existing with $env:Path.Split(';')
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
	(new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole('Administrators');
}

function Goto-oss
{
	set-location d:\oss;
}
