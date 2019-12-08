# setup go & use it for setting up the Fabric CA Binaries
# Copyright 2018 @ http://ACloudFan.com 
# Part of a online course. Please check it out at http://www.acloudfan.com

if [ -z $SUDO_USER ]
then
    echo "===== Script need to be executed with sudo ===="
    echo "Change directory to 'setup'"
    echo "Usage: sudo ./caserver.sh"
    exit 0
fi


if [ -z $GOPATH ]; then
    echo "GOPATH not set!!! You may execute (a) sudo  ./go.sh (b) Log out and Log back in & try again"
    echo 'If issue is still there then (a) Check if go was installed    go version   (b) Check if GOPATH is set     echo $GOPATH '
    echo "Aborting!!!"
    exit 0
fi

# Check if there is a need to install GoLang
if hash go 2>/dev/null; then
        echo "====PLEASE be patient - it takes time!!====="
else
         echo "GoLang NOT installed. Abroting!!!!"
fi


# Get the Fabric CA binaries
echo "++++Fetching Fabric CA Binaries"
go get -u github.com/hyperledger/fabric-ca/cmd/...

# Move the binaries
echo "+++Moving Fabric CA Binaries"
sudo rm /usr/local/fabric-ca-*  2> /dev/null
sudo cp $GOPATH/bin/fabric-ca-* $PWD/../bin
sudo mv $GOPATH/bin/fabric-ca-*    /usr/local/bin

echo "Done."
echo "Validate by running>>   fabric-ca-server   version"


