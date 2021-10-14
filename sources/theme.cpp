#include "theme.h"

#include <QSharedPointer>
#include <QVariantMap>
//#include <QFontMetrics>
//#include <QGuiApplication>

//#include <QDebug>

namespace
{
    template <typename T>
    void setValueFromMap(const QVariantMap& map, const QString& name, T& value)
    {
        auto it = map.find(name);
        if (it != map.end())
        {
            value = it.value().value<T>();
        }
    }
}

//class IndustrialThemeFactors::Impl
//{
//public:
//    qreal mainFontSize = 0.5;     // Основной шрифт
//    qreal auxFontSize = 0.4;      // Вспомогательный шрифт
//    qreal spacing = 0.25;          // Отступы между компонентами
//    qreal margins = 0.25;         // Отступы от внешних границ
//    qreal padding = 0.25;         // Отступы от внутренних границ
//    qreal iconSize = 0.625;       // Размер пиктограм
//    qreal scrollSize = 0.125;    // Размер скроллбара
//    qreal sliderSize = 0.125;     // Высота слайдера
//    qreal switchSize = 0.75;      // Высота свича
//    qreal handleSize = 0.625;     // Хендл у слайдеров и свичей
//    qreal checkmarkSize = 0.625;  // Чекбоксы и радио
//    qreal floatSize = 1.25;       // Плавающие кнопки
//    qreal rounding = 0.125;       // Радиус скругления
//    qreal underline = 0.0625;     // Подчёркивание
//    qreal shadow = 0.1;           // Размер тени
//    qreal border = 0.0625;        // Размер бордера
//};

//IndustrialThemeFactors::IndustrialThemeFactors() : d(new Impl())
//{
//}

//IndustrialThemeFactors::~IndustrialThemeFactors()
//{
//}

QVariantMap IndustrialThemeFactors::toMap() const
{
    return {
        { "mainFontSize", m_mainFontSize },
        { "auxFontSize", m_auxFontSize },
        { "tipFontSize", m_tipFontSize },
        { "spacing", m_spacing },
        { "margins", m_margins },
        { "padding", m_padding },
        { "iconSize", m_iconSize },
        { "scrollSize", m_scrollSize },
        { "sliderSize", m_sliderSize },
        { "switchSize", m_switchSize },
        { "handleSize", m_handleSize },
        { "checkmarkSize", m_checkmarkSize },
        { "floatSize", m_floatSize },
        { "rounding", m_rounding },
        { "underline", m_underline },
        { "shadow", m_shadow },
        { "border", m_border },
    };
}

void IndustrialThemeFactors::fromMap(const QVariantMap &map)
{
    ::setValueFromMap(map, "mainFontSize", m_mainFontSize);
    ::setValueFromMap(map, "auxFontSize", m_auxFontSize);
    ::setValueFromMap(map, "tipFontSize", m_tipFontSize);
    ::setValueFromMap(map, "spacing", m_spacing);
    ::setValueFromMap(map, "margins", m_margins);
    ::setValueFromMap(map, "padding", m_padding);
    ::setValueFromMap(map, "iconSize", m_iconSize);
    ::setValueFromMap(map, "scrollSize", m_scrollSize);
    ::setValueFromMap(map, "sliderSize", m_sliderSize);
    ::setValueFromMap(map, "switchSize", m_switchSize);
    ::setValueFromMap(map, "handleSize", m_handleSize);
    ::setValueFromMap(map, "checkmarkSize", m_checkmarkSize);
    ::setValueFromMap(map, "floatSize", m_floatSize);
    ::setValueFromMap(map, "rounding", m_rounding);
    ::setValueFromMap(map, "underline", m_underline);
    ::setValueFromMap(map, "shadow", m_shadow);
    ::setValueFromMap(map, "border", m_border);
}

qreal IndustrialThemeFactors::mainFontSize() const
{
    return m_mainFontSize;
}

qreal IndustrialThemeFactors::auxFontSize() const
{
    return m_auxFontSize;
}

qreal IndustrialThemeFactors::tipFontSize() const
{
    return m_tipFontSize;
}

qreal IndustrialThemeFactors::spacing() const
{
    return m_spacing;
}

qreal IndustrialThemeFactors::margins() const
{
    return m_margins;
}

qreal IndustrialThemeFactors::padding() const
{
    return m_padding;
}

qreal IndustrialThemeFactors::iconSize() const
{
    return m_iconSize;
}

