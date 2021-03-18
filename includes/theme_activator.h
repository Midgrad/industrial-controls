#ifndef INDUSTRIAL_THEME_ACTIVATOR_H
#define INDUSTRIAL_THEME_ACTIVATOR_H

#include "export.h"

class QQmlEngine;

void INDUSTRIAL_CONTROLS_EXPORT industrialThemeActivate(bool setAsDefaultStyle = false,
                                                          QQmlEngine* engine = nullptr);

#endif // INDUSTRIAL_THEME_ACTIVATOR_H
