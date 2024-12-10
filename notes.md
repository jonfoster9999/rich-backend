RAILS_ENV=production nohup puma > puma.log 2>&1 &

sudo systemctl daemon-reload
sudo systemctl restart puma


sudo systemctl start puma.service
sudo systemctl stop puma.service
sudo systemctl restart puma.service
sudo systemctl status puma.service