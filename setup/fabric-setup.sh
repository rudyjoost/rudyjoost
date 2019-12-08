#!/bin/bash

# Copyright 2019 @ http://ACloudFan.com 
# Part of a online course. Please check it out at http://www.acloudfan.com
# Last update: Aug 31, 2019

if [ -z $SUDO_USER ]; then
    echo "Script MUST be executed with 'sudo -E'"
    echo "Abroting!!!"
    exit 0
fi

if [ -z $GOPATH ]; then
    echo "GOPATH not set!!! You must use 'sudo -E ./install-fabric.sh'"
    echo '(a) Log out and Log back in & try again'
    echo 'If issue is still there then (b) Check if go was installed    go version   (c) Check if GOPATH is set     echo $GOPATH '
    echo "Aborting!!!"
    exit 0
fi

export PATH=$PATH:$GOROOT/bin

echo "GOPATH=$GOPATH"
echo "GOROOT=$GOROOT"

# Execute in the setup folder
echo "=== Must execute in the setup folder ===="

cd ..

rm -rf misc

echo "====== Starting to Download Fabric ========"
#curl -sSL http://bit.ly/2ysbOFE | bash -s 1.2.0 1.2.0 0.4.10
curl -sSL http://bit.ly/2ysbOFE -o bootstrap.sh
chmod 755 *.sh
bash ./bootstrap.sh  1.4.1 1.4.1 0.4.10 

# ./bootstrap.sh  1.4.0 1.4.0 0.4.10 -d

#./bootstrap.sh  1.2.0 1.2.0 0.4.10 -d 


echo "======= Copying the binaries to /usr/local/bin===="
rm -rf ./bin 2> /dev/null
mv fabric-samples/bin       .
cp ./bin/*    /usr/local/bin


mkdir -p misc
mv fabric-samples ./misc

rm bootstrap.sh

# Change mode for all shell scripts
chmod 755 orderer/bins/*.sh
chmod 755 peers/bins/*.sh
chmod 755 fabric-ca/bins/*.sh
chmod 755 cloud/*.sh
chmod 755 cloud/bins/fabric-ca/*.sh
chmod 755 cloud/bins/orderer/*.sh
chmod 755 cloud/bins/peer/*.sh

echo "Please Log out & Log back in!!"