qreal IndustrialThemeFactors::scrollSize() const
{
    return m_scrollSize;
}

qreal IndustrialThemeFactors::sliderSize() const
{
    return m_sliderSize;
}

qreal IndustrialThemeFactors::switchSize() const
{
    return m_switchSize;
}

qreal IndustrialThemeFactors::handleSize() const
{
    return m_handleSize;
}

qreal IndustrialThemeFactors::checkmarkSize() const
{
    return m_checkmarkSize;
}

qreal IndustrialThemeFactors::floatSize() const
{
    return m_floatSize;
}

qreal IndustrialThemeFactors::rounding() const
{
    return m_rounding;
}

qreal IndustrialThemeFactors::underline() const
{
    return m_underline;
}

qreal IndustrialThemeFactors::shadow() const
{
    return m_shadow;
}

qreal IndustrialThemeFactors::border() const
{
    return m_border;
}

void IndustrialThemeFactors::setMainFontSize(qreal value)
{
    m_mainFontSize = value;
}

void IndustrialThemeFactors::setAuxFontSize(qreal value)
{
    m_auxFontSize = value;
}

void IndustrialThemeFactors::setTipFontSize(qreal value)
{
    m_tipFontSize = value;
}

void IndustrialThemeFactors::setSpacing(qreal value)
{
    m_spacing = value;
}

void IndustrialThemeFactors::setMargins(qreal value)
{
    m_margins = value;
}

void IndustrialThemeFactors::setPadding(qreal value)
{
    m_padding = value;
}

void IndustrialThemeFactors::setIconSize(qreal value)
{
    m_iconSize = value;
}

void IndustrialThemeFactors::setScrollSize(qreal value)
{
    m_scrollSize = value;
}

void IndustrialThemeFactors::setSliderSize(qreal value)
{
    m_sliderSize = value;
}

void IndustrialThemeFactors::setSwitchSize(qreal value)
{
    m_switchSize = value;
}

void IndustrialThemeFactors::setHandleSize(qreal value)
{
    m_handleSize = value;
}

void IndustrialThemeFactors::setCheckmarkSize(qreal value)
{
    m_checkmarkSize = value;
}

void IndustrialThemeFactors::setFloatSize(qreal value)
{
    m_floatSize = value;
}

void IndustrialThemeFactors::setRounding(qreal value)
{
    m_rounding = value;
}

void IndustrialThemeFactors::setUnderline(qreal value)
{
    m_underline = value;
}

void IndustrialThemeFactors::setShadow(qreal value)
{
    m_shadow = value;
}

void IndustrialThemeFactors::setBorder(qreal value)
{
    m_border = value;
}

//class IndustrialThemeColors::Impl
//{
//public:
//    QColor raised = "#334248";          // Фон возвышенных элементов (панели)
//    QColor background = "#2c393f";      // Фона окна
//    QColor sunken = "#212c30";          // Фон утопленных элементов (поля ввода, фон слайдеров и чекбоксов и т.д)
//    QColor text = "#ffffff";            // Текст (иконки и другие элементы на фоне окна, утопленных и возвышенных элементов)
//    QColor hover = "#3319d6c4";         // Подсветка элемента при наведении мыши
//    QColor border = "#2c393f";          // Цвет обводки

//    QColor disabled = "#4F5D64";        // Неактивный цвет (штриховка на контролах, отключенные элементы

//    QColor control = "#5a717c";         // Фон больших управляющих элементов (кнопки)
//    QColor controlBorder = "#6c8693";   // Фон и обводка мелких управляющих элементов (хендлы, переключатели)
//    QColor line = "#805a717c";          // Линии, цвет control + 0.5 прозрачность
//    QColor controlText = "#ffffff";     // Текст кнопки

//    QColor tip = "#009688";             // Фон подсказки
//    QColor tipText = "#ffffff";         // Текст подсказки

//    QColor selection = "#009688";       // Фон выделения
//    QColor selectedText = "#ffffff";    // Текст выделения

//    QColor highlight = "#19d6c4";       // Фон подсветки (при активации)
//    QColor highlightedText = "#000000"; // Текст подсветки

//    QColor description = "#899ea9";     // Вспомогательный текст
//    QColor link = "#51a0e7";            // Ссылка (на фоне окна, утопленных и возвышенных элементов)
//    QColor positive = "#86c34a";        // Позитивный (текст и предупреждения)
//    QColor neutral = "#ff9800";         // Нейтральный (текст и предупреждения)
//    QColor negative = "#e53535";        // Негативный (текст и предупреждения)
//    QColor shadow = "#80000000";        // Тень

