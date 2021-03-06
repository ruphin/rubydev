#!/usr/bin/env bash

# Configure the user
ID=`stat -c '%u' /app`
GID=`stat -c '%g' /app`
if [ -z "$ID" ] || [ -z "$GID" ]; then
	echo "Failed to detect the user or group ID for the app"
	exit 1
fi

if [ "$ID" == "0" ]; then
	echo "WARNING: Running as root"
	chown -R root:root /home/app
	sync

	gosu root /home/app/run.sh $1
else
	usermod -u $ID app
	groupmod -g $GID app
	chown -R app:app /home/app
	chown -R app:app /root
	sync

  echo "$1"
  if [ "$1" == "root" ]; then
    cd /app
    exec bash
  else
	   gosu app /home/app/run.sh $@
   fi
fi
