#ifndef INDUSTRIAL_THEME_H
#define INDUSTRIAL_THEME_H

// Qt
#include <QColor>
#include <QObject>

#include "export.h"

class INDUSTRIAL_CONTROLS_EXPORT IndustrialThemeFactors
{
    Q_GADGET

    Q_PROPERTY(qreal mainFontSize READ mainFontSize)   // WRITE setMainFontSize)
    Q_PROPERTY(qreal auxFontSize READ auxFontSize)     // WRITE setAuxFontSize)
    Q_PROPERTY(qreal spacing READ spacing)             // WRITE setSpacing)
    Q_PROPERTY(qreal margins READ margins)             // WRITE setMargins)
    Q_PROPERTY(qreal padding READ padding)             // WRITE setPadding)
    Q_PROPERTY(qreal iconSize READ iconSize)           // WRITE setIconSize)
    Q_PROPERTY(qreal scrollSize READ scrollSize)       // WRITE setScrollSize)
    Q_PROPERTY(qreal sliderSize READ sliderSize)       // WRITE setSliderSize)
    Q_PROPERTY(qreal switchSize READ switchSize)       // WRITE setSwitchSize)
    Q_PROPERTY(qreal handleSize READ handleSize)       // WRITE setHandleSize)
    Q_PROPERTY(qreal checkmarkSize READ checkmarkSize) // WRITE setCheckmarkSize)
    Q_PROPERTY(qreal floatSize READ floatSize)         // WRITE setFloatSize)
    Q_PROPERTY(qreal rounding READ rounding)           // WRITE setRounding)
    Q_PROPERTY(qreal underline READ underline)         // WRITE setUnderline)
    Q_PROPERTY(qreal shadow READ shadow)               // WRITE setShadow)
    Q_PROPERTY(qreal border READ border)               // WRITE setBorder)

public:
    QVariantMap toMap() const;
    void fromMap(const QVariantMap& map);

    qreal mainFontSize() const;  // Основной шрифт
    qreal auxFontSize() const;   // Вспомогательный шрифт
    qreal spacing() const;       // Отступы между компонентами
    qreal margins() const;       // Отступы от внешних границ
    qreal padding() const;       // Отступы от внутренних границ
    qreal iconSize() const;      // Размер пиктограм
    qreal scrollSize() const;    // Размер скроллбара
    qreal sliderSize() const;    // Высота слайдера
    qreal switchSize() const;    // Высота свича
    qreal handleSize() const;    // Хендл у слайдеров и свичей
    qreal checkmarkSize() const; // Чекбоксы и радио
    qreal floatSize() const;     // Плавающие кнопки
    qreal rounding() const;      // Радиус скругления
    qreal underline() const;     // Подчёркивание
    qreal shadow() const;        // Размер тени
    qreal border() const;        // Размер бордера

    void setMainFontSize(qreal value);
    void setAuxFontSize(qreal value);
    void setSpacing(qreal value);
    void setMargins(qreal value);
    void setPadding(qreal value);
    void setIconSize(qreal value);
    void setScrollSize(qreal value);
    void setSliderSize(qreal value);
    void setSwitchSize(qreal value);
    void setHandleSize(qreal value);
    void setCheckmarkSize(qreal value);
    void setFloatSize(qreal value);
    void setRounding(qreal value);
    void setUnderline(qreal value);
    void setShadow(qreal value);
    void setBorder(qreal value);

private:
    qreal m_mainFontSize = 0.5;    // Основной шрифт
    qreal m_auxFontSize = 0.4;     // Вспомогательный шрифт
    qreal m_spacing = 0.25;        // Отступы между компонентами
    qreal m_margins = 0.25;        // Отступы от внешних границ
    qreal m_padding = 0.25;        // Отступы от внутренних границ
    qreal m_iconSize = 0.625;      // Размер пиктограм
    qreal m_scrollSize = 0.125;    // Размер скроллбара
    qreal m_sliderSize = 0.125;    // Высота слайдера
    qreal m_switchSize = 0.75;     // Высота свича
    qreal m_handleSize = 0.625;    // Хендл у слайдеров и свичей
    qreal m_checkmarkSize = 0.625; // Чекбоксы и радио
    qreal m_floatSize = 1.25;      // Плавающие кнопки
    qreal m_rounding = 0.125;      // Радиус скругления
    qreal m_underline = 0.0625;    // Подчёркивание
    qreal m_shadow = 0.1;          // Размер тени
    qreal m_border = 0.0625;       // Размер бордера
};