//    QColor fileIcon = "#eabf3f";        // Иконка файла (FileBrowser)
//};

//IndustrialThemeColors::IndustrialThemeColors() : d(new Impl())
//{
//}

//IndustrialThemeColors::~IndustrialThemeColors()
//{
//}

QVariantMap IndustrialThemeColors::toMap() const
{
    return {
        { "raised", m_raised },
        { "background", m_background },
        { "sunken", m_sunken },
        { "text", m_text },
        { "hover", m_hover },
        { "border", m_border },

        { "disabled", m_disabled },

        { "control", m_control },
        { "controlBorder", m_controlBorder },
        { "line", m_line },
        { "controlText", m_controlText },

        { "tip", m_tip },
        { "tipText", m_tipText },

        { "selection", m_selection },
        { "selectedText", m_selectedText },

        { "highlight", m_highlight },
        { "highlightedText", m_highlightedText },

        { "description", m_description },
        { "link", m_link },
        { "positive", m_positive },
        { "neutral", m_neutral },
        { "negative", m_negative },
        { "shadow", m_shadow },

        { "fileIcon", m_fileIcon } };
}

void IndustrialThemeColors::fromMap(const QVariantMap &map)
{
    ::setValueFromMap(map, "raised", m_raised);
    ::setValueFromMap(map, "background", m_background);
    ::setValueFromMap(map, "sunken", m_sunken);
    ::setValueFromMap(map, "text", m_text);
    ::setValueFromMap(map, "hover", m_hover);
    ::setValueFromMap(map, "border", m_border);

    ::setValueFromMap(map, "disabled", m_disabled);

    ::setValueFromMap(map, "control", m_control);
    ::setValueFromMap(map, "controlBorder", m_controlBorder);
    ::setValueFromMap(map, "line", m_line);
    ::setValueFromMap(map, "controlText", m_controlText);

    ::setValueFromMap(map, "tip", m_tip);
    ::setValueFromMap(map, "tipText", m_tipText);

    ::setValueFromMap(map, "selection", m_selection);
    ::setValueFromMap(map, "selectedText", m_selectedText);

    ::setValueFromMap(map, "highlight", m_highlight);
    ::setValueFromMap(map, "highlightedText", m_highlightedText);

    ::setValueFromMap(map, "description", m_description);
    ::setValueFromMap(map, "link", m_link);
    ::setValueFromMap(map, "positive", m_positive);
    ::setValueFromMap(map, "neutral", m_neutral);
    ::setValueFromMap(map, "negative", m_negative);
    ::setValueFromMap(map, "shadow", m_shadow);

    ::setValueFromMap(map, "fileIcon", m_fileIcon);
}

QColor IndustrialThemeColors::raised() const
{
    return m_raised;
}

QColor IndustrialThemeColors::background() const
{
    return m_background;
}

QColor IndustrialThemeColors::sunken() const
{
    return m_sunken;
}

QColor IndustrialThemeColors::text() const
{
    return m_text;
}

QColor IndustrialThemeColors::hover() const
{
    return m_hover;
}

QColor IndustrialThemeColors::border() const
{
    return m_border;
}

QColor IndustrialThemeColors::disabled() const
{
    return m_disabled;
}

QColor IndustrialThemeColors::control() const
{
    return m_control;
}

QColor IndustrialThemeColors::controlBorder() const
{
    return m_controlBorder;
}

QColor IndustrialThemeColors::line() const
{
    return m_line;
}

QColor IndustrialThemeColors::controlText() const
{
    return m_controlText;
}

QColor IndustrialThemeColors::tip() const
{
    return m_tip;
}

QColor IndustrialThemeColors::tipText() const
{
    return m_tipText;
}

QColor IndustrialThemeColors::selection() const
{
    return m_selection;
}

QColor IndustrialThemeColors::selectedText() const
{
    return m_selectedText;
}

QColor IndustrialThemeColors::highlight() const
{
    return m_highlight;
}

QColor IndustrialThemeColors::highlightedText() const
{
    return m_highlightedText;
}

QColor IndustrialThemeColors::description() const
{
    return m_description;
}

QColor IndustrialThemeColors::link() const
{
    return m_link;
}

QColor IndustrialThemeColors::positive() const
{
    return m_positive;
}

QColor IndustrialThemeColors::neutral() const
{
    return m_neutral;
}

