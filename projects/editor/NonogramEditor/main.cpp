#include <QtQml/QQmlApplicationEngine>
#include <QtWidgets/QApplication>
#include <QtQml/qqml.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

    return app.exec();
}
