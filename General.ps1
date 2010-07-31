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
function np
{
	if (test-path 'c:\program files\notepad++') { &'c:\program files\notepad++\notepad++.exe' $args; }
}


# Ensure the following are in the path
# Ensure Git is on current path
if (! ($env:Path -contains 'c:\program files\git\bin')) { $env:Path += ';c:\program files\git\bin'; }

# Ensure Ruby.exe is on current path - Currently v1.9.1 but may need to support multiple versions soon
if (! ($env:Path -contains 'C:\ruby\ruby191\bin')) { $env:Path += ';c:\ruby\ruby191\bin'; }