#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include "RTIMULib.h"
#include <iostream>
#include <chrono>

class Backend : public QObject {
    Q_OBJECT
    Q_PROPERTY(float accelX READ accelX NOTIFY accelXChanged)
    Q_PROPERTY(float accelY READ accelY NOTIFY accelYChanged)
    Q_PROPERTY(float accelZ READ accelZ NOTIFY accelZChanged)

public:
    explicit Backend(QObject *parent = nullptr);

    float accelX();
    float accelY();
    float accelZ();

public slots:
    void getImuData();

signals:
    void accelXChanged();
    void accelYChanged();
    void accelZChanged();

private:
    float m_accelX = 0;
    float m_accelY = 0;
    float m_accelZ = 0;
    RTIMUSettings *m_settings;
    RTIMU *m_imu;
    std::chrono::_V2::system_clock::time_point start;
    int samples = 0;
    int rate = 0;
};

#endif  // BACKEND_H