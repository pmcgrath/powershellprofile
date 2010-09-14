$global:iPSTrunkPath = 'd:\svn\ccs\ips\trunk';


function Set-LocationToiPSTrunk
{
	set-location $global:iPSTrunkPath;
}


function Switch-ToiPSRuby
{
	# Can use this to see current location : ruby -e 'puts $:'
	$defaultRubyPath = 'c:\ruby\ruby192\bin';
	$iPSRubyPath = 'd:\svn\ccs\largedata\ruby\ruby192\bin';
	
	if ($env:Path.Contains($defaultRubyPath)) { $env:Path = $env:Path.Replace($defaultRubyPath, $iPSRubyPath); }
	elseif (! ($env:Path.Contains($iPSRubyPath))) { Extend-EnvironmentPath @($iPSRubyPath); }
}