echo "Setting up cronjobs..."

baseDir=$(dirname $(readlink -f $0))/..

sudo mkdir -p /etc/cron.daily/
sudo cp $baseDir/cronjobs/* /etc/cron.daily/
