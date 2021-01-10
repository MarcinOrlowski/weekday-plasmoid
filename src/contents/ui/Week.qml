/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "../js/themes.js" as Themes
import "../js/DateTimeFormatter.js" as DTF

ColumnLayout {
	// we always count from 0 being sunday unless user set different day to be first day of the week
	property int weekdayOffset: 0
	property int firstDayOfWeek: 0

	// https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
	// or PlasmaCore.Theme.* (starting frameworks 5.73)

    // ------------------------------------------------------------------------------------------------------------------------

	property string themeName: plasmoid.configuration.themeName

	function getUserTheme() {
		return {
			"theme": {"name": "UserTheme1"},
			"widget": {
				"bg": plasmoid.configuration.widgetBg
			},

			"past": {
				"fg": plasmoid.configuration.pastFg,
				"bg": plasmoid.configuration.pastBg,
				"bold": plasmoid.configuration.pastBold,
				"italic": plasmoid.configuration.pastItalic
			},
			"pastSaturday": {
				"enabled": plasmoid.configuration.pastSaturdayEnabled,
				"fg": plasmoid.configuration.pastSaturdayFg,
				"bg": plasmoid.configuration.pastSaturdayBg,
				"bold": plasmoid.configuration.pastSaturdayBold,
				"italic": plasmoid.configuration.pastSaturdayItalic
			},
			"pastSunday": {
				"enabled": plasmoid.configuration.pastSundayEnabled,
				"fg": plasmoid.configuration.pastSundayFg,
				"bg": plasmoid.configuration.pastSundayBg,
				"bold": plasmoid.configuration.pastSundayBold,
				"italic": plasmoid.configuration.pastSundayItalic
			},

			"today": {
				"fg": plasmoid.configuration.todayFg,
				"bg": plasmoid.configuration.todayBg,
				"bold": plasmoid.configuration.todayBold,
				"italic": plasmoid.configuration.todayItalic
			},
			"todaySaturday": {
				"enabled": plasmoid.configuration.todaySaturdayEnabled,
				"fg": plasmoid.configuration.todaySaturdayFg,
				"bg": plasmoid.configuration.todaySaturdayBg,
				"bold": plasmoid.configuration.todaySaturdayBold,
				"italic": plasmoid.configuration.todaySaturdayItalic
			},
			"todaySunday": {
				"enabled": plasmoid.configuration.todaySundayEnabled,
				"fg": plasmoid.configuration.todaySundayFg,
				"bg": plasmoid.configuration.todaySundayBg,
				"bold": plasmoid.configuration.todaySundayBold,
				"italic": plasmoid.configuration.todaySundayItalic
			},

			"future": {
				"fg": plasmoid.configuration.futureFg,
				"bg": plasmoid.configuration.futureBg,
				"bold": plasmoid.configuration.futureBold,
				"italic": plasmoid.configuration.futureItalic
			},
			"futureSaturday": {
				"enabled": plasmoid.configuration.futureSaturdayEnabled,
				"fg": plasmoid.configuration.futureSaturdayFg,
				"bg": plasmoid.configuration.futureSaturdayBg,
				"bold": plasmoid.configuration.futureSaturdayBold,
				"italic": plasmoid.configuration.futureSaturdayItalic
			},
			"futureSunday": {
				"enabled": plasmoid.configuration.futureSundayEnabled,
				"fg": plasmoid.configuration.futureSundayFg,
				"bg": plasmoid.configuration.futureSundayBg,
				"bold": plasmoid.configuration.futureSundayBold,
				"italic": plasmoid.configuration.futureSundayItalic
			}
		}
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

		var currentTheme
		if (themeName === Themes.custom) {
			currentTheme = getUserTheme()
		} else {
			currentTheme = Themes.themes[themeName]
		}

		redrawWidget(locale, firstDayOfWeek, currentTheme)
	}

	function redrawWidget(locale, firstDayOfWeek, theme) {
		// we start from Sunday here
		// it's known that Jan 5, 2020 is Sunday
		// so we shift the index offset (based on locale) so the first
		// cell of 'labels' is always first day of the week.
		var labels = ['?', '?', '?', '?', '?', '?', '?']
		var bgs = ['#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff']
		var fgs = ['#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000']
		var bolds = [false, false, false, false, false, false, false]
		var italics = [false, false, false, false, false, false, false]

		for(var i=0; i<7; i++) {
			// it's known that Jan 5, 2020 is Sunday
			var day = new Date(2020, 0, 5 + (firstDayOfWeek + i))
			labels[i] = day.toLocaleDateString(locale, 'ddd').substr(0, 1).toUpperCase()
		}

		var now = new Date()
		weekdayOffset = now.getDay()-firstDayOfWeek
		if (weekdayOffset < 0) weekdayOffset += 7

		// Where's Today's cell in our week grid?
		var todayOffset = now.getDay() - firstDayOfWeek
		if (todayOffset < 0) todayOffset += 7

		for(var i=0; i<7; i++) {
			var weekday = (i+firstDayOfWeek) % 7
			fgs[i] = getVal(theme, 'fg', i, weekday, todayOffset)
			bgs[i] = getVal(theme, 'bg', i, weekday, todayOffset)
			bolds[i] = getVal(theme, 'bold', i, weekday, todayOffset)
			italics[i] = getVal(theme, 'italic', i, weekday, todayOffset)
		}

		// FIXME: this is lame, but I couldn't make QML notice value changes within
		// JS objects (dicts). Copying values out to separate properties seem to work.
		widgetBg = theme['widget']['bg']

		var i=0
		day0Label = labels[i]
		day0Fg = fgs[i]
		day0Bg = bgs[i]
		day0Bold = bolds[i]
		day0Italic = italics[i]

		i++
		day1Label = labels[i]
		day1Fg = fgs[i]
		day1Bg = bgs[i]
		day1Bold = bolds[i]
		day1Italic = italics[i]

		i++
		day2Label = labels[i]
		day2Fg = fgs[i]
		day2Bg = bgs[i]
		day2Bold = bolds[i]
		day2Italic = italics[i]

		i++
		day3Label = labels[i]
		day3Fg = fgs[i]
		day3Bg = bgs[i]
		day3Bold = bolds[i]
		day3Italic = italics[i]

		i++
		day4Label = labels[i]
		day4Fg = fgs[i]
		day4Bg = bgs[i]
		day4Bold = bolds[i]
		day4Italic = italics[i]

		i++
		day5Label = labels[i]
		day5Fg = fgs[i]
		day5Bg = bgs[i]
		day5Bold = bolds[i]
		day5Italic = italics[i]

		i++
		day6Label = labels[i]
		day6Fg = fgs[i]
		day6Bg = bgs[i]
		day6Bold = bolds[i]
		day6Italic = italics[i]
	}

    // ------------------------------------------------------------------------------------------------------------------------

	readonly property string defaultLabel: '?'
	readonly property string defaultFg: '#FF888888'
	readonly property string defaultBg: '#00000000'
	readonly property bool defaultBold: false
	readonly property bool defaultItalic: false

	property string widgetBg: defaultBg

	property string day0Label: defaultLabel
	property string day0Fg: defaultFg
	property string day0Bg: defaultBg
	property bool day0Bold: defaultBold
	property bool day0Italic: defaultItalic

	property string day1Label: defaultLabel
	property string day1Fg: defaultFg
	property string day1Bg: defaultBg
	property bool day1Bold: defaultBold
	property bool day1Italic: defaultItalic

	property string day2Label: defaultLabel
	property string day2Fg: defaultFg
	property string day2Bg: defaultBg
	property bool day2Bold: defaultBold
	property bool day2Italic: defaultItalic

	property string day3Label: defaultLabel
	property string day3Fg: defaultFg
	property string day3Bg: defaultBg
	property bool day3Bold: defaultBold
	property bool day3Italic: defaultItalic

	property string day4Label: defaultLabel
	property string day4Fg: defaultFg
	property string day4Bg: defaultBg
	property bool day4Bold: defaultBold
	property bool day4Italic: defaultItalic

	property string day5Label: defaultLabel
	property string day5Fg: defaultFg
	property string day5Bg: defaultBg
	property bool day5Bold: defaultBold
	property bool day5Italic: defaultItalic

	property string day6Label: defaultLabel
	property string day6Fg: defaultFg
	property string day6Bg: defaultBg
	property bool day6Bold: defaultBold
	property bool day6Italic: defaultItalic

	property int cnt: 0

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
			result = theme['past'][key]
			switch(weekday) {
				case 0: result = getField(theme, 'pastSunday', key, result); break
				case 6: result = getField(theme, 'pastSaturday', key, result); break
			}
		} else {
			result = theme['future'][key]
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
			color: widgetBg
		}

		Day {
			label: day0Label
			fg: day0Fg
			bg: day0Bg
			bold: day0Bold
			italic: day0Italic
		}
		Day {
			label: day1Label
			fg: day1Fg
			bg: day1Bg
			bold: day1Bold
			italic: day1Italic
		}
		Day {
			label: day2Label
			fg: day2Fg
			bg: day2Bg
			bold: day2Bold
			italic: day2Italic
		}
		Day {
			label: day3Label
			fg: day3Fg
			bg: day3Bg
			bold: day3Bold
			italic: day3Italic
		}
		Day {
			label: day4Label
			fg: day4Fg
			bg: day4Bg
			bold: day4Bold
			italic: day4Italic
		}
		Day {
			label: day5Label
			fg: day5Fg
			bg: day5Bg
			bold: day5Bold
			italic: day5Italic
		}
		Day {
			label: day6Label
			fg: day6Fg
			bg: day6Bg
			bold: day6Bold
			italic: day6Italic
		}
	} // weekGrid
} // ColumnLayout
