#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Servo.h>

// #define DEBUG_BUILD 1

#define NAME "mover"

#define SSID "testnet"
#define MQTT_SERVER "10.0.0.1"
#define MQTT_PORT 1883

#define MQTT_TOPIC_OUT "mover/dbg"
#define MQTT_TOPIC_DBG "mover/dbg"
#define MQTT_TOPIC_IN "mover/pos"

#define PUBLISH_PERIOD_MS 200
#define BUF_SIZE 16


IPAddress staticIP(10, 0, 0, 9);
IPAddress gateway(10, 0, 0, 1);
IPAddress subnet(255,255,255,0);
IPAddress dns(8,8,8,8);

WiFiClient espClient;
PubSubClient mqttClient(espClient);
Servo servo;

#ifdef DEBUG_BUILD
char dbg_out[512];
#define dbg(fmt, ...) \
Serial.printf(fmt"\r\n", ##__VA_ARGS__);
// do {\
//     snprintf(dbg_out, 512, fmt, ##__VA_ARGS__); \
//     Serial.println(dbg_out); \
//     /*mqttClient.publish(MQTT_TOPIC_DBG, dbg_out);*/ \
// } while(0)
#else
#define dbg(fmt, ...) /**/
#endif

unsigned long loop_time;
unsigned long next_publish;

int8_t rssi_raw;

uint8_t circular_buf[BUF_SIZE];
uint8_t buf_step = 0;

const char* onmsg = "on";

void setup() {

    Serial.begin(115200);
    dbg("\n");
    dbg("\n");

    WiFi.mode(WIFI_STA);
    WiFi.config(staticIP, gateway, subnet, dns);
    WiFi.begin(SSID);
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.println("Connecting to " SSID);
    }

    mqttClient.setServer(MQTT_SERVER, MQTT_PORT);
    mqttClient.setCallback(mqttRecvCallback);

    while (!mqttClient.connected()) {
        if(mqttClient.connect(NAME)) {
            dbg("Connected!\n");
        }
        else {
            dbg("Not connected, delaying\n");
            delay(1000);
        }
    }

    mqttClient.publish(MQTT_TOPIC_OUT, "Connected!");
    mqttClient.subscribe(MQTT_TOPIC_IN);

    loop_time = millis();     
    next_publish = loop_time;

    servo.attach(LED_BUILTIN);
}

void mqttRecvCallback(char *topic, byte *payload, unsigned int length){
    uint16_t dir = 0;
    #ifdef DEBUG_BUILD
    dbg("Msg in topic: %s len: %d", topic, length);
    Serial.print("Message:\r\n");
    for (int i = 0; i < length; i++) {
        dbg("%d: 0x%02X", i, (char)payload[i]);
    }
    dbg("\n....................\n");
    #endif

    if (strncmp(topic, MQTT_TOPIC_IN, 128) == 0){
        if (length != 2) {
            dbg("out of range, dropping");
            return;
        }
        dbg("topic is good!");
        uint16_t dir = (uint8_t) payload[1];
        dir <<= 8;
        dir |= (uint8_t) payload[0];
        dbg("dir is %d", dir);
        servo.write(dir);
    }

    return;
}

void loop(){
    mqttClient.loop();
    // delay(10);
}