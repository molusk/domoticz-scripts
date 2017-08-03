#!/bin/bash
echo CTRL A + CTRL Q pour quitter
sudo picocom -b 1200 -d 7 -p e -f n /dev/ttyAMA0
