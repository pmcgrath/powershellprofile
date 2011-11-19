# pmcgrath @ 20/03/2010
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# RabbitMQ environment - Based on this - http://www.rabbitmq.com/install-windows-manual.html

# PENDING - Possibly only if an admin or service user 

# Machine level environment variables
[System.Environment]::SetEnvironmentVariable('ERLANG_HOME', 'c:\program files\erl5.8.5', 'Machine');
[System.Environment]::SetEnvironmentVariable('RABBITMQ_SERVER', 'd:\programfiles\rabbitmq_server-2.7.0', 'Machine');

# Extend path - so we can run rabbit commands from anywhere
Extend-EnvironmentPath @("$($env:RABBITMQ_SERVER)\sbin");