class INDUSTRIAL_CONTROLS_EXPORT IndustrialThemeColors
{
    Q_GADGET

    Q_PROPERTY(QColor raised READ raised)         // WRITE setRaised)
    Q_PROPERTY(QColor background READ background) // WRITE setBackground)
    Q_PROPERTY(QColor sunken READ sunken)         // WRITE setSunken)
    Q_PROPERTY(QColor text READ text)             // WRITE setText)
    Q_PROPERTY(QColor hover READ hover)           // WRITE setHover)
    Q_PROPERTY(QColor border READ border)         // WRITE setBorder)

    Q_PROPERTY(QColor disabled READ disabled) // WRITE setDisabled)

    Q_PROPERTY(QColor control READ control)             // WRITE setControl)
    Q_PROPERTY(QColor controlBorder READ controlBorder) // WRITE setControlBorder)
    Q_PROPERTY(QColor line READ line)                   // WRITE setLine)
    Q_PROPERTY(QColor controlText READ controlText)     // WRITE setControlText)

    Q_PROPERTY(QColor tip READ tip)         // WRITE setTip)
    Q_PROPERTY(QColor tipText READ tipText) // WRITE setTipText)

    Q_PROPERTY(QColor selection READ selection)       // WRITE setSelection)
    Q_PROPERTY(QColor selectedText READ selectedText) // WRITE setSelectedText)

    Q_PROPERTY(QColor highlight READ highlight)             // WRITE setHighlight)
    Q_PROPERTY(QColor highlightedText READ highlightedText) // WRITE setHighlightedText)

    Q_PROPERTY(QColor description READ description) // WRITE setDescription)
    Q_PROPERTY(QColor link READ link)               // WRITE setLink)
    Q_PROPERTY(QColor positive READ positive)       // WRITE setPositive)
    Q_PROPERTY(QColor neutral READ neutral)         // WRITE setNeutral)
    Q_PROPERTY(QColor negative READ negative)       // WRITE setNegative)
    Q_PROPERTY(QColor shadow READ shadow)           // WRITE setShadow)

    Q_PROPERTY(QColor fileIcon READ fileIcon) // WRITE setfileIcon)

public:
    QVariantMap toMap() const;
    void fromMap(const QVariantMap& map);

    QColor raised() const;
    QColor background() const;
    QColor sunken() const;
    QColor text() const;
    QColor hover() const;
    QColor border() const;

    QColor disabled() const;

    QColor control() const;
    QColor controlBorder() const;
    QColor line() const;
    QColor controlText() const;

    QColor tip() const;
    QColor tipText() const;

    QColor selection() const;
    QColor selectedText() const;

    QColor highlight() const;
    QColor highlightedText() const;

    QColor description() const;
    QColor link() const;
    QColor positive() const;
    QColor neutral() const;
    QColor negative() const;
    QColor shadow() const;

    QColor fileIcon() const;

    void setRaised(const QColor& value);
    void setBackground(const QColor& value);
    void setSunken(const QColor& value);
    void setText(const QColor& value);
    void setHover(const QColor& value);
    void setBorder(const QColor& value);

    void setDisabled(const QColor& value);

    void setControl(const QColor& value);
    void setControlBorder(const QColor& value);
    void setLine(const QColor& value);
    void setControlText(const QColor& value);

    void setTip(const QColor& value);
    void setTipText(const QColor& value);

    void setSelection(const QColor& value);
    void setSelectedText(const QColor& value);

