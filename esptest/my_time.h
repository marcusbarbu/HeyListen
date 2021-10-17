#ifndef __MY_TIME_H__
#define __MY_TIME_H__

class MyTime {
    public:
        MyTime(void);
        void set_offset(unsigned long);
        void set_offset_seconds(unsigned long);
        unsigned long get_adjusted_millis(void);
        double get_seconds(void);
    private:
        unsigned long _offset_millis;
        bool _has_offset;
};

#endif //_MY_TIME_H__