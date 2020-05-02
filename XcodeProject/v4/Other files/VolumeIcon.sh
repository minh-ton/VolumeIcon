#!/bin/sh

#  VolumeIcon.sh
#  VolumeIcon
#
#  Created by Ford on 5/1/20.
#  Copyright © 2020 fordApps. All rights reserved.

volname=$(defaults read /tmp/VolumeIconFlags.plist SelectedVolume)
volpath="/Volumes/"$volname
volpath=$(echo $volpath | sed 's/ /\\ /g')

iconfilename=$(defaults read /tmp/VolumeIconFlags.plist IconFileName)

if [[ $iconfilename == "Catalina" ]]; then
    cp -a /tmp/volumeicon.bundle/Catalina.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "Mojave" ]]; then
    cp -a /tmp/volumeicon.bundle/Mojave.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "HighSierra" ]]; then
    cp -a /tmp/volumeicon.bundle/HighSierra.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "Sierra" ]]; then
    cp -a /tmp/volumeicon.bundle/Sierra.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "ElCapitan" ]]; then
    cp -a /tmp/volumeicon.bundle/ElCapitan.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "Yosemite" ]]; then
    cp -a /tmp/volumeicon.bundle/Yosemite.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "Mavericks" ]]; then
    cp -a /tmp/volumeicon.bundle/Mavericks.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "MountainLion" ]]; then
    cp -a /tmp/volumeicon.bundle/MountainLion.icns $volpath/.VolumeIcon.icns
fi

if [[ $iconfilename == "Lion" ]]; then
    cp -a /tmp/volumeicon.bundle/Lion.icns $volpath/.VolumeIcon.icns
fi

rm -R /tmp/volumeicon.bundle
