#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# Add luci-app-amlogic
#svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

#Apply the patches
git apply $GITHUB_WORKSPACE/patches/*.patch

# Use default banner
#sed -i -e "/openwrt_banner/i\sed -i 's/lean & lienol/ImmortalWrt/g' /etc/banner" \
#-e '/openwrt_banner/d' package/emortal/default-settings/files/zzz-default-settings

# Update mwan3helper's IP pools
#wget https://raw.githubusercontent.com/Gzxhwq/geoip/release/geoip-only-cn-private.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/all_cn.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/chinanet.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/chinatelecom.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/unicom.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/unicom_cnc.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/cmcc.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/cmcc.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/tietong.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/crtc.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/cernet.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/cernet.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/drpeng.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/gwbn.txt
#wget https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/cstnet.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/othernet.txt

# Change dnsproxy behave
sed -i 's/--cache --cache-min-ttl=3600/--cache --cache-min-ttl=600/g' ./feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc


# 1.Set the download repository of the OpenWrt files to your github.com
sed -i "s|https.*/OpenWrt|https://github.com/Gzxhwq/ImmortalWrt-Actions|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 2.Set the keywords of Tags in your github.com Releases
sed -i "s|ARMv8|Phicomm_N1|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 3.Set the suffix of the OPENWRT files in your github.com Releases
#sed -i "s|.img.gz|.OPENWRT_SUFFIX|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 4.Set the download path of the kernel in your github.com repository
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/tree/main/opt/kernel|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 5.Set default filesystem in your github.com repository
sed -i "s|ext4|btrfs|g" package/others/luci-app-amlogic/root/etc/config/amlogic
# 6.Extend backup file list in openwrt-backup script
sed -i '/\.\/root\/\.ssh\//i./etc/keepalived/ \\' package/others/luci-app-amlogic/root/usr/sbin/openwrt-backup
sed -i '/\.\/root\/\.ssh\//i./etc/conntrackd/ \\' package/others/luci-app-amlogic/root/usr/sbin/openwrt-backup
sed -i '/\.\/root\/\.ssh\//i./etc/bird.conf \\' package/others/luci-app-amlogic/root/usr/sbin/openwrt-backup

# Convert zh-cn to zh_Hans
bash <( curl -sSL https://build-scripts.immortalwrt.eu.org/convert_translation.sh )
bash <( curl -sSL https://build-scripts.immortalwrt.eu.org/create_acl_for_luci.sh ) -a
rm -rf ./tmp
