svc_check.sh

Just a really quick service check script I had to write to keep an ancient inherited tomcat app running.  Adaptable to check any service and perform actions based on output of 'service &lt;svc&gt; status'. 

This script is designed to be run via cron and check the status of a
service utilizing the system 'service' command at user-defined intervals.

It's might be a good idea to name the script something like
check_&lt;SVC&gt;.sh where &lt;SVC&gt; is the service name.

Example cron line:
 */5 * * * * /root/bin/check_&lt;SVC&gt;.sh > /dev/null 2>&1

Written by: George M. Grindlinger (gmg128@oit.rutgers.edu)



