ARG VERSION
FROM telegraf:${VERSION}

RUN export  DEBIAN_FRONTEND=noninteractive && \
     export DEBIAN_RELEASE=$(awk -F'[" ]' '/VERSION=/{print $3}'  /etc/os-release | tr -cd '[[:alnum:]]._-' ) && \
     echo "remove main from /etc/apt/sources.list" && \
     sed -i '/main/d' /etc/apt/sources.list && \
     echo "remove contrib from /etc/apt/sources.list" && \
     sed -i '/contrib/d' /etc/apt/sources.list && \
     echo "remove non-free from /etc/apt/sources.list" && \
     sed -i '/non-free/d' /etc/apt/sources.list && \
     echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE} main contrib non-free"  >> /etc/apt/sources.list && \
     echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE}-updates main contrib non-free"  >> /etc/apt/sources.list && \
     echo "deb http://security.debian.org ${DEBIAN_RELEASE}/updates main contrib non-free"  >> /etc/apt/sources.list && \
    set -x && \
    apt-get update && \
    apt-get -y install snmp-mibs-downloader unzip && \
    wget https://www.juniper.net/techpubs/software/junos/junos212/juniper-mibs-21.2R1.10.zip -O juniper-mibs-21.2R1.10.zip && unzip juniper-mibs-21.2R1.10.zip && \
    mv JuniperMibs/* /usr/share/snmp/mibs/ && \
    rm -r /var/lib/apt/lists/*