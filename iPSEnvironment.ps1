$global:iPSTrunkPath = 'd:\svn\ccs\ips\trunk';


function Set-LocationToiPSTrunk
{
	set-location $global:iPSTrunkPath;
}


function Switch-ToiPSRuby
{
	# Can use this to see current location : ruby -e 'puts $:'
	$iPSRubyPath = 'd:\svn\ccs\largedata\ruby\ruby192_p136\bin';
	
	$existingRubyPath = $env:path.Split(';') | ? { $_ -like "*\ruby*\bin" } | select -first 1;  # Ignores the fact that you may have multiple path entries for ruby
	
	if ($existingRubyPath) 	{ $env:Path = $env:Path.Replace($existingRubyPath, $iPSRubyPath); }
	else 					{ Extend-EnvironmentPath @($iPSRubyPath); }
}