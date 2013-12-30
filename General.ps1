# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts
# Note: Paths here are for 64bit machines

# Change foreground colour if an admin
if (Test-IsCurrentUserAnAdministrator -and ($host.Name -eq 'ConsoleHost')) { $host.UI.RawUI.ForegroundColor = 'Green'; }

# Ensure the home environment variable is set as required by ssh etc
if($env:Home -eq $null)
{
	$homeValue = (join-path c:\users $env:UserName);

	# See http://technet.microsoft.com/en-us/library/ff730964.aspx for why we use the second command to make sure it is available immediately
	[Environment]::SetEnvironmentVariable('Home', $homeValue, 'User');
	$env:Home = $homeValue;
}

# Ensure TERM environment variable is set to avoid a less utility warning - See http://stackoverflow.com/questions/7949956/git-diff-not-working-terminal-not-fully-functional
# Had to use xterm to avoid shh issues such as when using the top command and getting a warning
$env:TERM = 'cygwin';

# Ensure the following are in the path - if they don't exist will ignore anyway
Extend-EnvironmentPath @(
	'c:\program files (x86)\git\bin',
	'c:\program files (x86)\vim\vim74',
	'c:\program files\microsoft sdks\windows\v7.1\bin',
	'c:\windows\microsoft.net\framework\v4.0.30319',
	'c:\program files\java\jdk1.7.0_25\bin',
	'd:\utilities\go\bin',
	'd:\utilities\mongodb\bin',
	'd:\utilities\node',
	'd:\utilities\putty', 				# putty environment - when using ssh directly from within powershell, vim and the sheel gets messed up regularly so i use putty
	'd:\utilities\SysinternalsSuite');

# Set up default ruby - included here as i expect to have on all my machines
Set-RubyEnvironment;

# RabbitMQ environment - Based on this - http://www.rabbitmq.com/install-windows-manual.html
#	Extracted download file and place contents in d:\utilities\rabbitmq-server
# 	PENDING - Possibly only if an admin or service user
if (test-path d:\utilities\rabbitmq_server)
{
	$erlangHomeValue = 'd:\utilities\erl';
	$rabbitMQServerValue = 'd:\utilities\rabbitmq_server';
	if($env:ERLANG_HOME -eq $null -or $env:RABBITMQ_SERVER -eq $null)
	{
		if (Test-IsCurrentUserAnAdministrator)
		{
			[Environment]::SetEnvironmentVariable('ERLANG_HOME', $erlangHomeValue, 'Machine');
			$env:ERLANG_HOME = $erlangHomeValue;
			[Environment]::SetEnvironmentVariable('RABBITMQ_SERVER', $rabbitMQServerValue, 'Machine');
			$env:RABBITMQ_SERVER = $rabbitMQServerValue;
		}
		else
		{
			write-host 'ERLANG_HOME and RABBITMQ_SERVER environment variables must be set at least once by an administrator';
		}
	}
	# Ensure the following are in the path - if they don't exist will ignore anyway
	Extend-EnvironmentPath "$erlangHomeValue\bin", "$rabbitMQServerValue\sbin";
}

# Redis environment - Based on this - https://github.com/MSOpenTech/redis and http://blogs.msdn.com/b/interoperability/archive/2013/04/22/redis-on-windows-stable-and-reliable.aspx
#	cd d:\oss
#	git clone https://github.com/MSOpenTech/redis.git msredis
#	cd msredis
#	Ensure we are on the correct branch i.e. git checkout -t origin/2.6
#	Open with VS2010
#		Switch to Release and x64
#		Build
#	Run the following
#		mkdir d:\utiliries\redis;
#		dir d:\oss\msredis\msvs\x64\Release *.exe | % { copy-item $_.fullname d:\utilities\redis -force }
Extend-EnvironmentPath d:\utilities\redis;

# Common aliases - assume they exist rather than cluttering with tests
set-alias devenv 'c:\program files (x86)\microsoft visual studio 11.0\common7\ide\devenv.exe';
set-alias gitk 'c:\program files (x86)\git\cmd\gitk.cmd';
set-alias np 'c:\program files (x86)\notepad++\notepad++.exe';


