import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

SpinBox {
    id: control

    property real realValue: 0.00
    property real realFrom: -1000.00
    property real realTo: 1000.00
    property real precision: 0.01

    value: realValue / precision
    from: realFrom / precision
    to: realTo / precision
    isValid: !isNaN(realValue)

    validator: Controls.CustomDoubleValidator {
        decimals: getDecimals(precision)
        notation: DoubleValidator.StandardNotation
        bottom: Math.min(realFrom, realTo)
        top: Math.max(realFrom, realTo)
    }

    onRealValueChanged: {
        if (isNaN(realValue)) {
            text = qsTr("N/D");
        } else {
            value = Math.round(realValue / precision);
        }
    }

    onValueChanged: {
        if (caution) validate();
        realValue = (value * precision).toFixed(getDecimals(precision));
    }

    textFromValue: function(value, locale) {
        return (value * precision).toFixed(getDecimals(precision)).replace(".", locale.decimalPoint);
    }

    valueFromText: function(text, locale) {
        var val = parseFloat(text.replace(locale.decimalPoint, '.')) / precision;
        if (val < from) return from;
        if (val > to) return to;
        return val;
    }

    function getDecimals(num) {
        return (num.toString().split('.')[1] || []).length;
    }
}
