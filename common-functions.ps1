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
	[string] $version	= '2.0.0-p0'
)
{
	$newRubyEnvironmentPath = "d:\utilities\rubies\ruby-$version\bin";
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

function Get-GitDirectoryPath
{
	# Find .git directory if any in parental hierarchy, null if none found
    $directory = get-item .;
    while ($directory -ne $null) 
	{
        $potentialGitDirectoryPath = join-path $directory.FullName '.git';
		if (test-path $potentialGitDirectoryPath) { return $potentialGitDirectoryPath; } 
		
        $directory = $directory.Parent;
    }
	
	return $null;
}

function Get-GitBranchCount
{
	# Just local branches
	return @(dir (join-path $gitDirectoryPath /refs/heads) -file).Length;
}

function Get-GitBranchName
(
	[string] $gitDirectoryPath
)
{
	$branchNameLine = get-content (join-path $gitDirectoryPath 'HEAD') | select -first 1;
	return $branchNameLine.Replace('ref: refs/heads/', '');
}

function Get-GitInformation
{
	# This stuff is just content i have extracted from https://github.com/dahlbyk/posh-git
	# It is a much simplier version, which does not cater for all the stuff they do and certainly not submodules etc.
	$gitDirectoryPath = Get-GitDirectoryPath;
	if (-not $gitDirectoryPath) { return $null; }
	
	$branchCount = Get-GitBranchCount $gitDirectoryPath;
	$branchName = Get-GitBranchName $gitDirectoryPath;
	
	if ($branchCount -gt 1) { return "$branchCount*$branchName"; }
	return $branchName;
}

function prompt()
{
	# If not a file system then cannot be a git reposiotry so exit with default prompt
	if (($executionContext.SessionState.Path.CurrentLocation).Provider.Name -ne 'FileSystem')
	{
		# Can use the following to get existing prompt "(dir function:prompt).Definition" which is what we are returning here
		return "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1))";
	}
	
	# File system, so could be a git repository 
	$gitInformation = Get-GitInformation;

	$originalForegroundColour = $host.UI.RawUI.ForegroundColor;
    write-host "PS $pwd" -nonewline;
	if ($gitInformation)
	{ 
		$host.UI.RawUI.ForegroundColor = 'DarkCyan';
		write-host " [$gitInformation] " -nonewline;
		$host.UI.RawUI.ForegroundColor = $originalForegroundColour;
	};	
	
	# Must return a string
	'>';
}
