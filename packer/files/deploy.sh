#!/bin/bash
cd /home/appuser

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && sudo bundle install

sudo cat <<EOF> /etc/systemd/system/puma.service
[Unit]
Description=Full reddit app
Requires=mongod.service

[Service]
Type=simple
ExecStart=/usr/local/bin/puma
User=appuser
Group=appuser
WorkingDirectory=/home/appuser/reddit/

[Install]
WantedBy=multi-user.target

EOF

puma -d
sudo systemctl enable puma.service

sudo reboot
