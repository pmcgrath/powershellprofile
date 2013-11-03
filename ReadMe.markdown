Clone into psprofile on d:\  
cd d:\  
git clone https://github.com/pmcgrath/powershellprofile.git psprofile  

Assumptions
* 64 bit machine
* d:\ exists
* d:\psprofile is location for profile
* Ruby default version is ruby-2.0.0-p195, not using pik to manage multiple versions
* Software is installed in very specific directories
	* d:\ruby
	* d:\utilities
		* d:\utilities\erl
		* d:\utilities\mongoodb
		* d:\utilities\node
		* d:\utilities\putty
		* d:\utilities\rabbitmq_server
		* d:\utilities\redis
		* d:\utilities\rubbies
