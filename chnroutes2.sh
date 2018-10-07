#/bin/bash
vop=/opt/vyatta/bin/vyatta-op-cmd-wrapper
vcfg=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

internal_chnroutes2_list=$($vop show firewall group chnroutes2 | grep -A5 Members |grep -v Members | awk '{ print $1 }' )

#get chnroutes2 from ym/chnroutes2
external_chnroutes2_ip_list=$(curl https://raw.githubusercontent.com/ym/chnroutes2/master/chnroutes.txt | grep -v ^# |awk '{print $1}')

if [ "$internal_chnroutes2_list" = "$external_chnroutes2_ip_list" ]; then
:
else
#if addresses have changed, remove address-group "chnroutes2" and recreate it with the new addresses
    $vcfg begin
    $vcfg delete firewall group address-group chnroutes2
    $vcfg set firewall group address-group chnroutes2 description "chnroutes2 IPs"
    for ip in ${external_chnroutes2_ip_list}; do
        $vcfg set firewall group address-group chnroutes2 address "$ip"
    done
    $vcfg commit
    $vcfg save
    $vcfg end
fi
