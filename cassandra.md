
cat >/etc/apt/sources.list.d/cassandra.list<<EOF
deb http://www.apache.org/dist/cassandra/debian 30x main
deb http://www.apache.org/dist/cassandra/debian 39x main
EOF

 apt update && apt install -y cassandra cassandra-tools


