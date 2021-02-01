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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import "../js/themes.js" as Themes
import "../js/DateTimeFormatter.js" as DTF

ColumnLayout {
	// we always count from 0 being sunday unless user set different day to be first day of the week
	property int firstDayOfWeek: 0

	// https://api.kde.org/frameworks/plasma-framework/html/classPlasma_1_1QuickTheme.html
	// or PlasmaCore.Theme.* (starting frameworks 5.73)

	// ------------------------------------------------------------------------------------------------------------------------

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		onClicked: {
			if (plasmoid.configuration.calendarViewEnabled) {
				plasmoid.expanded = !plasmoid.expanded
			}
		}
	}

	// ------------------------------------------------------------------------------------------------------------------------

	function getUserTheme() {
		return {
			"theme": {"name": "UserTheme1"},
			"widget": {
				"bg": plasmoid.configuration.widgetBg
			},

			"lastDayMonth": {
				"enabled": plasmoid.configuration.lastDayMonthEnabled,
				"bg": plasmoid.configuration.lastDayMonthBg
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

	function updateWeekGrid() {
		// https://doc.qt.io/qt-5/qml-qtqml-locale.html
		// Offset indicates first day of week with Sunday equals 0
		// and Saturday equals 6
		// https://doc.qt.io/qt-5/qml-qtqml-locale.html#firstDayOfWeek-prop
		var localeToUse = plasmoid.configuration.useSpecificLocaleEnabled
				? plasmoid.configuration.useSpecificLocaleLocaleName 
				: ''

		var locale = Qt.locale(localeToUse)
		firstDayOfWeek = locale.firstDayOfWeek

		if (plasmoid.configuration.useFakeParameters) {
			firstDayOfWeek = plasmoid.configuration.fakeWeekStartDay
		} else if (plasmoid.configuration.nonDefaultWeekStartDayEnabled) {
			firstDayOfWeek = plasmoid.configuration.nonDefaultWeekStartDayDayIndex
		}

		var themeKey = plasmoid.configuration.themeName
		if (themeKey === Themes.defaultTheme) {
			themeKey = Themes.defaultThemeKey
		}
		var currentTheme = plasmoid.configuration.useUserTheme
								? getUserTheme() 
								: Themes.themes[themeKey]

		redrawWidget(locale, firstDayOfWeek, currentTheme)
	}

	// dayIdx starts from 0 being Sunday, 6 being Saturday
	function getDayLabel(dayIdx, fallback) {
		var label = fallback
		if (plasmoid.configuration.customDayLabelsEnabled) {
			if (dayIdx === 0 && plasmoid.configuration.customDayLabelSundayEnabled) {
				label = plasmoid.configuration.customDayLabelSundayLabel.substr(0, 1)
			}
			if (dayIdx === 1 && plasmoid.configuration.customDayLabelMondayEnabled) {
				label = plasmoid.configuration.customDayLabelMondayLabel.substr(0, 1)
			}
			if (dayIdx === 2 && plasmoid.configuration.customDayLabelTuesdayEnabled) {
				label = plasmoid.configuration.customDayLabelTuesdayLabel.substr(0, 1)
			}
			if (dayIdx === 3 && plasmoid.configuration.customDayLabelWednesdayEnabled) {
				label = plasmoid.configuration.customDayLabelWednesdayLabel.substr(0, 1)
			}
			if (dayIdx === 4 && plasmoid.configuration.customDayLabelThursdayEnabled) {
				label = plasmoid.configuration.customDayLabelThursdayLabel.substr(0, 1)
			}
			if (dayIdx === 5 && plasmoid.configuration.customDayLabelFridayEnabled) {
				label = plasmoid.configuration.customDayLabelFridayLabel.substr(0, 1)
			}
			if (dayIdx === 6 && plasmoid.configuration.customDayLabelSaturdayEnabled) {
				label = plasmoid.configuration.customDayLabelSaturdayLabel.substr(0, 1)
			}
		}
		return label
	}

	function redrawWidget(locale, firstDayOfWeek, theme) {
		// We always start our arrays with first element being first day of the week
		// whatever that day is.

		var labels = ['?', '?', '?', '?', '?', '?', '?']
		var bgs = ['#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff', '#FFffffff']
		var fgs = ['#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000', '#00000000']
		var bolds = [false, false, false, false, false, false, false]
		var italics = [false, false, false, false, false, false, false]
		var lastDayMonth = [false, false, false, false, false, false, false]

		// It's known that Jan 6, 1980 is Sunday, so I use this as reference to calculate for weekday offset,
		// as this can be user configurable indepenently from real calendar specification, which is just fine
		// as all we need to get here is weekday names.
		for(var i=0; i<7; i++) {
			var offset = firstDayOfWeek + i
			var d = new Date(1980, 0, 6 + offset)
			labels[i] = getDayLabel((offset % 7), d.toLocaleDateString(locale, 'ddd').substr(0, 1).toUpperCase())
		}

		// Which grid cell means Today?
		var now = new Date()
		var today = plasmoid.configuration.useFakeParameters ? plasmoid.configuration.fakeToday : now.getDay()
		var offsetOfToday = today - firstDayOfWeek
		if (offsetOfToday < 0) offsetOfToday += 7

		// Let's shift our date objects to first day of the week (matching our settings)
		// We cannot use offsetOfToday as it is always positive (wrapped) value, which is
		// not what we need here.
		var today = new Date()
		today.setDate(today.getDate() - today.getDay() + firstDayOfWeek)
		for(var i=0; i<7; i++) {
			var weekday = (i+firstDayOfWeek) % 7
			fgs[i] = getVal(theme, 'fg', i, weekday, offsetOfToday)
			bgs[i] = getVal(theme, 'bg', i, weekday, offsetOfToday)
			bolds[i] = getVal(theme, 'bold', i, weekday, offsetOfToday)
			italics[i] = getVal(theme, 'italic', i, weekday, offsetOfToday)

			// Let's see if next day is still in the same month or not.
			if (plasmoid.configuration.useFakeParameters) {
				lastDayMonth[i] = theme['lastDayMonth']['enabled'] ? (weekday === plasmoid.configuration.fakeLastDayMonth) : false
			} else {
				var todayMonth = today.getMonth()
				today.setDate(today.getDate() + 1)
				var nextDayMonth = today.getMonth()
				lastDayMonth[i] = theme['lastDayMonth']['enabled'] ? (todayMonth !== nextDayMonth) : false
			}
		}

		// FIXME: this is lame, but I couldn't make QML notice value changes within
		// JS objects (dicts). Copying values out to separate properties seem to work.
		widgetBg = theme['widget']['bg']

		var LastDayMonthBg = theme['lastDayMonth']['bg']

		var i=0
		day0Label = labels[i]
		day0Fg = fgs[i]
		day0Bg = bgs[i]
		day0Bold = bolds[i]
		day0Italic = italics[i]
		day0LastDayMonth = lastDayMonth[i]
		day0LastDayMonthBg = LastDayMonthBg
		day0UseFont = plasmoid.configuration.useCustomFont
		day0Font = plasmoid.configuration.customFont

		i++
		day1Label = labels[i]
		day1Fg = fgs[i]
		day1Bg = bgs[i]
		day1Bold = bolds[i]
		day1Italic = italics[i]
		day1LastDayMonth = lastDayMonth[i]
		day1LastDayMonthBg = LastDayMonthBg
		day1UseFont = plasmoid.configuration.useCustomFont
		day1Font = plasmoid.configuration.customFont

		i++
		day2Label = labels[i]
		day2Fg = fgs[i]
		day2Bg = bgs[i]
		day2Bold = bolds[i]
		day2Italic = italics[i]
		day2LastDayMonth = lastDayMonth[i]
		day2LastDayMonthBg = LastDayMonthBg
		day2UseFont = plasmoid.configuration.useCustomFont
		day2Font = plasmoid.configuration.customFont

		i++
		day3Label = labels[i]
		day3Fg = fgs[i]
		day3Bg = bgs[i]
		day3Bold = bolds[i]
		day3Italic = italics[i]
		day3LastDayMonth = lastDayMonth[i]
		day3LastDayMonthBg = LastDayMonthBg
		day3UseFont = plasmoid.configuration.useCustomFont
		day3Font = plasmoid.configuration.customFont

		i++
		day4Label = labels[i]
		day4Fg = fgs[i]
		day4Bg = bgs[i]
		day4Bold = bolds[i]
		day4Italic = italics[i]
		day4LastDayMonth = lastDayMonth[i]
		day4LastDayMonthBg = LastDayMonthBg
		day4UseFont = plasmoid.configuration.useCustomFont
		day4Font = plasmoid.configuration.customFont

		i++
		day5Label = labels[i]
		day5Fg = fgs[i]
		day5Bg = bgs[i]
		day5Bold = bolds[i]
		day5Italic = italics[i]
		day5LastDayMonth = lastDayMonth[i]
		day5LastDayMonthBg = LastDayMonthBg
		day5UseFont = plasmoid.configuration.useCustomFont
		day5Font = plasmoid.configuration.customFont

		i++
		day6Label = labels[i]
		day6Fg = fgs[i]
		day6Bg = bgs[i]
		day6Bold = bolds[i]
		day6Italic = italics[i]
		day6LastDayMonth = lastDayMonth[i]
		day6LastDayMonthBg = LastDayMonthBg
		day6UseFont = plasmoid.configuration.useCustomFont
		day6Font = plasmoid.configuration.customFont
	}

	// ------------------------------------------------------------------------------------------------------------------------

	readonly property string defaultLabel: '?'
	readonly property string defaultFg: '#FF888888'
	readonly property string defaultBg: '#00000000'
	readonly property bool defaultBold: false
	readonly property bool defaultItalic: false
	readonly property bool defaultLastMonthDay: false
	readonly property string defaultLastMonthDayBg: "#00000000"
	readonly property bool defaultUseFont: false
	readonly property font defaultFont: undefined

	property string widgetBg: defaultBg

	property string day0Label: defaultLabel
	property string day0Fg: defaultFg
	property string day0Bg: defaultBg
	property bool day0Bold: defaultBold
	property bool day0Italic: defaultItalic
	property bool day0LastDayMonth: defaultLastMonthDay
	property string day0LastDayMonthBg: defaultLastMonthDayBg
	property bool day0UseFont: defaultUseFont
	property font day0Font: defaultFont

	property string day1Label: defaultLabel
	property string day1Fg: defaultFg
	property string day1Bg: defaultBg
	property bool day1Bold: defaultBold
	property bool day1Italic: defaultItalic
	property bool day1LastDayMonth: defaultLastMonthDay
	property string day1LastDayMonthBg: defaultLastMonthDayBg
	property bool day1UseFont: defaultUseFont
	property font day1Font: defaultFont

	property string day2Label: defaultLabel
	property string day2Fg: defaultFg
	property string day2Bg: defaultBg
	property bool day2Bold: defaultBold
	property bool day2Italic: defaultItalic
	property bool day2LastDayMonth: defaultLastMonthDay
	property string day2LastDayMonthBg: defaultLastMonthDayBg
	property bool day2UseFont: defaultUseFont
	property font day2Font: defaultFont

	property string day3Label: defaultLabel
	property string day3Fg: defaultFg
	property string day3Bg: defaultBg
	property bool day3Bold: defaultBold
	property bool day3Italic: defaultItalic
	property bool day3LastDayMonth: defaultLastMonthDay
	property string day3LastDayMonthBg: defaultLastMonthDayBg
	property bool day3UseFont: defaultUseFont
	property font day3Font: defaultFont

	property string day4Label: defaultLabel
	property string day4Fg: defaultFg
	property string day4Bg: defaultBg
	property bool day4Bold: defaultBold
	property bool day4Italic: defaultItalic
	property bool day4LastDayMonth: defaultLastMonthDay
	property string day4LastDayMonthBg: defaultLastMonthDayBg
	property bool day4UseFont: defaultUseFont
	property font day4Font: defaultFont

	property string day5Label: defaultLabel
	property string day5Fg: defaultFg
	property string day5Bg: defaultBg
	property bool day5Bold: defaultBold
	property bool day5Italic: defaultItalic
	property bool day5LastDayMonth: defaultLastMonthDay
	property string day5LastDayMonthBg: defaultLastMonthDayBg
	property bool day5UseFont: defaultUseFont
	property font day5Font: defaultFont

	property string day6Label: defaultLabel
	property string day6Fg: defaultFg
	property string day6Bg: defaultBg
	property bool day6Bold: defaultBold
	property bool day6Italic: defaultItalic
	property bool day6LastDayMonth: defaultLastMonthDay
	property string day6LastDayMonthBg: defaultLastMonthDayBg
	property bool day6UseFont: defaultUseFont
	property font day6Font: defaultFont

	// ------------------------------------------------------------------------------------------------------------------------

	PlasmaCore.DataSource {
		id: timeDataSource
		engine: "time"
		connectedSources: ["Local"]
		interval: 60 * 60 * 1000	// 1hour
		intervalAlignment: PlasmaCore.Types.AlignToHour
		onNewData: updateWeekGrid()
	}

	// ------------------------------------------------------------------------------------------------------------------------

	// Update the week grid on each change of user settings. This is to keep data source hour aligned but still react
	// in real time to important user settings changes.
	SettingsMonitor {
		onChanged: updateWeekGrid()
	}

	// ------------------------------------------------------------------------------------------------------------------------

	// Arguments:
	//          theme: theme to get values from.
	//            key: attribute key to get (i.e. 'bg', 'bold').
	//          index: index of day (grid cell) being processed, relative to first day of the week
	//                 as shown in grid (i.e. 0 means first cell of the grid, 6, the last one).
	//        weekday: real day index with 0 being Sunday, 1 Monday, ... 6 Saturday.
	//  offsetOfToday: today's offset from begin of grid (i.e. 3 means cell 4th indicates day
	//                 we want to mark as "today").
	function getVal(theme, key, index, weekday, offsetOfToday) {
		var result = ''
		if (index === offsetOfToday) {
			result = theme['today'][key]
			switch(weekday) {
				case 0: result = getField(theme, 'todaySunday', key, result); break
				case 6: result = getField(theme, 'todaySaturday', key, result); break
			}
		} else if (index < offsetOfToday) {
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

	function getField(theme, dayKey, key, fallback) {
		return dayKey in theme && theme[dayKey]['enabled'] ? theme[dayKey][key] : fallback
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
		readonly property int monthEndWidth: 8

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
			lastDay: day0LastDayMonth
			lastDayBg: day0LastDayMonthBg
			useCustomFont: day0UseFont
			typeface: day0Font
		}
		Day {
			label: day1Label
			fg: day1Fg
			bg: day1Bg
			bold: day1Bold
			italic: day1Italic
			lastDay: day1LastDayMonth
			lastDayBg: day1LastDayMonthBg
			useCustomFont: day1UseFont
			typeface: day1Font
		}
		Day {
			label: day2Label
			fg: day2Fg
			bg: day2Bg
			bold: day2Bold
			italic: day2Italic
			lastDay: day2LastDayMonth
			lastDayBg: day2LastDayMonthBg
			useCustomFont: day2UseFont
			typeface: day2Font
		}
		Day {
			label: day3Label
			fg: day3Fg
			bg: day3Bg
			bold: day3Bold
			italic: day3Italic
			lastDay: day3LastDayMonth
			lastDayBg: day3LastDayMonthBg
			useCustomFont: day3UseFont
			typeface: day3Font
		}
		Day {
			label: day4Label
			fg: day4Fg
			bg: day4Bg
			bold: day4Bold
			italic: day4Italic
			lastDay: day4LastDayMonth
			lastDayBg: day4LastDayMonthBg
			useCustomFont: day4UseFont
			typeface: day4Font
		}
		Day {
			label: day5Label
			fg: day5Fg
			bg: day5Bg
			bold: day5Bold
			italic: day5Italic
			lastDay: day5LastDayMonth
			lastDayBg: day5LastDayMonthBg
			useCustomFont: day5UseFont
			typeface: day5Font
		}
		Day {
			label: day6Label
			fg: day6Fg
			bg: day6Bg
			bold: day6Bold
			italic: day6Italic
			lastDay: day6LastDayMonth
			lastDayBg: day6LastDayMonthBg
			useCustomFont: day6UseFont
			typeface: day6Font
		}
	} // weekGrid
} // ColumnLayout
