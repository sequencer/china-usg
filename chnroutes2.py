import json
import sys
import urllib.request

with open(sys.argv[1], 'r+') as r:
    data = json.load(r)
    for line in urllib.request.urlopen("https://raw.githubusercontent.com/ym/chnroutes2/master/chnroutes.txt"):
        line = line.decode('ascii')[:-1]
        if not line.startswith("#"):
            data["protocols"]["static"]["interface-route"][line] = {"next-hop-interface": {"pppoe0": {"distance": 1}}}
    with open(sys.argv[2], 'w') as w:
        json.dump(data, w)
