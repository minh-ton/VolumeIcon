#!/bin/sh

#  EVDetection.sh
#  VolumeIcon
#
#  Created by Ford on 3/1/20.
#  Copyright © 2020 MinhTon. All rights reserved.

FILE=$1
if [ -f $FILE ]; then
    echo "installer"
else
    echo "system"
fi
