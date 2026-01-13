/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2024 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.kirigami as Kirigami
import "../js/themes.js" as Themes
import "../js/DateTimeFormatter.js" as DTF

Item {
	id: weekRoot

	// we always count from 0 being sunday unless user set different day to be first day of the week
	property int firstDayOfWeek: 0

	// Signal for toggling expanded state (Plasma 6 pattern)
	signal toggleExpanded()

	// Layout sizing - respond to panel form factor
	readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
	readonly property bool isHorizontal: Plasmoid.formFactor === PlasmaCore.Types.Horizontal
	readonly property bool inPanel: isVertical || isHorizontal

	// Use Kirigami grid unit for consistent sizing
	readonly property int minCellHeight: Kirigami.Units.gridUnit

	implicitWidth: weekGrid.implicitWidth
	implicitHeight: Math.max(weekGrid.implicitHeight, minCellHeight)

	// Explicit Layout constraints - don't let panel expand us beyond content size
	Layout.minimumWidth: weekGrid.implicitWidth
	Layout.minimumHeight: Math.max(weekGrid.implicitHeight, minCellHeight)
	Layout.preferredWidth: weekGrid.implicitWidth
	Layout.preferredHeight: Math.max(weekGrid.implicitHeight, minCellHeight)
	Layout.maximumWidth: isVertical ? -1 : weekGrid.implicitWidth
	Layout.maximumHeight: isHorizontal ? -1 : Math.max(weekGrid.implicitHeight, minCellHeight)
	Layout.fillWidth: isVertical
	Layout.fillHeight: isHorizontal

	// ------------------------------------------------------------------------------------------------------------------------

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		onClicked: {
			if (Plasmoid.configuration.calendarViewEnabled) {
				weekRoot.toggleExpanded()
			}
		}
	}

	// ------------------------------------------------------------------------------------------------------------------------

	function getUserTheme() {
		return {
			"theme": {"name": "UserTheme1"},
			"widget": {
				"bg": Plasmoid.configuration.widgetBg
			},

			"lastDayMonth": {
				"enabled": Plasmoid.configuration.lastDayMonthEnabled,
				"bg": Plasmoid.configuration.lastDayMonthBg
			},

			"past": {
				"fg": Plasmoid.configuration.pastFg,
				"bg": Plasmoid.configuration.pastBg,
				"bold": Plasmoid.configuration.pastBold,
				"italic": Plasmoid.configuration.pastItalic
			},
			"pastSaturday": {
				"enabled": Plasmoid.configuration.pastSaturdayEnabled,
				"fg": Plasmoid.configuration.pastSaturdayFg,
				"bg": Plasmoid.configuration.pastSaturdayBg,
				"bold": Plasmoid.configuration.pastSaturdayBold,
				"italic": Plasmoid.configuration.pastSaturdayItalic
			},
			"pastSunday": {
				"enabled": Plasmoid.configuration.pastSundayEnabled,
				"fg": Plasmoid.configuration.pastSundayFg,
				"bg": Plasmoid.configuration.pastSundayBg,
				"bold": Plasmoid.configuration.pastSundayBold,
				"italic": Plasmoid.configuration.pastSundayItalic
			},

			"today": {
				"fg": Plasmoid.configuration.todayFg,
				"bg": Plasmoid.configuration.todayBg,
				"bold": Plasmoid.configuration.todayBold,
				"italic": Plasmoid.configuration.todayItalic
			},
			"todaySaturday": {
				"enabled": Plasmoid.configuration.todaySaturdayEnabled,
				"fg": Plasmoid.configuration.todaySaturdayFg,
				"bg": Plasmoid.configuration.todaySaturdayBg,
				"bold": Plasmoid.configuration.todaySaturdayBold,
				"italic": Plasmoid.configuration.todaySaturdayItalic
			},
			"todaySunday": {
				"enabled": Plasmoid.configuration.todaySundayEnabled,
				"fg": Plasmoid.configuration.todaySundayFg,
				"bg": Plasmoid.configuration.todaySundayBg,
				"bold": Plasmoid.configuration.todaySundayBold,
				"italic": Plasmoid.configuration.todaySundayItalic
			},

			"future": {
				"fg": Plasmoid.configuration.futureFg,
				"bg": Plasmoid.configuration.futureBg,
				"bold": Plasmoid.configuration.futureBold,
				"italic": Plasmoid.configuration.futureItalic
			},
			"futureSaturday": {
				"enabled": Plasmoid.configuration.futureSaturdayEnabled,
				"fg": Plasmoid.configuration.futureSaturdayFg,
				"bg": Plasmoid.configuration.futureSaturdayBg,
				"bold": Plasmoid.configuration.futureSaturdayBold,
				"italic": Plasmoid.configuration.futureSaturdayItalic
			},
			"futureSunday": {
				"enabled": Plasmoid.configuration.futureSundayEnabled,
				"fg": Plasmoid.configuration.futureSundayFg,
				"bg": Plasmoid.configuration.futureSundayBg,
				"bold": Plasmoid.configuration.futureSundayBold,
				"italic": Plasmoid.configuration.futureSundayItalic
			}
		}
	}

	// ------------------------------------------------------------------------------------------------------------------------

	function updateWeekGrid() {
		// https://doc.qt.io/qt-6/qml-qtqml-locale.html
		// Offset indicates first day of week with Sunday equals 0
		// and Saturday equals 6
		var localeToUse = Plasmoid.configuration.useSpecificLocaleEnabled
				? Plasmoid.configuration.useSpecificLocaleLocaleName
				: ''

		var locale = Qt.locale(localeToUse)
		firstDayOfWeek = locale.firstDayOfWeek

		if (Plasmoid.configuration.useFakeParameters) {
			firstDayOfWeek = Plasmoid.configuration.fakeWeekStartDay
		} else if (Plasmoid.configuration.nonDefaultWeekStartDayEnabled) {
			firstDayOfWeek = Plasmoid.configuration.nonDefaultWeekStartDayDayIndex
		}

		var themeKey = Plasmoid.configuration.themeName
		if (themeKey === Themes.defaultTheme) {
			themeKey = Themes.defaultThemeKey
		}
		var currentTheme = Plasmoid.configuration.useUserTheme
								? getUserTheme()
								: Themes.themes[themeKey]

		redrawWidget(locale, firstDayOfWeek, currentTheme)
	}

	// dayIdx starts from 0 being Sunday, 6 being Saturday
	function getDayLabel(dayIdx, fallback) {
		var label = fallback
		if (Plasmoid.configuration.customDayLabelsEnabled) {
			if (dayIdx === 0 && Plasmoid.configuration.customDayLabelSundayEnabled) {
				label = Plasmoid.configuration.customDayLabelSundayLabel.substr(0, 1)
			}
			if (dayIdx === 1 && Plasmoid.configuration.customDayLabelMondayEnabled) {
				label = Plasmoid.configuration.customDayLabelMondayLabel.substr(0, 1)
			}
			if (dayIdx === 2 && Plasmoid.configuration.customDayLabelTuesdayEnabled) {
				label = Plasmoid.configuration.customDayLabelTuesdayLabel.substr(0, 1)
			}
			if (dayIdx === 3 && Plasmoid.configuration.customDayLabelWednesdayEnabled) {
				label = Plasmoid.configuration.customDayLabelWednesdayLabel.substr(0, 1)
			}
			if (dayIdx === 4 && Plasmoid.configuration.customDayLabelThursdayEnabled) {
				label = Plasmoid.configuration.customDayLabelThursdayLabel.substr(0, 1)
			}
			if (dayIdx === 5 && Plasmoid.configuration.customDayLabelFridayEnabled) {
				label = Plasmoid.configuration.customDayLabelFridayLabel.substr(0, 1)
			}
			if (dayIdx === 6 && Plasmoid.configuration.customDayLabelSaturdayEnabled) {
				label = Plasmoid.configuration.customDayLabelSaturdayLabel.substr(0, 1)
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
		var today = Plasmoid.configuration.useFakeParameters ? Plasmoid.configuration.fakeToday : now.getDay()
		var offsetOfToday = today - firstDayOfWeek
		if (offsetOfToday < 0) offsetOfToday += 7

		// Let's shift our date objects to first day of the week (matching our settings)
		// We cannot use offsetOfToday as it is always positive (wrapped) value, which is
		// not what we need here.
		var todayDate = new Date()
		todayDate.setDate(todayDate.getDate() - todayDate.getDay() + firstDayOfWeek)
		for(var i=0; i<7; i++) {
			var weekday = (i+firstDayOfWeek) % 7
			fgs[i] = getVal(theme, 'fg', i, weekday, offsetOfToday)
			bgs[i] = getVal(theme, 'bg', i, weekday, offsetOfToday)
			bolds[i] = getVal(theme, 'bold', i, weekday, offsetOfToday)
			italics[i] = getVal(theme, 'italic', i, weekday, offsetOfToday)

			// Let's see if next day is still in the same month or not.
			if (Plasmoid.configuration.useFakeParameters) {
				lastDayMonth[i] = theme['lastDayMonth']['enabled'] ? (weekday === Plasmoid.configuration.fakeLastDayMonth) : false
			} else {
				var todayMonth = todayDate.getMonth()
				todayDate.setDate(todayDate.getDate() + 1)
				var nextDayMonth = todayDate.getMonth()
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
		day0UseFont = Plasmoid.configuration.useCustomFont
		day0Font = Plasmoid.configuration.customFont

		i++
		day1Label = labels[i]
		day1Fg = fgs[i]
		day1Bg = bgs[i]
		day1Bold = bolds[i]
		day1Italic = italics[i]
		day1LastDayMonth = lastDayMonth[i]
		day1LastDayMonthBg = LastDayMonthBg
		day1UseFont = Plasmoid.configuration.useCustomFont
		day1Font = Plasmoid.configuration.customFont

		i++
		day2Label = labels[i]
		day2Fg = fgs[i]
		day2Bg = bgs[i]
		day2Bold = bolds[i]
		day2Italic = italics[i]
		day2LastDayMonth = lastDayMonth[i]
		day2LastDayMonthBg = LastDayMonthBg
		day2UseFont = Plasmoid.configuration.useCustomFont
		day2Font = Plasmoid.configuration.customFont

		i++
		day3Label = labels[i]
		day3Fg = fgs[i]
		day3Bg = bgs[i]
		day3Bold = bolds[i]
		day3Italic = italics[i]
		day3LastDayMonth = lastDayMonth[i]
		day3LastDayMonthBg = LastDayMonthBg
		day3UseFont = Plasmoid.configuration.useCustomFont
		day3Font = Plasmoid.configuration.customFont

		i++
		day4Label = labels[i]
		day4Fg = fgs[i]
		day4Bg = bgs[i]
		day4Bold = bolds[i]
		day4Italic = italics[i]
		day4LastDayMonth = lastDayMonth[i]
		day4LastDayMonthBg = LastDayMonthBg
		day4UseFont = Plasmoid.configuration.useCustomFont
		day4Font = Plasmoid.configuration.customFont

		i++
		day5Label = labels[i]
		day5Fg = fgs[i]
		day5Bg = bgs[i]
		day5Bold = bolds[i]
		day5Italic = italics[i]
		day5LastDayMonth = lastDayMonth[i]
		day5LastDayMonthBg = LastDayMonthBg
		day5UseFont = Plasmoid.configuration.useCustomFont
		day5Font = Plasmoid.configuration.customFont

		i++
		day6Label = labels[i]
		day6Fg = fgs[i]
		day6Bg = bgs[i]
		day6Bold = bolds[i]
		day6Italic = italics[i]
		day6LastDayMonth = lastDayMonth[i]
		day6LastDayMonthBg = LastDayMonthBg
		day6UseFont = Plasmoid.configuration.useCustomFont
		day6Font = Plasmoid.configuration.customFont
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
	readonly property font defaultFont: Qt.application.font

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

	Plasma5Support.DataSource {
		id: timeDataSource
		engine: "time"
		connectedSources: ["Local"]
		interval: 60 * 60 * 1000	// 1hour
		intervalAlignment: Plasma5Support.Types.AlignToHour
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

	Rectangle {
		id: bgRect
		anchors.fill: parent
		color: widgetBg
		z: -1
	}

	GridLayout {
		id: weekGrid
		anchors.fill: parent
		columns: 7
		rows: 1
		columnSpacing: 0

		readonly property int cellMinWidth: 16
		readonly property int monthEndWidth: 8

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
} // Item weekRoot
