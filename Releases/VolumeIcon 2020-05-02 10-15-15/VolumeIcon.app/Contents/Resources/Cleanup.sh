#!/bin/sh

#  Cleanup.sh
#  VolumeIcon
#
#  Created by Ford on 5/2/20.
#  Copyright © 2020 fordApps. All rights reserved.

volname=$(defaults read /tmp/VolumeIconFlags.plist SelectedVolume)
volpath="/Volumes/"$volname
volpath=$(echo $volpath | sed 's/ /\\ /g')

rm $volpath/.VolumeIcon.icns
rm -R /tmp/volumeicon.bundle
