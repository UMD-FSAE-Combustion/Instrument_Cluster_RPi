#!/bin/bash

export QT_PLUGIN_PATH=/opt/Qt/6.7.3/gcc_arm64/plugins
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_KMS_CONFIG=/home/dietpi/git/eglfs.json
cd /home/dietpi/git/release-ARM/
./app_Dash
