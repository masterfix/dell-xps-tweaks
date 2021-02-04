#!/bin/bash

set -e
set -x

FIRMWARE_URL='https://github.com/kvalo/ath10k-firmware/raw/master/QCA6174/hw3.0/4.4.1.c3/firmware-6.bin_WLAN.RM.4.4.1.c3-00171'
FIRMWARE_MD5='65dd5fa98a2c7272bca97f47fca3445f'

BOARD_URL='https://github.com/kvalo/ath10k-firmware/raw/master/QCA6174/hw3.0/board-2.bin'
BOARD_MD5='30161abb0acc8bbd0cc65eb9872d85db'

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
