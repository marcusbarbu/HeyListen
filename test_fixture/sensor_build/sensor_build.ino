#include <ESP8266WiFi.h>
#include <PubSubClient.h>

#define DEBUG_BUILD 1

#define SENSOR_NUMBER 1

#define MKSTR_INTERNAL(_N) #_N
#define MKSTR(_N) MKSTR_INTERNAL(_N)
#define SENSOR_NAME MKSTR(SENSOR_NUMBER)
#define NAME "sensor"SENSOR_NAME

#define SSID "testnet"
#define MQTT_SERVER "10.0.0.1"
#define MQTT_PORT 1883

#define MQTT_TOPIC_OUT "sensor"SENSOR_NAME"/rssi"
#define MQTT_TOPIC_DBG "sensor"SENSOR_NAME"/dbg"
#define MQTT_TOPIC_IN "sensor"SENSOR_NAME"/light"

#define PUBLISH_PERIOD_MS 200
#define BUF_SIZE 16

IPAddress staticIP(10, 0, 0, SENSOR_NUMBER+1);
IPAddress gateway(10, 0, 0, 1);
IPAddress subnet(255,255,255,0);
IPAddress dns(8,8,8,8);

WiFiClient espClient;
PubSubClient mqttClient(espClient);

#ifdef DEBUG_BUILD
#define dbg(fmt, ...) \
Serial.printf(fmt"\r\n", ##__VA_ARGS__);
// do {\
//     char output[512]; \
//     snprintf(output, 512, fmt, ##__VA_ARGS__); \
//     Serial.println(output); \
//     mqttClient.publish(MQTT_TOPIC_DBG, output); \
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

#ifdef DEBUG_BUILD
    Serial.begin(115200);
#endif
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
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, 1);
}

void mqttRecvCallback(char *topic, byte *payload, unsigned int length){
    #ifdef DEBUG_BUILD
    dbg("Msg in topic: %s", topic);
    Serial.print("Message:");
    for (int i = 0; i < length; i++) {
        Serial.print((char) payload[i]);
    }
    dbg("\n....................\n");
    #endif

    if (strcmp(topic, MQTT_TOPIC_IN) == 0){
        dbg("topic is good!");
        int strres = 0;
        for (uint i=0; i<length; i++){
            if (payload[i] != onmsg[i]){
                strres = i+1; 
                break;
            }
        }
        if (strres == 0 ){
            digitalWrite(LED_BUILTIN, 0);
            dbg("light on");
        }
        else {
            digitalWrite(LED_BUILTIN, 1);
            dbg("light off");
        }
    }

    return;
}

void loop(){
    uint16_t holder;
    rssi_raw = WiFi.RSSI();
    circular_buf[buf_step++] = (uint8_t) (0 - rssi_raw);
    if (buf_step >= BUF_SIZE) {
        buf_step = 0;
    }
    loop_time = millis();
    if (loop_time >= next_publish){
        // mqttClient.publish(MQTT_TOPIC_OUT, (uint8_t*)&rssi_raw, 1);
        holder = 0;
        for(int i=0; i<BUF_SIZE; i++) {
            holder += circular_buf[i];
        }

        holder /= BUF_SIZE;
        mqttClient.publish(MQTT_TOPIC_OUT, String(holder).c_str());
        // mqttClient.publish(MQTT_TOPIC_OUT, (uint8_t*) &holder, 2);
        next_publish = millis() + PUBLISH_PERIOD_MS;
        // dbg("published\n");
    }

    mqttClient.loop();
}