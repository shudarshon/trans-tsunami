#!/bin/bash
apt-get update --fix-missing
apt-get install language-pack-en cvs automake make autoconf gcc git -y
git clone https://github.com/cheetahmobile/tsunami-udp.git
cd tsunami-udp
/bin/bash recompile.sh
make install
