import argparse
import struct
import paho.mqtt.client as mqtt_client

parser = argparse.ArgumentParser()
parser.add_argument("pos", type=int)
args = parser.parse_args()

payload = struct.pack('<h', args.pos)


client = mqtt_client.Client()
client.connect("10.0.0.1")
client.publish("mover/pos", payload=payload)
