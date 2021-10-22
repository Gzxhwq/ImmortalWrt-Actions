#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
sed -i '$a src-git mosdns https://github.com/Gzxhwq/openwrt-mos;dev' feeds.conf.default

#Add external packages
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/others/luci-app-amlogic