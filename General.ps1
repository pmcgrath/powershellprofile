# Set browser proxy usage - does not alter already running instances of IE
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


# Notepad++
function NP
{
	if (test-path 'c:\program files\notepad++') { &'c:\program files\notepad++\notepad++.exe' $args; }
}


# Extend environment path
function Extend-EnvironmentPath
(
	[string[]] $additions
)
{
	$additions | % { if (! ($env:Path.Contains($_))) { $env:Path += ";$_"; }}
}


# Ensure the following are in the path
$pathAdditions = @();
$pathAdditions += 'c:\program files\git\bin';									# Git
$pathAdditions += 'c:\windows\microsoft.net\framework\v4.0.30319';				# .Net 4.0
$pathAdditions += 'c:\ruby\ruby192\bin';										# Ruby 1.9.2 - May need to support multiple versions soon, can use this to see current location : ruby -e 'puts $:'
Extend-EnvironmentPath $pathAdditions;
