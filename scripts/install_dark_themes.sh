echo "Installing LinuxMint dark themes..."

sudo add-apt-repository ppa:salience-team/salience-devel-ppa
sudo add-apt-repository ppa:noobslab/themes

sudo apt-get update --yes

sudo apt-get install salience-theme
sudo apt-get install delorean-dark
