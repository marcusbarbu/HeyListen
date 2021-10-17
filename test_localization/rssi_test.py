import subprocess
import logging
import time
import csv


def get_raw_iw_scan():
    res = subprocess.run("sudo iwlist scan", shell=True, check=True, capture_output=True)
    return res.stdout

def get_raw_from_proc():
    with open('/proc/net/wireless', 'r') as pw:
        raw = pw.read()
    lines = raw.split('\n')[2:]
    status = {}
    for line in lines:
        if len(line) > 1:
            items = line.split()
            # print(items)
            ap_name = items[0].replace(':', '')
            rssi = items[3]
            # print(rssi)
            status[ap_name] = float(rssi)
    return status

def record_over_time(test_time):
    now = time.time()
    end = time.time() + test_time
    record = []
    apset = set()
    while time.time() < end:
        now = time.time()
        status = get_raw_from_proc()
        aps = status.keys()
        for a in aps:
            apset.add(a)
        status['time'] = now
        print(status)
        record.append(status)
        time.sleep(0.1)
    return record, list(apset)


if __name__ == '__main__':
    # get_raw_iw_scan()
    # print(get_raw_from_proc())
    # print(get_raw_from_proc())
    # rot, aps = record_over_time(20)
    rot, aps = record_over_time(20)
    print(rot)
    with open('testout.csv', 'w') as csvout:
        fieldnames = ['time'] + aps
        writer = csv.DictWriter(csvout, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rot)
