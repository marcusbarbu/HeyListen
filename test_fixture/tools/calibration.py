import argparse
import time
import struct
import paho.mqtt.client as mqtt_client
import csv



class TestFixture:
    SERVO_STEP = 10
    SERVO_PERIOD_S = 4
    DATA_PERIOD_S = 0.2    
    CHASE_PERIOD_S = 0.5 
    FUDGE_FACTORS=[-2, 2, 0]

    def __init__(self, broker_addr, output_fname, mode="SERVO_STEP", chase_target=1, broker_port=1883):
        self.client = mqtt_client.Client()
        self.client.connect(broker_addr, port=broker_port)
        for i in range(3):
            self.client.subscribe('sensor{}/rssi'.format(i+1))
            self.client.publish('sensor{}/light'.format(i+1), 'off')

        self.servo_pos = -TestFixture.SERVO_STEP
        self.rssis = [0,0,0]
        self.next_servo_update_time = time.time()
        self.next_data_update_time = time.time()
        self.output = open(output_fname, 'w+')
        self.writer = csv.writer(self.output)
        self.writer.writerow(["Time", "ServoPos", "RSSI 1", "RSSI 2", "RSSI 3"])
        self.add_servo = True
        self.mode = mode
        self.target=chase_target
        self.update_servo()

        if self.mode == "CHASE":
            self.client.publish("sensor{}/light".format(self.target), "on")

    def update_servo(self):
        print("Updating servo to {}".format(self.servo_pos))
        pos = self.servo_pos
        if pos > 180 or pos < 0:
            return
        payload = struct.pack('<H', pos)
        self.client.publish("mover/pos", payload=payload)
    
    def parse_msg(self, userdata, msg):
        # print("parsing msg {}".format(msg))
        for i in range(3):
            if msg.topic == 'sensor{}/rssi'.format(i+1):
                self.rssis[i] = int(msg.payload) + TestFixture.FUDGE_FACTORS[i]
                # print("rssi {} is {}".format(i+1, msg.payload))
                return
    
    
    def write_row(self):
        row = []
        row.append(time.time())
        row.append(self.servo_pos)
        row += self.rssis
        self.writer.writerow(row)
    
    def servo_step(self):
        cur = time.time()
        if cur >= self.next_servo_update_time:
            if self.add_servo:
                self.servo_pos += TestFixture.SERVO_STEP
                if self.servo_pos >= 180:
                    self.add_servo = False
            else:
                self.servo_pos -= TestFixture.SERVO_STEP
                if self.servo_pos <= 0:
                    self.add_servo = True
            self.update_servo()
            self.next_servo_update_time = time.time() + TestFixture.SERVO_PERIOD_S

    def chase(self):
        target_list_index = self.target - 1
        target_rssi = self.rssis[target_list_index]
        last_pos = self.servo_pos
        print(self.rssis)
        if time.time() < self.next_servo_update_time:
            return
        self.next_servo_update_time = time.time() + TestFixture.CHASE_PERIOD_S
        if target_rssi == min(self.rssis):
            pass
            # print("at target")
        elif self.rssis[target_list_index + 1] < target_rssi:
            print("minus")
            self.servo_pos -= TestFixture.SERVO_STEP
            if self.servo_pos <= 0:
                self.servo_pos = 0
                print("out of range towards 0")
            if last_pos != self.servo_pos:
                self.update_servo()
        elif self.rssis[target_list_index - 1] < target_rssi:
            print("plus")
            self.servo_pos += TestFixture.SERVO_STEP
            if self.servo_pos >= 180:
                self.servo_pos = 180 
                print("out of range towards 180")
            if last_pos != self.servo_pos:
                self.update_servo()


    def loop(self):
        if self.mode == "SERVO_STEP":
            self.servo_step()
        elif self.mode == "CHASE":
            self.chase()
        cur = time.time()
        if cur >= self.next_data_update_time:
            self.write_row()
            self.next_data_update_time = time.time() + TestFixture.DATA_PERIOD_S
        # print("Started loop at {}".format(time.time()))
        stat = self.client.loop()
        # print("loop status: {}".format(stat))
        # print("Ended loop at {}".format(time.time()))

                        
# tf = TestFixture("10.0.0.1", "chaseoutput.csv", mode="CHASE", chase_target=2)
tf = TestFixture("10.0.0.1", "reconly_3.csv", mode="RECORD", chase_target=2)
def handle_msg(client, userdata, message):
    # print("In handle msg")
    tf.parse_msg(userdata, message)

# print(tf.client)
tf.client.on_message = handle_msg

while True:
    tf.loop()
    time.sleep(0.0001)