#include "TcpClient.h"
#include <QHostAddress>

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    tcpSocket = new QTcpSocket(this);

    connect(tcpSocket, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
    connect(tcpSocket, &QTcpSocket::connected, this, &TcpClient::onConnected);
    connect(tcpSocket, &QTcpSocket::disconnected, this, &TcpClient::onDisconnected);
    connect(tcpSocket, &QTcpSocket::errorOccurred, this, &TcpClient::onError);
    connect(tcpSocket, &QTcpSocket::stateChanged, this, &TcpClient::onStateChanged);

}

void TcpClient::connectToServer(const QString &host, quint16 port)
{
    currentHost = host;
    currentPort = port;

    if (tcpSocket->state() == QTcpSocket::UnconnectedState) {
        tcpSocket->connectToHost(QHostAddress(currentHost), currentPort);
    }
}

void TcpClient::sendData(const QByteArray &data)
{
    if(data.toHex()!=""){
        if (tcpSocket->state() == QTcpSocket::ConnectedState) {
            tcpSocket->write(data);
            tcpSocket->flush();
        }
        //qDebug() << "Data send to server:" << data.toHex();
    }
}

void TcpClient::disconnectFromServer()
{
    tcpSocket->disconnectFromHost();
}

void TcpClient::onReadyRead()
{
    QByteArray data = tcpSocket->readAll();
    emit dataReceived(data);
}

void TcpClient::onConnected()
{
    emit connected();
}

void TcpClient::onDisconnected()
{
    emit disconnected();
}

void TcpClient::onError(QAbstractSocket::SocketError socketError)
{
    emit errorOccurred(tcpSocket->errorString());
}

void TcpClient::onStateChanged(QAbstractSocket::SocketState state)
{
    emit stateChanged(state);  // 发射自定义状态改变信号
}
