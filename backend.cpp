#include "backend.h"

std::chrono::_V2::system_clock::time_point get_milli(){
    return std::chrono::system_clock::now();
}


Backend::Backend(QObject *parent) : QObject(parent){
    m_settings = new RTIMUSettings("RTIMULib");
    m_imu = RTIMU::createIMU(m_settings);
    m_imu->IMUInit();
}

void Backend::getImuData(){
    while(m_imu->IMURead()){
        RTIMU_DATA imuData = m_imu->getIMUData(); 
        // std::cout<< "Sample Rate:" << rate << "\tx:" << imuData.accel.x()<< "\ty:" << imuData.accel.y()<< "\tz:" << imuData.accel.z() <<"\n";
        samples++;
        auto int_ms = std::chrono::duration_cast<std::chrono::milliseconds>(get_milli() - start);
        m_accelX = imuData.accel.x();
        m_accelY = imuData.accel.y();
        m_accelZ = imuData.accel.z();
        emit accelXChanged();
        emit accelYChanged();
        emit accelZChanged();
        if(int_ms.count() >= 1000){
            // std::cout << "Samples: " << samples << "\n";
            rate = samples;
            samples = 0;
            start = get_milli();
        }
    }
}

float Backend::accelX(){
    return m_accelX;
}
float Backend::accelY(){
    return m_accelY;
}
float Backend::accelZ(){
    return m_accelZ;
}