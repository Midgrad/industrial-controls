#include "svg_item.h"

#include <QSvgRenderer>
#include <QGuiApplication>
#include <QScreen>
#include <QPainter>

namespace
{
const QString absolute = "file://";
const QString local = "file:";
const QString qrc = "qrc";
const QString colon = ":";
const QString slash = "/";

const QStringList colors = { "white", "#ffffff" };

QString formatSource(QString source)
{
    if (source.startsWith(qrc))
        source.remove(0, qrc.size());

    if (source.startsWith(slash))
        source = colon + source;

    if (source.startsWith(absolute))
        source.remove(0, absolute.size());
    else if (source.startsWith(local))
        source.remove(0, local.size());

    return source;
}
} // namespace

SvgItem::SvgItem(QQuickItem* parent) : QQuickPaintedItem(parent), m_color(Qt::white)
{
}

void SvgItem::paint(QPainter* painter)
{
    if (!m_renderer)
        return;

    const qreal pixelRatio = qApp->primaryScreen()->devicePixelRatio();
    painter->scale(1 / pixelRatio, 1 / pixelRatio);

    m_renderer->render(painter);
}

QString SvgItem::source() const
{
    return m_source;
}

QString SvgItem::content() const
{
    return m_content;
}

QColor SvgItem::color() const
{
    return m_color;
}

void SvgItem::setSource(const QString& source)
{
    if (m_source == source)
        return;

    m_source = source;

    this->prerender();
    emit sourceChanged(m_source);
}

void SvgItem::setContent(const QString& content)
{
    if (m_content == content)
        return;

    m_content = content;

    this->prerender();
    emit contentChanged(m_content);
}

void SvgItem::setColor(const QColor& color)
{
    if (m_color == color)
        return;

    m_color = color;

    this->prerender();
    emit colorChanged(m_color);
}

void SvgItem::prerender()
{
    if (m_renderer)
    {
        delete m_renderer;
        m_renderer = nullptr;
    }

    QString content = m_content;

    if (!m_source.isEmpty())
    {
        QFile file(::formatSource(m_source));
        if (file.open(QIODevice::ReadOnly))
            content = file.readAll();
    }

    if (content.isEmpty())
        return;

    for (const QString& color : ::colors)
    {
        content = content.replace(color, m_color.name());
    }

    m_renderer = new QSvgRenderer(content.toLocal8Bit(), this);
    this->update();
}
