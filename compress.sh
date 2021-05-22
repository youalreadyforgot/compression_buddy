#/bin/sh

## Group XZ, ZIP, GZ, TAR, and BZIP compression in one script
uncompress=false
isTar=false

##Check for installed packages (zip, bzip, xz, gzip, and tar)
if [ ! -e /usr/bin/gzip ]
then 
    echo "gzip not installed"
fi

if [ ! -e /usr/bin/zip ]
then 
    echo "zip not installed"
fi

if [ ! -e /usr/bin/xz ]
then 
    echo "xz not installed"
fi

if [ ! -e /usr/bin/bzip2 ]
then
    echo "bzip2 not installed"
fi

if [ ! -e /usr/bin/tar ]
then
    echo "tar not installed"
fi

## Grouping TAR with GZ?

##Read arguments
case $1 in
    "-u") uncompress=true;;

esac

##Distinguish file compression type
if [ -e $2 ]
then
    if [ uncompress == true ]
    then
    echo "Please specify a file"
    else 
    file=$2
    fi
fi

filetype="none"

##Parse .tar
if [[ $file = *".tar"* ]]
then
isTar=true
fi

##Parse .gz
if [[ $file = *".gz"* ]]
then
filetype=".gz"
fi

##Parse .xz
if [[ $file = *".xz"* ]]
then
filetype=".xz"
fi

##parse .bz2
if [[ $file = *".bz2"* ]]
then
filetype=".bz2"
fi

##parse .zip
if [[ $file = *".zip"* ]]
then
filetype=".zip"
fi

if [ $isTar == true ]
then
    case $filetype in
    ##Parse .tar.gz
    ".gz") filetype=".tar.gz";;
    ##Parse .tar.bz2
    ".bz2") filetype=".tar.bz2";;
    ##Parse .tar.xz
    ".xz") filetype=".tar.xz";;
esac
fi
if [ $uncompress == true ]
then
case $filetype in
    ".gz") gunzip $file;;
    ".tar.gz") tar -xvf $file;;
    ".xz") xz -d $file;;
    ".tar.xz") tar -xvf $file;;
    ".bz2") bzip2 -d $file;;
    ".zip") unzip $file;;
    ".tar") tar -x $file;;
esac
fi
