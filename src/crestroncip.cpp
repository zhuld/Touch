#include "CrestronCIP.h"
#include <QHostAddress>

CrestronCIP::CrestronCIP(QObject *parent) : QObject(parent)
{
    tcpSocket = new QTcpSocket(this);
    timer = new QTimer(this);  // 初始化定时器
    connect(timer, &QTimer::timeout, this, &CrestronCIP::sendPing);  // 定时器超时信号连接到发送函数

    connect(tcpSocket, &QTcpSocket::readyRead, this, &CrestronCIP::onReadyRead);
    connect(tcpSocket, &QTcpSocket::connected, this, &CrestronCIP::onConnected);
    connect(tcpSocket, &QTcpSocket::disconnected, this, &CrestronCIP::onDisconnected);
    connect(tcpSocket, &QTcpSocket::errorOccurred, this, &CrestronCIP::onError);
    connect(tcpSocket, &QTcpSocket::stateChanged, this, &CrestronCIP::onStateChanged);

    // 设置默认定时发送的数据
    pingData = QByteArray::fromHex("0D00020000");  // ping
}

void CrestronCIP::connectToServer(const QString &host, quint16 port)
{
    currentHost = host;
    currentPort = port;

    if (tcpSocket->state() == QTcpSocket::UnconnectedState) {
        tcpSocket->connectToHost(QHostAddress(currentHost), currentPort);
    }
}

void CrestronCIP::sendData(const QByteArray &data)
{
    if (tcpSocket->state() == QTcpSocket::ConnectedState) {
        tcpSocket->write(data);
    }
}

void CrestronCIP::disconnectFromServer()
{
    tcpSocket->disconnectFromHost();
    timer->stop();  // 断开连接时停止定时发送
}

void CrestronCIP::onReadyRead()
{
    QByteArray data = tcpSocket->readAll();
    emit dataReceived(data);
}

void CrestronCIP::onConnected()
{
    emit connected();
    // 连接成功后自动开始定时发送数据，每隔15000毫秒发送一次
    if (!timer->isActive()) {
        timer->start(15000);  // 每15000毫秒发送一次数据
    }
}

void CrestronCIP::onDisconnected()
{
    emit disconnected();

}

void CrestronCIP::onError(QAbstractSocket::SocketError socketError)
{
    emit errorOccurred(tcpSocket->errorString());
}

void CrestronCIP::onStateChanged(QAbstractSocket::SocketState state)
{
    emit stateChanged(state);  // 发射自定义状态改变信号
}

void CrestronCIP::sendPing()
{
    if (tcpSocket->state() == QTcpSocket::ConnectedState) {
        tcpSocket->write(pingData);  // 定时发送数据
    }
}
