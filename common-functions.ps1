# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Common functions - should be the first file sourced 
function Extend-EnvironmentPath
(
	[string[]] $additions
)
{
	$additions | % { if (! ($env:Path.Contains($_))) { $env:Path += ";$_"; }}	# Can see existing with $env:Path.Split(';')
}

function Start-SshAgent
{
	# This is based on https://github.com/dahlbyk/posh-git
	# Ensure ssh agent is already running - will use one per session currently
	if (-not $env:SSH_AGENT_PID)
	{
		ssh-agent | ? { $_ -match '(?<key>[^=]+)=(?<value>[^;]+);' | % { $key = $matches['key']; $value =$matches['value']; set-item env:$key $value; } }
	}
	
	# Add entry if key exists and no entry already - assuming the name and location of key is default
	if (test-path ~/.ssh/id_rsa)
	{
		if (-not (ssh-add -l | ? { $_ -match ".*/users/$env:UserName/\.ssh/id_rsa" }))
		{
			ssh-add ~/.ssh/id_rsa;
		}
	}
}

function Set-RubyEnvironment
(
	[string] $version	= '1.9.3-194'
)
{
	$newRubyEnvironmentPath = "d:\ruby\ruby-$version\bin";
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
