#/bin/bash
vop=/opt/vyatta/bin/vyatta-op-cmd-wrapper
vcfg=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

#get chnroutes2 from ym/chnroutes2
external_chnroutes2_ip_list=$(curl https://raw.githubusercontent.com/ym/chnroutes2/master/chnroutes.txt | grep -v ^# |awk '{print $1}')

$vcfg begin
for ip in ${external_chnroutes2_ip_list}; do
    $vcfg set protocols static interface-route ${ip} next-hop-interface pppoe0 distance 1
done
$vcfg commit
$vcfg save
$vcfg end
