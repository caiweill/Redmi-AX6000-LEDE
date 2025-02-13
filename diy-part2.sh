#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 默认 IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/luci2/bin/config_generate

## luci-app-adguardhome
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

## 安装前置 mosdns
rm -rf feeds/packages/lang/golang
rm -rf feeds/packages/net/mosdns
rm -rf package/feeds/packages/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf package/feeds/packages/v2ray-geodata
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

## 获取隔空播放luci-app-airconnect
git clone https://github.com/sbwml/luci-app-airconnect package/airconnect

## 获取ddns-go
#git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go

## OpenClash
git clone --depth 1 https://github.com/vernesong/openclash.git OpenClash
rm -rf feeds/luci/applications/luci-app-openclash
mv OpenClash/luci-app-openclash feeds/luci/applications/luci-app-openclash

# 安装插件
# echo "CONFIG_PACKAGE_luci-i18n-autotimeset-zh-cn=y" >> .config

# 更改默认主题背景
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
#cp -f $GITHUB_WORKSPACE/images/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# ttyd自动登录
sed -i "s?/bin/login?/usr/libexec/login.sh?g" feeds/packages/utils/ttyd/files/ttyd.config

# 调整菜单
#sed -i 's/services/control/g' feeds/luci/applications/luci-app-eqos/root/usr/share/luci/menu.d/*.json
#sed -i 's/services/control/g' feeds/luci/applications/luci-app-nft-qos/luasrc/controller/*.lua
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-ksmbd/root/usr/share/luci/menu.d/*.json
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/view/openclash/*.htm
#sed -i 's|admin/network|admin/control|g' package/luci-app-sqm/root/usr/share/luci/menu.d/*.json

# 修改插件名字
#replace_text() {
#  search_text="$1" new_text="$2"
#  sed -i "s/$search_text/$new_text/g" $(grep "$search_text" -rl ./ 2>/dev/null) || echo -e "\e[31mNot found [$search_text]\e[0m"
#}
#。 msgstr "MosDNS"

#replace_text "Argon 主题设置" "主题设置"
#replace_text "DDNS-Go" "DDNSGO"
#replace_text "DDNSTO 远程控制" "DDNSTO"
#replace_text "KMS 服务器" "KMS激活"
#replace_text "QoS Nftables 版" "QoS管理"
#replace_text "SQM 队列管理" "SQM管理"
#replace_text "动态 DNS" "动态DNS"
#replace_text "网络存储" "NAS"
#replace_text "解除网易云音乐播放限制" "音乐解锁"

#echo -e "\e[32m$0 [DONE]\e[0m"