    void setHighlight(const QColor& value);
    void setHighlightedText(const QColor& value);

    void setDescription(const QColor& value);
    void setLink(const QColor& value);
    void setPositive(const QColor& value);
    void setNeutral(const QColor& value);
    void setNegative(const QColor& value);
    void setShadow(const QColor& value);

    void setfileIcon(const QColor& value);

private:
    QColor m_raised = "#334248"; // Фон возвышенных элементов (панели)
    QColor m_background = "#2c393f"; // Фона окна
    QColor m_sunken =
        "#212c30"; // Фон утопленных элементов (поля ввода, фон слайдеров и чекбоксов и т.д)
    QColor m_text =
        "#ffffff"; // Текст (иконки и другие элементы на фоне окна, утопленных и возвышенных элементов)
    QColor m_hover = "#3319d6c4"; // Подсветка элемента при наведении мыши
    QColor m_border = "#2c393f"; // Цвет обводки

    QColor m_disabled = "#4F5D64"; // Неактивный цвет (штриховка на контролах, отключенные элементы

    QColor m_control = "#5a717c"; // Фон больших управляющих элементов (кнопки)
    QColor m_controlBorder =
        "#6c8693"; // Фон и обводка мелких управляющих элементов (хендлы, переключатели)
    QColor m_line = "#805a717c";      // Линии, цвет control + 0.5 прозрачность
    QColor m_controlText = "#ffffff"; // Текст кнопки

    QColor m_tip = "#009688";     // Фон подсказки
    QColor m_tipText = "#ffffff"; // Текст подсказки

    QColor m_selection = "#009688";    // Фон выделения
    QColor m_selectedText = "#ffffff"; // Текст выделения

    QColor m_highlight = "#19d6c4";       // Фон подсветки (при активации)
    QColor m_highlightedText = "#000000"; // Текст подсветки

    QColor m_description = "#899ea9"; // Вспомогательный текст
    QColor m_link = "#51a0e7"; // Ссылка (на фоне окна, утопленных и возвышенных элементов)
    QColor m_positive = "#86c34a"; // Позитивный (текст и предупреждения)
    QColor m_neutral = "#ff9800"; // Нейтральный (текст и предупреждения)
    QColor m_negative = "#e53535"; // Негативный (текст и предупреждения)
    QColor m_shadow = "#80000000"; // Тень

    QColor m_fileIcon = "#eabf3f"; // Иконка файла (FileBrowser)
};

class INDUSTRIAL_CONTROLS_EXPORT IndustrialTheme : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool night READ night WRITE setNight NOTIFY nightChanged)
    Q_PROPERTY(qreal baseSize READ baseSize WRITE setBaseSize NOTIFY baseSizeChanged)
    Q_PROPERTY(bool scrollInteractive READ scrollInteractive WRITE setScrollInteractive NOTIFY
                   scrollInteractiveChanged)
    Q_PROPERTY(
        qreal animationTime READ animationTime WRITE setAnimationTime NOTIFY animationTimeChanged)

    Q_PROPERTY(
        IndustrialThemeColors dayColors READ dayColors WRITE setDayColors NOTIFY dayColorsChanged)
    Q_PROPERTY(IndustrialThemeColors nightColors READ nightColors WRITE setNightColors NOTIFY
                   nightColorsChanged)

    Q_PROPERTY(IndustrialThemeFactors factors READ factors WRITE setFactors NOTIFY factorsChanged)

    Q_PROPERTY(IndustrialThemeColors colors READ colors NOTIFY colorsChanged)

    Q_PROPERTY(qreal rounding READ rounding NOTIFY roundingChanged)
    Q_PROPERTY(qreal underline READ underline NOTIFY underlineChanged)
    Q_PROPERTY(qreal shadowSize READ shadowSize NOTIFY shadowSizeChanged)

    Q_PROPERTY(qreal mainFontSize READ mainFontSize NOTIFY mainFontSizeChanged)
    Q_PROPERTY(qreal auxFontSize READ auxFontSize NOTIFY auxFontSizeChanged)
    Q_PROPERTY(qreal spacing READ spacing NOTIFY spacingChanged)
    Q_PROPERTY(qreal margins READ margins NOTIFY marginsChanged)
    Q_PROPERTY(qreal padding READ padding NOTIFY paddingChanged)
    Q_PROPERTY(int iconSize READ iconSize NOTIFY iconSizeChanged)
    Q_PROPERTY(qreal scrollSize READ scrollSize NOTIFY scrollSizeChanged)
    Q_PROPERTY(qreal sliderSize READ sliderSize NOTIFY sliderSizeChanged)
    Q_PROPERTY(qreal switchSize READ switchSize NOTIFY switchSizeChanged)
    Q_PROPERTY(qreal handleSize READ handleSize NOTIFY handleSizeChanged)
    Q_PROPERTY(qreal checkmarkSize READ checkmarkSize NOTIFY checkmarkSizeChanged)
    Q_PROPERTY(qreal floatSize READ floatSize NOTIFY floatSizeChanged)
    Q_PROPERTY(qreal border READ border NOTIFY borderChanged)

