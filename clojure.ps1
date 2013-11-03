# pmcgrath @ 1/01/2013
# See Profile_Setup_Readme.txt - to make changes effective . $profile.allusersallhosts

# Clojure environment - Based on this - http://hemanthps.blogspot.com/2012/07/how-to-install-clojure-and-leiningen-on.html

# PENDING - Possibly only if an admin or service user
#			Currently only for current user, should probably set at the machine level

#$classPath = $env:CLASSPATH + '';
#('d:\utilities\clojure\clojure-1.4.0\clojure-1.4.0.jar', 'd:\utilities\clojure\lein\self-installs\leiningen-2.0.0-preview10-standalone.jar') | % {
#	if (!$classPath.Contains($_)) { $classPath += if ($classPath.Length -gt 0) { ';' }; $classPath += $_; }
#}
#$env:CLASSPATH = $classPath;

#$env:LEIN_JAR = 'd:\utilities\clojure\lein\self-installs\leiningen-2.0.0-preview10-standalone.jar';

# Ensure the following are in the path - if they don't exist will ignore anyway
#Extend-EnvironmentPath @('d:\utilities\clojure\lein');



https://github.com/technomancy/leiningen/blob/stable/doc/TUTORIAL.md
	https://github.com/dakrone/clj-http
	https://github.com/technomancy/leiningen/blob/stable/doc/PROFILES.md
	
	lein repl
	user=> (require '[clj-http.client :as http])
	user=> (def response (http/get 'http://leiningen.org'))
	