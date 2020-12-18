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
import org.kde.kquickcontrolsaddons 2.0 as KQCA

ColumnLayout {
	id: container

    // ------------------------------------------------------------------------------------------------------------------------

	// we always count from 0 being sunday unless user set different day to be first day of the week
	property int weekdayOffset: 0
	property int firstDayOfWeek: 0

	readonly property bool ccEnabled: plasmoid.configuration.customColorsEnabled

	// https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
	// or PlasmaCore.Theme.* (starting frameworks 5.73)

	readonly property string widgetBg: ccEnabled ? plasmoid.configuration.customColorsWidgetBg : theme.backgroundColor

	readonly property string pastDayFg: ccEnabled ? plasmoid.configuration.customColorsPastDayFg : theme.disabledTextColor
	readonly property string pastDayBg: ccEnabled ? plasmoid.configuration.customColorsPastDayBg : widgetBg
	readonly property bool pastDayBold: ccEnabled ? plasmoid.configuration.customColorsPastDayBold : false
	readonly property bool pastDayItalic: ccEnabled ? plasmoid.configuration.customColorsPastDayItalic : false

	readonly property string todayFg: ccEnabled ? plasmoid.configuration.customColorsTodayFg : "#FFffffff"
	readonly property string todayBg: ccEnabled ? plasmoid.configuration.customColorsTodayBg : "#FFff006e"
	readonly property bool todayBold: ccEnabled ? plasmoid.configuration.customColorsTodayBold : true
	readonly property bool todayItalic: ccEnabled ? plasmoid.configuration.customColorsTodayItalic : false

	readonly property string futureDayFg: ccEnabled ? plasmoid.configuration.customColorsFutureDayFg : theme.textColor
	readonly property string futureDayBg: ccEnabled ? plasmoid.configuration.customColorsFutureDayBg : widgetBg
	readonly property bool futureDayBold: ccEnabled ? plasmoid.configuration.customColorsFutureDayBold : false
	readonly property bool futureDayItalic: ccEnabled ? plasmoid.configuration.customColorsFutureDayItalic : false

	readonly property bool ccSaturdayEnabled: plasmoid.configuration.customColorsFutureSaturdayEnabled
	readonly property string futureSaturdayFg: ccSaturdayEnabled ? plasmoid.configuration.customColorsFutureSaturdayFg : futureDayFg
	readonly property string futureSaturdayBg: ccSaturdayEnabled ? plasmoid.configuration.customColorsFutureSaturdayBg : futureDayBg
	readonly property bool futureSaturdayBold: ccSaturdayEnabled ? plasmoid.configuration.customColorsFutureSaturdayBold : futureDayBold
	readonly property bool futureSaturdayItalic: ccSaturdayEnabled ? plasmoid.configuration.customColorsFutureSaturdayItalic : futureDayItalic

	readonly property bool ccSundayEnabled: plasmoid.configuration.customColorsFutureSundayEnabled
	readonly property string futureSundayFg: ccSundayEnabled ? plasmoid.configuration.customColorsFutureSundayFg : futureDayFg
	readonly property string futureSundayBg: ccSundayEnabled ? plasmoid.configuration.customColorsFutureSundayBg : futureDayBg
	readonly property bool futureSundayBold: ccSundayEnabled ? plasmoid.configuration.customColorsFutureSundayBold : futureDayBold
	readonly property bool futureSundayItalic: ccSundayEnabled ? plasmoid.configuration.customColorsFutureSundayItalic : futureDayItalic

	// we start from Sunday here
	property var labels: ['', '', '', '', '', '', '']
	property var attrsBg: ['#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff']
	property var attrsFg: ['#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000']
	property var attrsBold: [false, false, false, false, false, false, false]
	property var attrsItalic: [false, false, false, false, false, false, false]

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

			// it's known that Jan 5, 2020 is Sunday
			// so we shift the index offset (based on locale) so the first
			// cell of 'labels' is always first day of the week.
			var tmp = ['', '', '', '', '', '', '']

			for(var i=0; i<7; i++) {
				// it's known that Jan 5, 2020 is Sunday
				var day = new Date(2020, 0, 5 + (firstDayOfWeek + i))
				tmp[i] = day.toLocaleDateString(locale, 'ddd').substr(0, 1).toUpperCase()
			}
			labels = tmp

			// fg colors
			var fgTmp = ['#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff']
			var bgTmp = ['#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000']
			var boldTmp = [false, false, false, false, false, false, false]
			var italicTmp = [false, false, false, false, false, false, false]

			var now = new Date()
			weekdayOffset = now.getDay()-firstDayOfWeek
			if (weekdayOffset < 0) weekdayOffset += 7

			// Where's Today's cell in our week grid?
			var todayOffset = now.getDay() - firstDayOfWeek
			if (todayOffset < 0) todayOffset += 7
	
			for(var i=0; i<7; i++) {
				var weekday = (i+firstDayOfWeek) % 7
				fgTmp[i] = getFg(i, weekday, todayOffset)
				bgTmp[i] = getBg(i, weekday, todayOffset)
				boldTmp[i] = getBold(i, weekday, todayOffset)
				italicTmp[i] = getItalic(i, weekday, todayOffset)
			}

			attrsFg = fgTmp
			attrsBg = bgTmp
			attrsBold = boldTmp
			attrsItalic = italicTmp

//		KQCA.Clipboard.setMode('text/plain')
//		KQCA.Clipboard.setContent('ofooooo')
		clipboard.content = now
		}
	}

	KQCA.Clipboard {
		id: clipboard
		// content: 'foo'
	}

    // ------------------------------------------------------------------------------------------------------------------------

	function getFg(index, weekday, todayOffset) {
		if (index === todayOffset) return todayFg
		if (index < todayOffset) return pastDayFg
		var result = futureDayFg
		switch(weekday) {
			case 0: result = futureSundayFg; break
			case 6: result = futureSaturdayFg; break
		}
		return result
	}
	function getBg(index, weekday, todayOffset) {
		if (index === todayOffset) return todayBg
		if (index < todayOffset) return pastDayBg
		var result = futureDayBg
		switch(weekday) {
			case 0: result = futureSundayBg; break
			case 6: result = futureSaturdayBg; break
		}
		return result
	}
	function getBold(index, weekday, todayOffset) {
		if (index === todayOffset) return todayBold
		if (index < todayOffset) return pastDayBold
		var result = futureDayBold
		switch(weekday) {
			case 0: result = futureSundayBold; break
			case 6: result = futureSaturdayBold; break
		}
		return result
	}
	function getItalic(index, weekday, todayOffset) {
		if (index === todayOffset) return todayItalic
		if (index < todayOffset) return pastDayItalic
		var result = futureDayItalic
		switch(weekday) {
			case 0: result = futureSundayItalic; break
			case 6: result = futureSaturdayItalic; break
		}
		return result
	}

	GridLayout {
		id: weekGrid
		columns: 7
		rows: 1
		Layout.fillWidth: true
		Layout.fillHeight: true
		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
		columnSpacing: 0

		readonly property int cellMinWidth: 16

		Rectangle {
			anchors.fill: weekGrid
			color: widgetBg
		}

		Repeater {
			model: 7
			Day {
				label: labels[index]
				fg: attrsFg[index]
				bg: attrsBg[index]
				bold: attrsBold[index]
				italic: attrsItalic[index]
			}
		}
	} // weekGrid

} // container