public:
    enum ButtonType
    {
        Primary,
        Secondary,
        Negative,
        Neutral,
        Positive,
        LinkPrimary,
        LinkSecondary
    };

    enum LabelType
    {
        Text,
        Label,
        Title
    };

    enum StandardButtonsButtons
    {
        Yes,
        Ok,
        Apply,
        Open,
        Save,
        Restore,
        Reset,
        Cancel,
        No,
        Close
    };

    ~IndustrialTheme();

    static IndustrialTheme* instance();

    bool night() const;
    qreal baseSize() const;
    bool scrollInteractive() const;
    qreal animationTime() const;

    const IndustrialThemeColors& dayColors() const;
    const IndustrialThemeColors& nightColors() const;

    const IndustrialThemeFactors& factors() const;

    const IndustrialThemeColors& colors() const;

    qreal rounding() const;
    qreal underline() const;
    qreal shadowSize() const;

    qreal mainFontSize() const;
    qreal auxFontSize() const;
    qreal spacing() const;
    qreal margins() const;
    qreal padding() const;
    int iconSize() const;
    qreal scrollSize() const;
    qreal sliderSize() const;
    qreal switchSize() const;
    qreal handleSize() const;
    qreal checkmarkSize() const;
    qreal floatSize() const;
    qreal border() const;

    void setNight(bool value);
    void setBaseSize(qreal value);
    void setScrollInteractive(bool value);
    void setAnimationTime(qreal value);

    void setDayColors(const IndustrialThemeColors& colors);
    void setNightColors(const IndustrialThemeColors& colors);

    void setFactors(const IndustrialThemeFactors& factors);

signals:
    void nightChanged();
    void baseSizeChanged();
    void scrollInteractiveChanged();
    void animationTimeChanged();

    void dayColorsChanged();
    void nightColorsChanged();

    void factorsChanged();

    void colorsChanged();

    void roundingChanged();
    void underlineChanged();
    void shadowSizeChanged();

    void mainFontSizeChanged();
    void auxFontSizeChanged();
    void spacingChanged();
    void marginsChanged();
    void paddingChanged();
    void iconSizeChanged();
    void scrollSizeChanged();
    void sliderSizeChanged();
    void switchSizeChanged();
    void handleSizeChanged();
    void checkmarkSizeChanged();
    void floatSizeChanged();
    void borderChanged();

private:
    IndustrialTheme(QObject* parent = nullptr);

    void notifySizesChanged();

    class Impl;
    QScopedPointer<Impl> d;

    Q_ENUM(ButtonType);
    Q_ENUM(LabelType);
    Q_ENUM(StandardButtonsButtons);
};
Q_DECLARE_METATYPE(IndustrialThemeFactors)
Q_DECLARE_METATYPE(IndustrialThemeColors)

#endif // INDUSTRIAL_THEME_H