QColor IndustrialThemeColors::negative() const
{
    return m_negative;
}

QColor IndustrialThemeColors::shadow() const
{
    return m_shadow;
}

QColor IndustrialThemeColors::fileIcon() const
{
    return m_fileIcon;
}

void IndustrialThemeColors::setRaised(const QColor& value)
{
    m_raised = value;
}

void IndustrialThemeColors::setBackground(const QColor& value)
{
    m_background = value;
}

void IndustrialThemeColors::setSunken(const QColor& value)
{
    m_sunken = value;
}

void IndustrialThemeColors::setText(const QColor& value)
{
    m_text = value;
}

void IndustrialThemeColors::setHover(const QColor& value)
{
    m_hover = value;
}

void IndustrialThemeColors::setBorder(const QColor& value)
{
    m_border = value;
}

void IndustrialThemeColors::setDisabled(const QColor& value)
{
    m_disabled = value;
}

void IndustrialThemeColors::setControl(const QColor& value)
{
    m_control = value;
}

void IndustrialThemeColors::setControlBorder(const QColor& value)
{
    m_controlBorder = value;
}

void IndustrialThemeColors::setLine(const QColor& value)
{
    m_line = value;
}

void IndustrialThemeColors::setControlText(const QColor& value)
{
    m_controlText = value;
}

void IndustrialThemeColors::setTip(const QColor& value)
{
    m_tip = value;
}

void IndustrialThemeColors::setTipText(const QColor& value)
{
    m_tipText = value;
}

void IndustrialThemeColors::setSelection(const QColor& value)
{
    m_selection = value;
}

void IndustrialThemeColors::setSelectedText(const QColor& value)
{
    m_selectedText = value;
}

void IndustrialThemeColors::setHighlight(const QColor& value)
{
    m_highlight = value;
}

void IndustrialThemeColors::setHighlightedText(const QColor& value)
{
    m_highlightedText = value;
}

void IndustrialThemeColors::setDescription(const QColor& value)
{
    m_description = value;
}

void IndustrialThemeColors::setLink(const QColor& value)
{
    m_link = value;
}

void IndustrialThemeColors::setPositive(const QColor& value)
{
    m_positive = value;
}

void IndustrialThemeColors::setNeutral(const QColor& value)
{
    m_neutral = value;
}

void IndustrialThemeColors::setNegative(const QColor& value)
{
    m_negative = value;
}

void IndustrialThemeColors::setShadow(const QColor& value)
{
    m_shadow = value;
}

void IndustrialThemeColors::setfileIcon(const QColor& value)
{
    m_fileIcon = value;
}

class IndustrialTheme::Impl
{
public:
    bool night = true;
    qreal baseSize = 32;
    bool scrollInteractive = false;
    qreal animationTime = 200;

    IndustrialThemeColors dayColors;
    IndustrialThemeColors nightColors;

    IndustrialThemeFactors factors;

    Impl()
    {
        dayColors.setBackground("#eff0f0");
        dayColors.setSunken("#dfe1e2");
        dayColors.setRaised("#fafafa");
        dayColors.setText("#181a1b");
        dayColors.setDescription("#627884");
        dayColors.setDisabled("#bbc1c4");

        dayColors.setControl("#c3cfd5");
        dayColors.setControlBorder("#a3b8c2");
        dayColors.setLine("#80a3b8c2");
        dayColors.setControlText("#181a1b");

        dayColors.setTip("#00ad9f");
        dayColors.setTipText("#ffffff");

        dayColors.setSelection("#00ad9f");
        dayColors.setSelectedText("#ffffff");

        dayColors.setHighlight("#0bd8c7");
        dayColors.setHover("#330bd8c7");
        dayColors.setHighlightedText("#ffffff");

        dayColors.setLink("#51a0e7");
        dayColors.setNegative("#ee2c2c");
        dayColors.setNeutral("#ffbf00");
        dayColors.setPositive("#00c2b2");
    }
};

IndustrialTheme::IndustrialTheme(QObject* parent) :
    QObject(parent), d(new Impl)
{
}

void IndustrialTheme::notifySizesChanged()
{
    emit this->roundingChanged();
    emit this->underlineChanged();
    emit this->shadowSizeChanged();

    emit this->mainFontSizeChanged();
    emit this->auxFontSizeChanged();
    emit this->tipFontSizeChanged();
    emit this->spacingChanged();
    emit this->marginsChanged();
    emit this->paddingChanged();
    emit this->iconSizeChanged();
    emit this->scrollSizeChanged();
    emit this->sliderSizeChanged();
    emit this->switchSizeChanged();
    emit this->handleSizeChanged();
    emit this->checkmarkSizeChanged();
    emit this->floatSizeChanged();
    emit this->borderChanged();
}

