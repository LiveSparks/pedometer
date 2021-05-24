#include <QApplication>
#include <QQmlApplicationEngine>
#include "RTIMULib.h"
#include "backend.h"

// #include <iostream>

int main(int argc, char *argv[])
{

    
    /*
    RTIMUSettings *m_settings = new RTIMUSettings("RTIMULib");
    RTIMU *m_imu;
    m_imu = RTIMU::createIMU(m_settings);
    m_imu->IMUInit();

    while(1){
        if(m_imu->IMURead()){
            RTIMU_DATA imuData = m_imu->getIMUData(); 
            std::cout<< "x:" << imuData.accel.x()<< "\ty:" << imuData.accel.y()<< "\tz:" << imuData.accel.z() <<"\n";
        }
    }
    */
    // m_imu->IMURead();
    // RTIMU_DATA imuData = m_imu->getIMUData();
    // std::cout<<RTMath::displayDegrees("", imuData.fusionPose)<<"\n";

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    qmlRegisterType<Backend>("plugin.backend", 1, 0, "Backend");

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    QObject::connect(&engine, SIGNAL(quit()), &app, SLOT(quit()));
    engine.load(url);

    return app.exec();
}