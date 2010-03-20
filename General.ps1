function SetBrowserProxyUsage
(
	[switch] $useProxy
)
{
	$useProxySettingValueForIE = 0;

	if ($useProxy) {
		$useProxySettingValueForIE = 1;
	}

	cd HKCU:\"Software\Microsoft\Windows\CurrentVersion\Internet Settings";
	set-itemproperty . ProxyEnable $useProxySettingValueForIE;
}