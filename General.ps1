# Set browser proxy usage
function Set-BrowserProxyUsage
(
	[switch] $useProxy
)
{
	$useProxySettingValueForIE = 0;
	if ($useProxy) { $useProxySettingValueForIE = 1; }

	set-location HKCU:\"Software\Microsoft\Windows\CurrentVersion\Internet Settings";
	set-itemproperty . ProxyEnable $useProxySettingValueForIE;
}


# Notepad++
function np
{
	if (test-path 'C:\Program Files\Notepad++') { &'C:\Program Files\Notepad++\Notepad++.exe' $args; }
}


# Ensure the following are in the path

# Ensure Git is on current path
if (! ($env:Path -contains 'C:\Program Files\Git\bin')) { $env:Path += ';C:\Program Files\Git\bin'; }

# Ensure Ruby.exe is on current path - Currently v1.9.1 but may need to support multiple versions soon
if (! ($env:Path -contains 'C:\ruby\Ruby191\bin')) { $env:Path += ';C:\ruby\Ruby191\bin'; }

