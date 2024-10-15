#ifndef CRESTRONCIP_H
#define CRESTRONCIP_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>
#include <QString>

class CrestronCIP : public QObject
{
    Q_OBJECT
public:
    explicit CrestronCIP(QObject *parent = nullptr);

    Q_INVOKABLE void connectToServer(const QString &host, quint16 port);
    Q_INVOKABLE void sendData(const QByteArray &data);
    Q_INVOKABLE void disconnectFromServer();

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
    void sendPing();  // 定时发送数据

private:
    QTcpSocket *tcpSocket;
    QString currentHost;
    quint16 currentPort;

    QTimer *timer;  // 定时器
    QByteArray pingData;  // 定时发送的数据
};

#endif // CRESTRONCIP_H
