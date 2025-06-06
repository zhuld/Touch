#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QString>

class TcpClient : public QObject
{
    Q_OBJECT

public:
    explicit TcpClient(QObject *parent = nullptr);

    Q_INVOKABLE void connectToServer(const QString &host, quint16 port);
    Q_INVOKABLE void sendData(const QByteArray &data);
    Q_INVOKABLE void disconnectFromServer();
    Q_INVOKABLE void checkState();

signals:
    void dataReceived(const QByteArray &data);
    void connected();
    void disconnected();
    void errorOccurred(const QString &error);
    void stateChanged(QAbstractSocket::SocketState state); // 新增的状态改变信号


private slots:
    void onReadyRead();
    void onConnected();
    void onDisconnected();
    void onError(QAbstractSocket::SocketError socketError);
    void onStateChanged(QAbstractSocket::SocketState state);

private:
    QTcpSocket *tcpSocket;
    QString currentHost;
    quint16 currentPort;
};

#endif // TCPCLIENT_H
