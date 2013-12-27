echo "Installing Compiz..."

sudo apt-get install \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    --yes

sudo apt-get install \
    compizconfig-settings-manager \
    fusion-icon \
    compiz-plugins-extra \
    libdecoration0-dev \
    --yes
