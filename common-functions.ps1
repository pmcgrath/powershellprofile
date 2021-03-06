# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Common functions - should be the first file sourced
function Connect-ToEc2Instance
(
	[string] $machineName,														# Dns name i.e. ec2-54-228-14-193.eu-west-1.compute.amazonaws.com
	[string] $keyFilePath	= "$($env:home)\.aws\$($env:username)_aws_keys.ppk"
)
{
	# Using putty instead of ssh directly as vim is pretty unusable when connecting using the powershell and ssh combination
	putty.exe -ssh -i $keyFilePath "ubuntu@$machineName";
}

function Extend-EnvironmentPath
(
	[string[]] $additions
)
{
	$additions | % { if (! ($env:Path.Contains($_))) { if (test-path $_) { $env:Path += ";$_"; } } }	# Can see existing with $env:Path.Split(';')
}

function Start-SshAgent
{
	# This is based on https://github.com/dahlbyk/posh-git
	# Ensure ssh agent is already running - will use one per session currently
	if (-not $env:SSH_AGENT_PID)
	{
		ssh-agent | ? { $_ -match '(?<key>[^=]+)=(?<value>[^;]+);' | % { $key = $matches['key']; $value =$matches['value']; set-item env:$key $value; } }
	}
}

function Add-SshAgentEntry
(
	[string] $keyPath	= "$home\.ssh\id_rsa"
)
{
	if (-not $env:SSH_AGENT_PID) { throw 'Ssh agent not started !'; }
	if (-not (test-path $keyPath)) { throw "keyPath [$keyPath] does not exist !"; }

	if (-not (ssh-add -l | ? { $_.contains($keyPath) })) { ssh-add $keyPath; }
}

function Set-RubyEnvironment
(
	[string] $version	= '2.0.0-p195'
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
(
	[string] $gitDirectoryPath
)
{
	# Was using "return @(dir (join-path $gitDirectoryPath '/refs/heads') -file).Length;" but git gc deletes files in /ref/heads as part of clean up
	return @(git branch).length;
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

function Widen-Window
(
	[int]	$resizeBy = 25
)
{
	$resizeByFactor = 1 + ($resizeBy / 100);

	$bufferSize = $host.UI.RawUI.BufferSize;
	$windowSize = $host.UI.RawUI.WindowSize;

	$bufferSize.Width = $bufferSize.Width * $resizeByFactor;
	$windowSize.Width = $windowSize.Width * $resizeByFactor;

	$host.UI.RawUI.BufferSize = $bufferSize;
	$host.UI.RawUI.WindowSize = $windowSize;
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
