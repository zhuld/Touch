#include "TcpServer.h"
#include <QHostAddress>

TcpServer::TcpServer(QObject *parent) : QObject(parent)
{
    tcpServer = new QTcpServer(this);

    // 当有新连接时，QTcpServer 会发射 newConnection() 信号
    connect(tcpServer, &QTcpServer::newConnection, this, &TcpServer::onNewConnection);
}

void TcpServer::startServer(quint16 port, const QString &ipAddress)
{
    // 启动服务器监听指定端口
    if (tcpServer->listen(QHostAddress::Any, port)) {
        //qDebug() << "Server started on port" << port;
    } else {
        //qDebug() << "Server failed to start:" << tcpServer->errorString();
    }
    allowedIPAddress = ipAddress;
}

void TcpServer::stopServer()
{
    for (QTcpSocket *clientSocket : std::as_const(clients)) {
        if (clientSocket->state() == QAbstractSocket::ConnectedState) {
            clientSocket->close();
        }
    }
    if(tcpServer->isListening()){
        tcpServer->close();
    }
}

void TcpServer::onNewConnection()
{
    // 接受新客户端连接
    QTcpSocket *clientSocket = tcpServer->nextPendingConnection();

    // 获取客户端 IP 地址
    QString clientIP = clientSocket->peerAddress().toString();
    // 检查是否是 IPv6 格式的 IPv4 地址 (::ffff:xxx.xxx.xxx.xxx)
    if (clientIP.startsWith("::ffff:")) {
        // 提取 IPv4 地址
        clientIP = clientIP.mid(7);
    }
    // 检查客户端 IP 地址是否匹配允许的 IP 地址
    if (!allowedIPAddress.isEmpty() && clientIP != allowedIPAddress) {
        //qDebug() << "Connection from IP" << clientIP << "rejected. Allowed IP is:" << allowedIPAddress;
        clientSocket->disconnectFromHost();  // 断开连接
        return;  // 直接返回，不处理这个连接
    }

    // 连接信号槽以处理客户端事件
    connect(clientSocket, &QTcpSocket::disconnected, this, &TcpServer::onClientDisconnected);
    connect(clientSocket, &QTcpSocket::readyRead, this, &TcpServer::onReadyRead);

    clients.append(clientSocket);
    emit clientConnected();
    //qDebug() << "Client connected!";
}

void TcpServer::onClientDisconnected()
{
    QTcpSocket *clientSocket = qobject_cast<QTcpSocket *>(sender());

    if (clientSocket) {
        clients.removeAll(clientSocket);
        clientSocket->deleteLater();
        emit clientDisconnected();
        //qDebug() << "Client disconnected!";
    }
}

void TcpServer::onReadyRead()
{
    QTcpSocket *clientSocket = qobject_cast<QTcpSocket *>(sender());

    if (clientSocket) {
        // 读取客户端发送的数据
        QByteArray data = clientSocket->readAll();
        //qDebug() << "Data received from client:" << data.toHex();  // 以十六进制形式显示数据

        // 发射信号，以便外部处理接收到的数据
        emit dataReceived(data);

    }
}

void TcpServer::sendData(const QByteArray &data)
{
    // 遍历所有已连接的客户端并发送数据
    for (QTcpSocket *clientSocket : std::as_const(clients)) {
        if (clientSocket->state() == QAbstractSocket::ConnectedState) {
            clientSocket->write(data);
            clientSocket->flush();  // 确保数据立即发送
            //qDebug() << "Data sent to client:" << data.toHex();  // 以十六进制形式显示发送的数据
        }
    }
}
