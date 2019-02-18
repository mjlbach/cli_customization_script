install_apt_packages(){
    requirements=(perl protobuf-compiler libprotobuf-dev libncurses5-dev zlib1g-dev libutempter-dev libssl-dev pkg-config)
    sudo apt update
    for package in ${requirements[@]}; do
        dpkg -s "$package" >/dev/null 2>&1 && {
            echo "$package is installed."
        } || {
            sudo apt-get -y install $package
        }
    done
}

install_mosh(){
    curl -LO https://mosh.org/mosh-1.3.2.tar.gz
    tar -xzf mosh-1.3.2.tar.gz
    cd mosh-1.3.2
    ./configure --prefix=$HOME/local
    make
    make install
    cd $HOME
    rm -rf mosh-1.3.2
}

install_apt_packages
install_mosh
