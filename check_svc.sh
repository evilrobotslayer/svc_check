#!/bin/bash
#
# This script is designed to be run via cron and check the status of a
# service utilizing the system 'service' command at user-defined
# intervals.
#
# It's might be a good idea to name the script something like
# check_<SVC>.sh where <SVC> is the service name.
#
# Example cron line:
#  */5 * * * * /root/bin/check_<SVC>.sh > /dev/null 2>&1
# ------------------------------------------------------------------------
# Written by: George M. Grindlinger (gmg128@oit.rutgers.edu)
# ------------------------------------------------------------------------
##########################################################################

# Security first kids, hardcode your executable paths when running as root
ECHO_bin="/bin/echo"
LOGGER_bin="/usr/bin/logger"
SERVICE_bin="/usr/sbin/service"

# Get name of script for logging purposes
BASENAME="`basename $0`"

# Configure the service to monitor
SERVICE="tomcat6"

# Configure string to look for in the 'service' command output
# You can configure multiple patterns to take various state-based actions
# MSG1="*example of an extra pattern*"
MSG="*is not running, but pid file exists*"

# Configure the action to take
ACTION="restart"

# POSIX compliant - Should work in all shells
# Turns out 'case' has a surprising amount of utility...
# If multiple patterns defined above, they must be added below
# Example of an extra pattern:
# $MSG1) $LOGGER_bin -s -t "$BASENAME" "Service $SERVICE Up"; exit 5;;
case `$SERVICE_bin $SERVICE status` in
  $MSG) $LOGGER_bin -s -t "$BASENAME" "Service $SERVICE Down - Restarting"; 
          $SERVICE_bin $SERVICE $ACTION; exit 1;;
  *) exit 0;;           #Default case - MSG not present in status
esac

# If we get here something has gone very wrong
# We really should have exited within the CASE statement
# Check your executable definitions or that SERVICE can actually be polled
# by the 'service' command
$LOGGER_bin -s -t "$BASENAME" "ERROR: EOF Reached"
exit 99

