#!/bin/bash

set -e
set -x

FIRMWARE_URL='https://github.com/kvalo/ath10k-firmware/raw/master/QCA6174/hw3.0/4.4.1/firmware-6.bin_WLAN.RM.4.4.1-00282-QCARMSWPZ-1'
FIRMWARE_MD5='414ba407420eb4d159218ee990acaaed'

BOARD_URL='https://github.com/kvalo/ath10k-firmware/raw/master/QCA6174/hw3.0/board-2.bin'
BOARD_MD5='91a7e2951c662c692d4797e0b9e457d1'

FIRMWARE_DIR='/lib/firmware/ath10k/QCA6174/hw3.0'
FIRMWARE_NAME='firmware-6.bin'
BOARD_NAME='board-2.bin'

cd /tmp

wget -O "$FIRMWARE_NAME" $FIRMWARE_URL
wget -O "$BOARD_NAME" $BOARD_URL

echo "$FIRMWARE_MD5 $FIRMWARE_NAME" | md5sum -c -
echo "$BOARD_MD5 $BOARD_NAME" | md5sum -c -

sudo cp "$FIRMWARE_DIR/$FIRMWARE_NAME" "$FIRMWARE_DIR/$FIRMWARE_NAME.bak"
sudo cp "$FIRMWARE_NAME" "$FIRMWARE_DIR/$FIRMWARE_NAME"

sudo cp "$FIRMWARE_DIR/$BOARD_NAME" "$FIRMWARE_DIR/$BOARD_NAME.bak"
sudo cp "$BOARD_NAME" "$FIRMWARE_DIR/$BOARD_NAME"

sudo update-initramfs -u
