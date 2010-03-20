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