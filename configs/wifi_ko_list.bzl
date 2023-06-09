load("//driver_modules/wifi_bt/wifi:configs/wifi_module_list.bzl", "wifi_modules_list")

#print(wifi_modules_list)

wifi_ko_list = []

def module_to_ko(module):
    if module == "qca6174":
        wifi_ko_list.append("wlan_6174.ko")
    elif module == "rtl8822cs":
        wifi_ko_list.append("8822cs.ko")
    elif module == "w1":
        wifi_ko_list.append("aml_sdio.ko")
        wifi_ko_list.append("vlsicomm.ko")
    elif module == "w2":
        wifi_ko_list.append("w2_comm.ko")
        wifi_ko_list.append("w2.ko")
    elif module == "w1u":
        wifi_ko_list.append("w1u_comm.ko")
        wifi_ko_list.append("w1u.ko")
    elif module == "rtl8723du":
        wifi_ko_list.append("8723du.ko")
    elif module == "rtl8723bu":
        wifi_ko_list.append("8723bu.ko")
    elif module == "rtl8821cu":
        wifi_ko_list.append("8821cu.ko")
    elif module == "rtl8822cu":
        wifi_ko_list.append("88x2cu.ko")
    elif module == "rtl8822eu":
        wifi_ko_list.append("8822eu.ko")
    elif module == "rtl8822cs":
        wifi_ko_list.append("8822cs.ko")
    elif module == "rtl8821cs":
        wifi_ko_list.append("8821cs.ko")
    elif module == "rtl8852be":
        wifi_ko_list.append("8852be.ko")
    elif module == "rtl8852bs":
        wifi_ko_list.append("8852bs.ko")
    elif module == "ap6181":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6335":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6335":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6234":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6255":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6256":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6271":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6212":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6354":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6356":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6398s":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6275s":
        wifi_ko_list.append("dhd.ko")
    elif module == "bcm4358_s":
        wifi_ko_list.append("dhd.ko")
    elif module == "bcm43458_s":
        wifi_ko_list.append("dhd.ko")
    elif module == "bcm43751_s":
        wifi_ko_list.append("dhd.ko")
    elif module == "ap6269":
        wifi_ko_list.append("bcmdhd.ko")
    elif module == "ap62x8":
        wifi_ko_list.append("bcmdhd.ko")
    elif module == "ap6275p":
        wifi_ko_list.append("dhdpci.ko")
    elif module == "ap6275hh3":
        wifi_ko_list.append("dhdpci.ko")
    elif module == "sd8987":
        wifi_ko_list.append("mlan_sd8987.ko")
        wifi_ko_list.append("moal_sd8987.ko")
    elif module == "sd8997":
        wifi_ko_list.append("mlan_sd8997.ko")
        wifi_ko_list.append("moal_sd8997.ko")
    elif module == "iw620":
        wifi_ko_list.append("mlan_iw620.ko")
        wifi_ko_list.append("moal_iw620.ko")
    elif module == "mt7661":
        wifi_ko_list.append("wlan_mt7663_sdio.ko")
    elif module == "mt7668u":
        wifi_ko_list.append("wlan_mt76x8_usb.ko")
    elif module == "mt7668":
        wifi_ko_list.append("wlan_mt76x8_sdio.ko")
    elif module == "mt7663u":
        wifi_ko_list.append("wlan_mt7663_usb.ko")
        wifi_ko_list.append("wlan_mt7663_usb_prealloc.ko")
    elif module == "uwe5621ds":
        wifi_ko_list.append("uwe5621_bsp_sdio.ko")
        wifi_ko_list.append("sprdwl_ng.ko")
    elif module == "qca206x":
        wifi_ko_list.append("wlan_cnss_core_pcie_206x.ko")
        wifi_ko_list.append("wlan_resident_206x.ko")
        wifi_ko_list.append("wlan_206x.ko")
    else:
        print("error",module,"module not support")

def get_wifi_ko_list():
    for module in wifi_modules_list:
        module_to_ko(module)

get_wifi_ko_list()


wifi_list = []
[wifi_list.append(i) for i in wifi_ko_list if not i in wifi_list]

#print(wifi_list)
