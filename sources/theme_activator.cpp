#include "theme_activator.h"

#include <QGuiApplication>
#include <QPalette>
#include <QQuickStyle>

#include <QFontMetrics>
#include <QGuiApplication>
#include <QQmlEngine>

#include <QDebug>

#include "custom_double_validator.h"
#include "file_browser_model.h"
#include "svg_item.h"
#include "theme.h"
#include "theme_loader.h"

void industrialThemeActivate(bool setAsDefaultStyle, QQmlEngine* engine)
{
    qmlRegisterSingletonType<IndustrialTheme>(
        "Industrial.Controls", 1, 0, "Theme",
        [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
            Q_UNUSED(scriptEngine)
            auto theme = IndustrialTheme::instance();
            engine->setObjectOwnership(theme, QQmlEngine::CppOwnership);
            return theme;
        });

    qmlRegisterType<ThemeLoader>("Industrial.Controls", 1, 0, "ThemeLoader");
    qmlRegisterType<FileBrowserModel>("Industrial", 1, 0, "FileBrowserModel");
    qmlRegisterType<SvgItem>("Industrial", 1, 0, "SvgItem");
    qmlRegisterUncreatableType<IndustrialThemeFactors>("Industrial.Controls", 1, 0, "ThemeFactors",
                                                       "Uncreatable");
    qmlRegisterUncreatableType<IndustrialThemeColors>("Industrial.Controls", 1, 0, "ThemeColors",
                                                      "Uncreatable");

    qmlRegisterType<CustomDoubleValidator>("Industrial.Controls", 1, 0, "CustomDoubleValidator");

    if (setAsDefaultStyle)
    {
        QQuickStyle::setStyle(":/Industrial/Controls");
    }
    if (engine)
    {
        engine->addImportPath("qrc:/");
    }
}