IndustrialTheme::~IndustrialTheme()
{
}

IndustrialTheme* IndustrialTheme::instance()
{
    static QSharedPointer<IndustrialTheme> instance(new IndustrialTheme());
    return instance.data();
}

bool IndustrialTheme::night() const
{
    return d->night;
}

qreal IndustrialTheme::baseSize() const
{
    return d->baseSize;
}

bool IndustrialTheme::scrollInteractive() const
{
    return d->scrollInteractive;
}

qreal IndustrialTheme::animationTime() const
{
    return d->animationTime;
}

const IndustrialThemeColors& IndustrialTheme::dayColors() const
{
    return d->dayColors;
}

const IndustrialThemeColors& IndustrialTheme::nightColors() const
{
    return d->nightColors;
}

const IndustrialThemeFactors& IndustrialTheme::factors() const
{
    return d->factors;
}

const IndustrialThemeColors& IndustrialTheme::colors() const
{
    return d->night ? d->nightColors : d->dayColors;
}

qreal IndustrialTheme::rounding() const
{
    return d->baseSize * d->factors.rounding();
}

qreal IndustrialTheme::underline() const
{
    return d->baseSize * d->factors.underline();
}
qreal IndustrialTheme::shadowSize() const
{
    return d->baseSize * d->factors.shadow();
}

qreal IndustrialTheme::mainFontSize() const
{
    return d->baseSize * d->factors.mainFontSize();
}

qreal IndustrialTheme::auxFontSize() const
{
    return d->baseSize * d->factors.auxFontSize();
}

qreal IndustrialTheme::tipFontSize() const
{
    return d->baseSize * d->factors.tipFontSize();
}

qreal IndustrialTheme::spacing() const
{
    return d->baseSize * d->factors.spacing();
}

qreal IndustrialTheme::margins() const
{
    return d->baseSize * d->factors.margins();
}

qreal IndustrialTheme::padding() const
{
    return d->baseSize * d->factors.padding();
}

int IndustrialTheme::iconSize() const
{
    return d->baseSize * d->factors.iconSize();
}

qreal IndustrialTheme::scrollSize() const
{
    return d->baseSize * d->factors.scrollSize();
}

qreal IndustrialTheme::sliderSize() const
{
    return d->baseSize * d->factors.sliderSize();
}

qreal IndustrialTheme::switchSize() const
{
    return d->baseSize * d->factors.switchSize();
}

qreal IndustrialTheme::handleSize() const
{
    return d->baseSize * d->factors.handleSize();
}

qreal IndustrialTheme::checkmarkSize() const
{
    return d->baseSize * d->factors.checkmarkSize();
}

qreal IndustrialTheme::floatSize() const
{
    return d->baseSize * d->factors.floatSize();
}

qreal IndustrialTheme::border() const
{
    return d->baseSize * d->factors.border();
}

void IndustrialTheme::setNight(bool value)
{
    if (d->night != value)
    {
        d->night = value;
        emit this->nightChanged();

        emit this->colorsChanged();
    }
}

void IndustrialTheme::setBaseSize(qreal value)
{
    if (d->baseSize != value)
    {
        d->baseSize = value;
        emit this->baseSizeChanged();

        this->notifySizesChanged();
    }
}

void IndustrialTheme::setScrollInteractive(bool value)
{
    if (d->night != value)
    {
        d->night = value;
        emit this->nightChanged();
    }
}

void IndustrialTheme::setAnimationTime(qreal value)
{
    if (d->night != value)
    {
        d->night = value;
        emit this->nightChanged();
    }
}

void IndustrialTheme::setDayColors(const IndustrialThemeColors& colors)
{
    d->dayColors = colors;
    emit this->dayColorsChanged();

    if (!d->night)
    {
        emit this->colorsChanged();
    }
}

void IndustrialTheme::setNightColors(const IndustrialThemeColors& colors)
{
    d->nightColors = colors;
    emit this->nightColorsChanged();

    if (d->night)
    {
        emit this->colorsChanged();
    }
}

void IndustrialTheme::setFactors(const IndustrialThemeFactors& factors)
{
    d->factors = factors;
    emit this->factorsChanged();

    this->notifySizesChanged();
}
