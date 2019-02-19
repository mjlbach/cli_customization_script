install_apt_packages(){
    requirements=(git perl protobuf-compiler libprotobuf-dev libncurses5-dev zlib1g-dev libutempter-dev libssl-dev pkg-config)
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
    git clone https://github.com/mobile-shell/mosh.git
    cd mosh
    autoreconf -i
    ./configure --prefix=$HOME/local
    make
    make install
    cd ..
    rm -rf mosh
}

install_apt_packages
install_mosh
