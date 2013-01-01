# pmcgrath @ 1/01/2012
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# aws environment

# Ensure the following are in the path - if they don't exist will ignore anyway
function Connect-ToEc2Instance
(
	[string] $machineName,														# Dns name i.e. ec2-54-228-14-193.eu-west-1.compute.amazonaws.com
	[string] $keyFilePath	= "$($env:home)\.aws\$($env:username)_aws_keys.ppk"
)
{
	putty.exe -ssh -i $keyFilePath "ubuntu@$machineName";
}

