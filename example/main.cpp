#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "theme_activator.h"

int main(int argc, char* argv[])
{
    QGuiApplication::setAttribute(Qt::AA_DisableHighDpiScaling, true);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    industrial_theme_activate(false, &engine);
//    engine.addImportPath(QStringLiteral("qrc:/"));

    engine.load(QStringLiteral("../qml/Main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
