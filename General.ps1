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


# Set ruby environment
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


# Ensure the following are in the path
$pathAdditions = @();
$pathAdditions += 'c:\program files\git\bin';									# Git
$pathAdditions += 'c:\windows\microsoft.net\framework\v4.0.30319';				# .Net 4.0
Extend-EnvironmentPath $pathAdditions;

# Set up default ruby
Set-RubyEnvironment;