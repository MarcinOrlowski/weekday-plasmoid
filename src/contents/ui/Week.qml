/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

ColumnLayout {
	id: container

    // ------------------------------------------------------------------------------------------------------------------------

	// we always count from 0 being sunday
	property int weekdayOffset: 0
	property int firstDayOfWeek: 0

	readonly property bool ccEnabled: plasmoid.configuration.customColorsEnabled

	// https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
	// or PlasmaCore.Theme.* (starting frameworks 5.73)
	property string pastDayFg: ccEnabled ? plasmoid.configuration.customColorsPastDayFg : theme.disabledTextColor
	property string pastDayBg: ccEnabled ? plasmoid.configuration.customColorsPastDayBg : theme.backgroundColor
	property bool pastDayBold: ccEnabled ? plasmoid.configuration.customColorsPastDayBold: false
	property bool pastDayItalic: ccEnabled ? plasmoid.configuration.customColorsPastDayItalic: false

	property string todayFg: ccEnabled ? plasmoid.configuration.customColorsTodayFg : "#FFffffff"
	property string todayBg: ccEnabled ? plasmoid.configuration.customColorsTodayBg : "#FFff006e"
	property bool todayBold: ccEnabled ? plasmoid.configuration.customColorsTodayBold: true
	property bool todayItalic: ccEnabled ? plasmoid.configuration.customColorsTodayItalic: false

	property string futureDayFg: ccEnabled ? plasmoid.configuration.customColorsFutureDayFg : theme.textColor
	property string futureDayBg: ccEnabled ? plasmoid.configuration.customColorsFutureDayBg : theme.backgroundColor
	property bool futureDayBold: ccEnabled ? plasmoid.configuration.customColorsFutureDayBold: false
	property bool futureDayItalic: ccEnabled ? plasmoid.configuration.customColorsFutureDayItalic: false

	// we start from Sunday here
	property var labels: ['', '', '', '', '', '', '']

    // ------------------------------------------------------------------------------------------------------------------------

	// https://doc.qt.io/qt-5/richtext-html-subset.html
	Timer {
		interval: 1000
		repeat: true
		running: true
		triggeredOnStart: true
		onTriggered: {
			// https://doc.qt.io/qt-5/qml-qtqml-locale.html
			// Offset indicates first day of week with Sunday equals 0
			// and Saturday equals 6
			// https://doc.qt.io/qt-5/qml-qtqml-locale.html#firstDayOfWeek-prop

			var localeToUse = plasmoid.configuration.useSpecificLocaleEnabled ? plasmoid.configuration.useSpecificLocaleLocaleName : ''

			var locale = Qt.locale(localeToUse)
			firstDayOfWeek = locale.firstDayOfWeek

			if (plasmoid.configuration.nonDefaultWeekStartDayEnabled) {
				firstDayOfWeek = plasmoid.configuration.nonDefaultWeekStartDayDayIndex
			} else {
				var locale = Qt.locale(localeToUse)
				firstDayOfWeek = locale.firstDayOfWeek
			}

			var now = new Date()
			weekdayOffset = now.getDay()-firstDayOfWeek
			if (weekdayOffset < 0) weekdayOffset += 7

			// it's known that Jan 5, 2020 is Sunday
			// so we shift the index offset (based on locale) so the first
			// cell of 'labels' is always first day of the week.
			var tmp = ['', '', '', '', '', '', '']

			for(var i=0; i<7; i++) {
				// it's known that Jan 5, 2020 is Sunday
				var day = new Date(2020, 0, 5+firstDayOfWeek+i)
				tmp[i] = day.toLocaleDateString(locale, 'ddd').substr(0, 1).toUpperCase()
			}
			labels = tmp
		}
	}

    // ------------------------------------------------------------------------------------------------------------------------

	GridLayout {
		id: weekGrid
		columns: 7
		rows: 1
		Layout.fillWidth: true
		Layout.fillHeight: true
		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
		columnSpacing: 0

		readonly property int cellMinWidth: 16

		Repeater {
			model: 7
			Day {
				label: labels[index]
				fg: {
					if (index === weekdayOffset) return todayFg
					return (index < weekdayOffset) ? pastDayFg : futureDayFg
				}
				bg: {
					if (index === weekdayOffset) return todayBg
					return (index < weekdayOffset) ? pastDayBg : futureDayBg
				}
				bold: {
					if (index === weekdayOffset) return todayBold
					return (index < weekdayOffset) ? pastDayBold : futureDayBold
				}
				italic: {
					if (index === weekdayOffset) return todayItalic
					return (index < weekdayOffset) ? pastDayItalic : futureDayItalic
				}
			}
		}
	} // weekGrid

} // container
