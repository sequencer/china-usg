import json
import sys
import urllib.request

with open(sys.argv[1], 'r+') as r:
    data = json.load(r)
    data["firewall"]["group"]["address-group"]["chnroutes2"]["address"] = []
    for line in urllib.request.urlopen("https://raw.githubusercontent.com/ym/chnroutes2/master/chnroutes.txt"):
        line = line.decode('ascii')[:-1]
        if not line.startswith("#"):
            data["firewall"]["group"]["address-group"]["chnroutes2"]["address"].append(line)
    with open(sys.argv[2], 'w') as w: 
        json.dump(data, w)