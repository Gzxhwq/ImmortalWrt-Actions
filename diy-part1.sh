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
#sed -i '$a src-git mosdns https://github.com/Gzxhwq/openwrt-mos;dev' feeds.conf.default
sed -i '$a src-git my_packages https://github.com/Gzxhwq/openwrt-packages' feeds.conf.default
sed -i '$a src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' feeds.conf.default

#Add external packages
# svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/others/luci-app-amlogic
# svn co https://github.com/QiuSimons/openwrt-mos/trunk/v2ray-geodata package/others/v2ray-geodata

# svn co https://github.com/Gzxhwq/openwrt-passwall-packages/branches/sing-box-git/sing-box package/others/sing-box
git submodule add https://github.com/Gzxhwq/openwrt-packages.git package/others/my_packages
sed -i '/iptables-mod-socket/d' ./package/others/my_packages/sing-box/Makefile
# svn co https://github.com/Gzxhwq/openwrt-passwall-packages/branches/xray-core-git/xray-core package/others/xray-core
# svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/tuic-client package/others/tuic-client

# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/others/luci-app-passwall
# svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/others/luci-app-passwall2

git submodule add https://github.com/jerrykuku/luci-app-argon-config.git package/others/luci-app-argon-config
git submodule add https://github.com/jerrykuku/luci-theme-argon.git package/others/luci-theme-argon
git submodule add https://github.com/ophub/luci-app-amlogic.git package/others/luci-app-amlogic
git submodule add https://github.com/xiaorouji/openwrt-passwall.git package/others/luci-app-passwall
git submodule add https://github.com/xiaorouji/openwrt-passwall2.git package/others/luci-app-passwall2