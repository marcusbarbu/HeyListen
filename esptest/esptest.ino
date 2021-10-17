/*
    This sketch establishes a TCP connection to a "quote of the day" service.
    It sends a "hello" message, and then prints received data.
*/

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <iostream>
#include <sstream>
#include <time.h>
#include "my_time.h"
#include "secrets.h"



#define SAMPLES_PER_PURGE 5000
#define CHECK_PERIOD_MILLIS 100

const char* ssid     = STASSID;
const char* password = STAPSK;

IPAddress staticIP(192, 168, 1, 11);
IPAddress gateway(192, 168, 1, 254);
IPAddress subnet(255,255,255,0);
IPAddress dns(8,8,8,8);

ESP8266WebServer server(80);

typedef struct {
    unsigned int sample;
    int8_t rssis[SAMPLES_PER_PURGE];
    unsigned long times[SAMPLES_PER_PURGE];

} __attribute__((packed)) rssi_timeseries_t;


rssi_timeseries_t g_timeseries;

int8_t rssi;
MyTime mt;

unsigned long now_millis;
unsigned long last_millis;

void hello() {
  server.send(200, "text/html", "HELLO WORLD THERE HELLO!");
  Serial.println("hello");
}

void samples() {
    // std::ostringstream os;
    // String outstring;
    // for (unsigned int i=0; i < SAMPLES_PER_PURGE; i++){
    //     os << times[i] << ", " << rssis[i] << "\n";
    // }
    // outstring = String(os.str());
    server.send(200, "application/octet-stream", (uint8_t*) &g_timeseries, sizeof(g_timeseries) );
}

void setup() {

    memset(&g_timeseries, 0x00, sizeof(g_timeseries));
    mt = MyTime();
    Serial.begin(115200);

    // We start by connecting to a WiFi network

    Serial.println();
    Serial.println();
    Serial.print("Connecting to ");
    Serial.println(ssid);
    Serial.print("Time is now: ");
    Serial.print(mt.get_adjusted_millis());


    /* Explicitly set the ESP8266 to be a WiFi-client, otherwise, it by default,
        would try to ac as both a client and an access-point and could cause
        network-issues with your other WiFi-devices on your WiFi-network. */
    WiFi.mode(WIFI_STA);
    WiFi.config(staticIP, gateway, subnet, dns);
    WiFi.begin(ssid, password);

    mt.set_offset(141414);

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    Serial.print("Time is now: ");
    Serial.println(mt.get_adjusted_millis());

    Serial.println("");
    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    server.on("/", hello);
    server.on("/samples", samples);
    server.begin();
}

void loop() {
    rssi = WiFi.RSSI();
    // Serial.print("Rssi = ");
    // Serial.println(rssi);
    now_millis = mt.get_adjusted_millis();
    if (now_millis % 5000 == 0 && now_millis != last_millis) {
        Serial.print("Time is now: ");
        Serial.print(mt.get_seconds());
        Serial.print(" -> ");
        Serial.println(mt.get_adjusted_millis());
        last_millis = now_millis;
    }

    if (now_millis % CHECK_PERIOD_MILLIS == 0) {
        g_timeseries.rssis[g_timeseries.sample] = rssi;
        g_timeseries.times[g_timeseries.sample] = now_millis;
        g_timeseries.sample++;
        if (g_timeseries.sample > SAMPLES_PER_PURGE) {
            g_timeseries.sample = 0;
        }
    }
    server.handleClient();
}
