set -e
sudo apt update
sudo apt install -y opam libgmp-dev libcurl4-gnutls-dev
opam init --shell-setup -y

source ./build2.sh
