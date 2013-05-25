# pmcgrath @ 29/08/2012
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# RabbitMQ environment - Based on this - http://www.rabbitmq.com/install-windows-manual.html
#							Extracted download file and place contents in d:\utilities\rabbitmq-server

# PENDING - Possibly only if an admin or service user 

$erlangHomeValue = 'd:\utilities\erl';
$rabbitMQServerValue = 'd:\utilities\rabbitmq-server';

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
Extend-EnvironmentPath @(
	"$erlangHomeValue\bin",
	"$rabbitMQServerValue\sbin");
