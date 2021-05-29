#include "backend.h"

// Filters Applied to the IMU data. 
// Only using the Low Pass Filter in the final implementation.
// A high pass filter along with a low pass filter also has similar results.
LowPassFilter3  lpf(0.008, 2* M_PI * 4.5);
HighPassFilter3 hpf(0.008, 2* M_PI * 0.6);
HighPassFilter3 hpf2(0.008, 2* M_PI * 0.6);

//Constructor
Backend::Backend(QObject *parent) : QObject(parent){}

//Initialize the IMU Library
void Backend::init(){
    m_settings = new RTIMUSettings("RTIMULib");
    m_imu = RTIMU::createIMU(m_settings);
    m_imu->IMUInit();
    std::cout << "Poll Rate: " << m_imu->IMUGetPollInterval() << "\n";
}

// Should be called periotically to get the data from the IMU.
// This function also calculates steps
void Backend::getImuData(){
    while(m_imu->IMURead()){
        RTIMU_DATA imuData = m_imu->getIMUData(); 
        // std::cout<< "Sample Rate:" << m_sampleRate << "\tx:" << imuData.accel.x()<< "\ty:" << imuData.accel.y()<< "\tz:" << imuData.accel.z() <<"\n";
        samples++;
        
        m_accelX = imuData.accel.x();
        m_accelY = imuData.accel.y();
        m_accelZ = imuData.accel.z();

        // Combine the data of all three axis in the same value.
        m_accelM = sqrt( (m_accelX*m_accelX)+(m_accelY*m_accelY)+(m_accelZ*m_accelZ) );

        // Apply the low pass filter
        m_accelL = lpf.update(m_accelM);
        // Calculate a moving average
        m_accelH = mavg.next(m_accelL*1000)/1000;
        // Subtract the average from the axis data to bring it to zero
        m_accelC = m_accelL - m_accelH;

        // m_accelH = hpf.update(m_accelM);
        // m_accelC = hpf.update(m_accelL);
        // m_accelC = hpf2.update(m_accelL);

        // Check if step was taken
        if(m_accelC > m_stepSensitivity && !in_step){
            m_stepCount++;
            emit stepCountChanged();
            in_step = true;
            std::cout << "Steps: " << m_stepCount << "\n";
        }
        else if(m_accelC < 0 && in_step){
            in_step = false;
        }

        // Update the data in QML
        emit accelXChanged();
        emit accelYChanged();
        emit accelZChanged();
        emit accelMChanged();
        emit accelLChanged();
        emit accelHChanged();
        emit accelCChanged();

        // Calculate the sample rate every second.
        now = RTMath::currentUSecsSinceEpoch();
        if((now - last_time) > 1000000){
            // std::cout << "Samples: " << samples << "\n";
            m_sampleRate = samples;
            emit sampleRateChanged();
            samples = 0;
            last_time = now;
        }
    }
}

// Shutdown function. Only works if the application is run with root permisions
void Backend::shutdown(){
    system("shutdown -P now");
}

// QML support functions for the properties.
float Backend::accelX(){
    return m_accelX;
}
float Backend::accelY(){
    return m_accelY;
}
float Backend::accelZ(){
    return m_accelZ;
}
float Backend::accelM(){
    return m_accelM;
}
float Backend::accelL(){
    return m_accelL;
}
float Backend::accelH(){
    return m_accelH;
}
float Backend::accelC(){
    return m_accelC;
}
int Backend::sampleRate(){
    return m_sampleRate;
}
float Backend::stepSensitivity(){
    return m_stepSensitivity;
}
void Backend::setStepSensitivity(float stepSensitivity){
    m_stepSensitivity = stepSensitivity;
    emit stepSensitivityChanged();
}
int Backend::stepCount(){
    return m_stepCount;
}