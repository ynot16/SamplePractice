#!/bin/sh

#  BulidScript.sh
#  BROnlineLearning
#
#  Created by bori－applepc on 16/8/25.
#  Copyright © 2016年 Bori Information Technology Co., Ltd. All rights reserved.

# 工程名
APP_NAME="BROnlineLearning"
# 证书
CODE_SIGN_DISTRIBUTION="iPhone Distribution: Guangzhou Bori Information Technology Co., Ltd."
# info.plist路径
project_infoplist_path="./${APP_NAME}/Info.plist"
# 取版本号
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")
# 取bulid值
budleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")

DATE="$(date +%Y%m%d)"
IPANAME="${APP_NAME}_V${bundleShortVersion}_${DATE}.ipa"

# 要上传的ipa文件路径
IPA_PATH="$HOME/${IPANAME}"
echo ${IPA_PATH}
echo "${IPA_PATH}">> test.txt

echo "=================clean================="
xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}" -configuration 'Release' clean

echo "=================build================="
xcodebuild -workspace "${APP_NAME}.xcworkspace" -scheme "${APP_NAME}" -sdk iphoneos -configuration 'Release' CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}" SYMROOT='$(PWD)'

xcrun -sdk iphoneos PackageAPPlication "./Release-iphoneos/${APP_NAME}.app" -o ~/"${IPANAME}"