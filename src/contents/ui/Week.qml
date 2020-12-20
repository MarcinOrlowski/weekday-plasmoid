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
import "../js/themes.js" as Themes

ColumnLayout {
	// we always count from 0 being sunday unless user set different day to be first day of the week
	property int weekdayOffset: 0
	property int firstDayOfWeek: 0

	// https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
	// or PlasmaCore.Theme.* (starting frameworks 5.73)
	property var customColorsTheme: {
		"theme":{"name":"UserTheme"},
		"widget": {
			"bg": plasmoid.configuration.customColorsWidgetBg
		},
		"today": {
			"fg": plasmoid.configuration.customColorsTodayFg,
			"bg": plasmoid.configuration.customColorsTodayBg,
			"bold": plasmoid.configuration.customColorsTodayBold,
			"italic": plasmoid.configuration.customColorsTodayItalic
		},
		"todaySaturday": {
			"enabled": plasmoid.configuration.customColorsTodaySaturdayEnabled,
			"fg": plasmoid.configuration.customColorsTodaySaturdayFg,
			"bg": plasmoid.configuration.customColorsTodaySaturdayBg,
			"bold": plasmoid.configuration.customColorsTodaySaturdayBold,
			"italic": plasmoid.configuration.customColorsTodaySaturdayItalic
		},
		"todaySunday": {
			"enabled": plasmoid.configuration.customColorsTodaySundayEnabled,
			"fg": plasmoid.configuration.customColorsTodaySundayFg,
			"bg": plasmoid.configuration.customColorsTodaySundayBg,
			"bold": plasmoid.configuration.customColorsTodaySundayBold,
			"italic": plasmoid.configuration.customColorsTodaySundayItalic
		},

		"pastDay": {
			"fg": plasmoid.configuration.customColorsPastDayFg,
			"bg": plasmoid.configuration.customColorsPastDayBg,
			"bold": plasmoid.configuration.customColorsPastDayBold,
			"italic": plasmoid.configuration.customColorsPastDayItalic
		},
		"pastSaturday": {
			"enabled": plasmoid.configuration.customColorsPastSaturdayEnabled,
			"fg": plasmoid.configuration.customColorsPastSaturdayFg,
			"bg": plasmoid.configuration.customColorsPastSaturdayBg,
			"bold": plasmoid.configuration.customColorsPastSaturdayBold,
			"italic": plasmoid.configuration.customColorsPastSaturdayItalic
		},
		"pastSunday": {
			"enabled": plasmoid.configuration.customColorsPastSundayEnabled,
			"fg": plasmoid.configuration.customColorsPastSundayFg,
			"bg": plasmoid.configuration.customColorsPastSundayBg,
			"bold": plasmoid.configuration.customColorsPastSundayBold,
			"italic": plasmoid.configuration.customColorsPastSundayItalic
		},

		"futureDay": {
			"fg": plasmoid.configuration.customColorsFutureDayFg,
			"bg": plasmoid.configuration.customColorsFutureDayBg,
			"bold": plasmoid.configuration.customColorsFutureDayBold,
			"italic": plasmoid.configuration.customColorsFutureDayItalic
		},
		"futureSaturday": {
			"enabled": plasmoid.configuration.customColorsFutureSaturdayEnabled,
			"fg": plasmoid.configuration.customColorsFutureSaturdayFg,
			"bg": plasmoid.configuration.customColorsFutureSaturdayBg,
			"bold": plasmoid.configuration.customColorsFutureSaturdayBold,
			"italic": plasmoid.configuration.customColorsFutureSaturdayItalic
		},
		"futureSunday": {
			"enabled": plasmoid.configuration.customColorsFutureSundayEnabled,
			"fg": plasmoid.configuration.customColorsFutureSundayFg,
			"bg": plasmoid.configuration.customColorsFutureSundayBg,
			"bold": plasmoid.configuration.customColorsFutureSundayBold,
			"italic": plasmoid.configuration.customColorsFutureSundayItalic
		}
	}

    // ------------------------------------------------------------------------------------------------------------------------

	// we start from Sunday here
	property var labels: ['', '', '', '', '', '', '']
	property var attrsBg: ['#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff']
	property var attrsFg: ['#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000']
	property var attrsBold: [false, false, false, false, false, false, false]
	property var attrsItalic: [false, false, false, false, false, false, false]

    // ------------------------------------------------------------------------------------------------------------------------

	property string themeName: plasmoid.configuration.themeName
	property var currentTheme: Themes.themes[Themes.defaultTheme]

	onThemeNameChanged: currentTheme = (themeName !== Themes.custom) ? Themes.themes[themeName] : customColorsTheme

	function getCurrentTheme() {
		return (themeName !== Themes.custom) ? Themes.themes[themeName] : customColorsTheme
	}

    // ------------------------------------------------------------------------------------------------------------------------

	function update() {
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

		// get the theme to use
		var theme = Themes.themes[Themes.default]

		redrawWidget(locale, firstDayOfWeek, theme)
	}

	function redrawWidget(locale, firstDayOfWeek, theme) {
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

		var theme = getCurrentTheme()
	
		for(var i=0; i<7; i++) {
			var weekday = (i+firstDayOfWeek) % 7
			fgTmp[i] = getVal(theme, 'fg', i, weekday, todayOffset)
			bgTmp[i] = getVal(theme, 'bg', i, weekday, todayOffset)
			boldTmp[i] = getVal(theme, 'bold', i, weekday, todayOffset)
			italicTmp[i] = getVal(theme, 'italic', i, weekday, todayOffset)
		}

		attrsFg = fgTmp
		attrsBg = bgTmp
		attrsBold = boldTmp
		attrsItalic = italicTmp
	}

    // ------------------------------------------------------------------------------------------------------------------------

	property int timerInterval: 0

	// https://doc.qt.io/qt-5/richtext-html-subset.html
	Timer {
		interval: timerInterval * 1000
		repeat: true
		running: timerInterval != 0
		triggeredOnStart: true
		onTriggered: update()
	}

    // ------------------------------------------------------------------------------------------------------------------------

	function getField(theme, dayKey, key, fallback) {
		return dayKey in theme && theme[dayKey]['enabled'] ? theme[dayKey][key] : fallback
	}

	function getVal(theme, key, index, weekday, todayOffset) {
		var result = ''
		if (index === todayOffset) {
			result = theme['today'][key]
			switch(weekday) {
				case 0: result = getField(theme, 'todaySunday', key, result); break
				case 6: result = getField(theme, 'todaySaturday', key, result); break
			}
		} else if (index < todayOffset) {
			result = theme['pastDay'][key]
			switch(weekday) {
				case 0: result = getField(theme, 'pastSunday', key, result); break
				case 6: result = getField(theme, 'pastSaturday', key, result); break
			}
		} else {
			result = theme['futureDay'][key]
			switch(weekday) {
				case 0: result = getField(theme, 'futureSunday', key, result); break
				case 6: result = getField(theme, 'futureSaturday', key, result); break
			}
		}
		return result
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

		Rectangle {
			anchors.fill: weekGrid
			color: currentTheme['widget']['bg']
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
} // ColumnLayout
