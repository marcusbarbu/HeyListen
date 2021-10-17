#include "my_time.h"
#include "core_esp8266_features.h"

MyTime::MyTime(){
    _has_offset = false;
    _offset_millis = 0;
    return;
}

void MyTime::set_offset(unsigned long offset) {
    _has_offset = true;
    _offset_millis = offset;
}
void MyTime::set_offset_seconds(unsigned long offset_seconds) {
    _offset_millis = offset_seconds * 1000;
}

unsigned long MyTime::get_adjusted_millis(void) {
    unsigned long raw = millis();
    return raw + _offset_millis;
}

double MyTime::get_seconds(void) {
    unsigned long raw = millis();
    raw += _offset_millis;
    double out = (double) raw / 1000;
    return out;
}
