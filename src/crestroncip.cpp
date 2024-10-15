#include "CrestronCIP.h"
#include <QHostAddress>

CrestronCIP::CrestronCIP(QObject *parent) : QObject(parent)
{
    tcpSocket = new QTcpSocket(this);

    connect(tcpSocket, &QTcpSocket::readyRead, this, &CrestronCIP::onReadyRead);
    connect(tcpSocket, &QTcpSocket::connected, this, &CrestronCIP::onConnected);
    connect(tcpSocket, &QTcpSocket::disconnected, this, &CrestronCIP::onDisconnected);
    connect(tcpSocket, &QTcpSocket::errorOccurred, this, &CrestronCIP::onError);
    connect(tcpSocket, &QTcpSocket::stateChanged, this, &CrestronCIP::onStateChanged);

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
}

void CrestronCIP::onReadyRead()
{
    QByteArray data = tcpSocket->readAll();
    emit dataReceived(data);
}

void CrestronCIP::onConnected()
{
    emit connected();
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
