#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QByteArray>

class TcpServer : public QObject
{
    Q_OBJECT
public:
    explicit TcpServer(QObject *parent = nullptr);

    Q_INVOKABLE void startServer(quint16 port, const QString &ipAddress);  // 启动服务器
    Q_INVOKABLE void stopServer();
    Q_INVOKABLE void sendData(const QByteArray &data);  // 向客户端发送数据


signals:
    void clientConnected();
    void clientDisconnected();
    void dataReceived(const QByteArray &data);

private slots:
    void onNewConnection();
    void onClientDisconnected();
    void onReadyRead();

private:
    QTcpServer *tcpServer;
    QList<QTcpSocket *> clients;  // 客户端列表
    QString allowedIPAddress;
};

#endif // TCPSERVER_H
