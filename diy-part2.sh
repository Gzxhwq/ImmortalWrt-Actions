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
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/10.10.10.100/g' package/base-files/files/bin/config_generate

#Apply the patches
git apply $GITHUB_WORKSPACE/patches/*.patch

# Update mwan3helper's IP pools
wget https://ispip.clang.cn/all_cn_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/all_cn.txt
wget https://ispip.clang.cn/chinatelecom_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/chinatelecom.txt
wget https://ispip.clang.cn/unicom_cnc_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/unicom_cnc.txt
wget https://ispip.clang.cn/cmcc_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/cmcc.txt
wget https://ispip.clang.cn/crtc_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/crtc.txt
wget https://ispip.clang.cn/cernet_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/cernet.txt
wget https://ispip.clang.cn/gwbn_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/gwbn.txt
wget https://ispip.clang.cn/othernet_cidr.txt -O feeds/luci/applications/luci-app-mwan3helper/root/etc/mwan3helper/othernet.txt

# Change dnsproxy behavior
sed -i 's/--cache --cache-min-ttl=3600/--cache --cache-min-ttl=600/g' ./feeds/luci/applications/luci-app-turboacc/root/etc/init.d/turboacc

# Convert zh-cn to zh_Hans
bash <( curl -sSL https://build-scripts.immortalwrt.eu.org/convert_translation.sh )
bash <( curl -sSL https://build-scripts.immortalwrt.eu.org/create_acl_for_luci.sh ) -a
rm -rf ./tmp
