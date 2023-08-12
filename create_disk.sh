HASH="f3842efb3be1be4243c24203bd16e335f155fdbe104b1ed8c5efc548ea478ab0"
URL="https://cdimage.ubuntu.com/releases/22.04.3/release/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img.xz"

CACHE=".cache"
FILE="${URL##*/}"
FILENAME="${FILE%.*}"

diskutil list

read -p 'Disk (ex. disk4): ' disk

if [ ! -f "$CACHE/$FILE" ]; then
  echo "Downloading Image"
  mkdir -p $CACHE
  curl -o "$CACHE/$FILE" $URL
fi

echo "$HASH" "*$CACHE/$FILE" | shasum -a 256 --check || exit

read -p "Confirm writing disk (y/N): "
if [ "$REPLY" != "y" ]; then
   exit
fi

echo Unmounting Disk
sudo diskutil unmountDisk /dev/$disk

echo Decompressing img file
shasum -c $CACHE/SHA256SUMS || unxz -vkf $CACHE/$FILE && shasum -a 256 $CACHE/$FILE > $CACHE/SHA256SUMS

echo Writing img to /dev/r$disk
sudo dd bs=1M if=$CACHE/"${FILE%.*}" of=/dev/r$disk status=progress conv=fsync

echo Creating TEMP directory
tempdir=`mktemp -d`

echo Mounting disk to $tempdir
sudo diskutil unmountDisk /dev/$disk
sudo diskutil mount -mountPoint $tempdir /dev/${disk}s1

echo Copying files to disk
sudo cp -Rv files/* $tempdir

echo Unmounting $disk
sleep 1
sudo diskutil unmount /dev/${disk}s1

echo Remove TEMP directory
rm -rf $tempdir
