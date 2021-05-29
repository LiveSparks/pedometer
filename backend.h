#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include "RTIMULib.h"
#include <iostream>
#include <math.h>
#include "DigitalFilters/DigitalFilters.h"
#include "MovingAverage.h"

#define IMU_SAMPLE_RATE 51

class Backend : public QObject {
    Q_OBJECT
    //Properties registered with our custom QML Type
    Q_PROPERTY(float accelX READ accelX NOTIFY accelXChanged)
    Q_PROPERTY(float accelY READ accelY NOTIFY accelYChanged)
    Q_PROPERTY(float accelZ READ accelZ NOTIFY accelZChanged)
    Q_PROPERTY(float accelM READ accelM NOTIFY accelMChanged)
    Q_PROPERTY(float accelL READ accelL NOTIFY accelLChanged)
    Q_PROPERTY(float accelH READ accelH NOTIFY accelHChanged)
    Q_PROPERTY(float accelC READ accelC NOTIFY accelCChanged)
    
    Q_PROPERTY(int sampleRate READ sampleRate NOTIFY sampleRateChanged)
    Q_PROPERTY(float stepSensitivity READ stepSensitivity WRITE setStepSensitivity NOTIFY stepSensitivityChanged)
    Q_PROPERTY(int stepCount READ stepCount NOTIFY stepCountChanged)

public:
    explicit Backend(QObject *parent = nullptr);

    //Functions to get Property values
    float accelX();
    float accelY();
    float accelZ();
    float accelM();
    float accelL();
    float accelH();
    float accelC();

    int     sampleRate();
    float   stepSensitivity();
    int     stepCount();

    //Function to set Step Detection Secsitivity
    void setStepSensitivity(float stepSensitivity);

public slots:
    //Custom Functions Registered with our QML Type
    void getImuData();
    void init();
    void shutdown();

signals:
    //Signals (Callbacks) emitted by our QML Properties
    void accelXChanged();
    void accelYChanged();
    void accelZChanged();
    void accelMChanged();
    void accelLChanged();
    void accelHChanged();
    void accelCChanged();

    void sampleRateChanged();
    void stepSensitivityChanged();
    void stepCountChanged();

private:
    //Variables used by the custom properties
    float m_accelX = 0;
    float m_accelY = 0;
    float m_accelZ = 0;

    float m_accelM = 0;
    float m_accelL = 0;
    float m_accelH = 0;
    float m_accelC = 0;

    int m_sampleRate = 0;
    int m_stepCount = -1;
    float m_stepSensitivity = 0.16;

    //IMU Library variables
    RTIMUSettings *m_settings;
    RTIMU *m_imu;

    //Variables used in step calculation
    uint64_t last_time=0;
    uint64_t now = 0;
    int samples = 0;
    MovingAverage mavg = MovingAverage(125);
    bool in_step = false;
};

#endif  // BACKEND_H