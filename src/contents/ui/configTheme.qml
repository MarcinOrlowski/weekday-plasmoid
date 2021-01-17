/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.components 3.0 as PlasmaComponents
import "../js/themes.js" as Themes

ColumnLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true

	property alias cfg_widgetBg: widgetConfig.bg

	property alias cfg_lastDayMonthEnabled: lastDayMonthConfig.configEnabled
	property alias cfg_lastDayMonthBg: lastDayMonthConfig.bg

	property alias cfg_pastFg: pastConfig.fg
	property alias cfg_pastBg: pastConfig.bg
	property alias cfg_pastBold: pastConfig.bold
	property alias cfg_pastItalic: pastConfig.italic

	property alias cfg_pastSaturdayEnabled: pastSaturdayConfig.configEnabled
	property alias cfg_pastSaturdayFg: pastSaturdayConfig.fg
	property alias cfg_pastSaturdayBg: pastSaturdayConfig.bg
	property alias cfg_pastSaturdayBold: pastSaturdayConfig.bold
	property alias cfg_pastSaturdayItalic: pastSaturdayConfig.italic

	property alias cfg_pastSundayEnabled: pastSundayConfig.configEnabled
	property alias cfg_pastSundayFg: pastSundayConfig.fg
	property alias cfg_pastSundayBg: pastSundayConfig.bg
	property alias cfg_pastSundayBold: pastSundayConfig.bold
	property alias cfg_pastSundayItalic: pastSundayConfig.italic

	property alias cfg_todayFg: todayConfig.fg
	property alias cfg_todayBg: todayConfig.bg
	property alias cfg_todayBold: todayConfig.bold
	property alias cfg_todayItalic: todayConfig.italic

	property alias cfg_todaySaturdayEnabled: todaySaturdayConfig.configEnabled
	property alias cfg_todaySaturdayFg: todaySaturdayConfig.fg
	property alias cfg_todaySaturdayBg: todaySaturdayConfig.bg
	property alias cfg_todaySaturdayBold: todaySaturdayConfig.bold
	property alias cfg_todaySaturdayItalic: todaySaturdayConfig.italic

	property alias cfg_todaySundayEnabled: todaySundayConfig.configEnabled
	property alias cfg_todaySundayFg: todaySundayConfig.fg
	property alias cfg_todaySundayBg: todaySundayConfig.bg
	property alias cfg_todaySundayBold: todaySundayConfig.bold
	property alias cfg_todaySundayItalic: todaySundayConfig.italic

	property alias cfg_futureFg: futureConfig.fg
	property alias cfg_futureBg: futureConfig.bg
	property alias cfg_futureBold: futureConfig.bold
	property alias cfg_futureItalic: futureConfig.italic

	property alias cfg_futureSaturdayEnabled: futureSaturdayConfig.configEnabled
	property alias cfg_futureSaturdayFg: futureSaturdayConfig.fg
	property alias cfg_futureSaturdayBg: futureSaturdayConfig.bg
	property alias cfg_futureSaturdayBold: futureSaturdayConfig.bold
	property alias cfg_futureSaturdayItalic: futureSaturdayConfig.italic

	property alias cfg_futureSundayEnabled: futureSundayConfig.configEnabled
	property alias cfg_futureSundayFg: futureSundayConfig.fg
	property alias cfg_futureSundayBg: futureSundayConfig.bg
	property alias cfg_futureSundayBold: futureSundayConfig.bold
	property alias cfg_futureSundayItalic: futureSundayConfig.italic

	property alias cfg_useFakeParameters: useFakeParameters.checked
//	property alias cfg_fakeToday: fakeToday.currentIndex
//	property alias cfg_fakeLastDayMonth: fakeLastDayMonth.currentIndex

	Kirigami.InlineMessage {
		id: infoMessageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Information
		text: i18n('You are currently using built-in theme. No changes in this pane will be reflected unless you enable "Use user theme" option in "Appearance" pane.')
		showCloseButton: true
		visible: !plasmoid.configuration.useUserTheme
	}

	property string themeKey: undefined

	RowLayout {
		Layout.fillWidth: true

		PlasmaComponents.ComboBox {
			textRole: "text"
			model: []
			Component.onCompleted: {
				// populate model from Theme object
				var tmp = []
				var idx = 0
				var currentIdx = undefined
				for(const key in Themes.themes) {
					var name = Themes.themes[key]['theme']['name']
					tmp.push({'value':key, 'text': name})
					if (key === plasmoid.configuration['themeName']) currentIdx = idx
					idx++
				}
				model = tmp

				currentIndex = currentIdx
			}
			onCurrentIndexChanged: themeKey = model[currentIndex]['value']
		}

		Button {
			text: i18n('Clone this theme')

			onClicked: {
				var theme = Themes.themes[themeKey]

				widgetConfig.populateIf(theme, 'widget')

				lastDayMonthConfig.populateIf(theme, 'lastDayMonth')

				todayConfig.populateIf(theme, 'today', theme['today'])
				todaySaturdayConfig.populateIf(theme, 'todaySaturday', theme['today'])
				todaySundayConfig.populateIf(theme, 'todaySunday', theme['today'])

				pastConfig.populateIf(theme, 'past')
				pastSaturdayConfig.populateIf(theme, 'pastSaturday', theme['past'])
				pastSundayConfig.populateIf(theme, 'pastSunday', theme['past'])

				futureConfig.populateIf(theme, 'future')
				futureSaturdayConfig.populateIf(theme, 'futureSaturday', theme['future'])
				futureSundayConfig.populateIf(theme, 'futureSunday', theme['future'])
			}
		}
	} // themeSelector

	PlasmaComponents.CheckBox {
		visible: false
		id: useUserTheme
		text: i18n("Use custom colors")
	}

	GridLayout {
		id: customColors
		columns: 9

		property var clipboard: undefined

		// widget background
		LabelRight { text: i18n('Widget') }
		AttributeConfig {
			id: widgetConfig
			alwaysEnabled: true
			fgEnabled: false
			boldEnabled: false
			italicEnabled: false
		}

		// last day of the month marker
		LabelRight { text: i18n('Month last day') }
		AttributeConfig {
			id: lastDayMonthConfig
			fgEnabled: false
			boldEnabled: false
			italicEnabled: false
		}

		// ------------------------------------------------------------------------------------------------------------------------

		LabelRight { text: i18n('Past Days') } 
		AttributeConfig { id: pastConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Past Saturday') }
		AttributeConfig { id: pastSaturdayConfig }
		LabelRight { text: i18n('Past Sunday') }
		AttributeConfig { id: pastSundayConfig }

		LabelRight { text: i18n('Today') } 
		AttributeConfig { id: todayConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Today Saturday') }
		AttributeConfig { id: todaySaturdayConfig }
		LabelRight { text: i18n('Today Sunday') }
		AttributeConfig { id: todaySundayConfig }

		LabelRight { text: i18n('Future') } 
		AttributeConfig { id: futureConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Future Saturday') }
		AttributeConfig { id: futureSaturdayConfig }
		LabelRight { text: i18n('Future Sunday') }
		AttributeConfig { id: futureSundayConfig }
	} // customColors (GridLayout)


	Item {
		height: 20
	}

	CheckBox {
		id: useFakeParameters
		text: i18n("Use fake parameters")
	}

	Kirigami.FormLayout {
		Layout.fillWidth: true
		anchors.left: parent.left
		anchors.right: parent.right

		enabled: cfg_useFakeParameters

		DaySelector {
			Kirigami.FormData.label: i18n("Fake Today")
			onChanged: {
				plasmoid.configuration['fakeToday'] = dayIndex
				plasmoid.configuration['useFakeParameters'] = true
			}
		}

		DaySelector {
			Kirigami.FormData.label: i18n("Fake month last day")
			onChanged: {
				plasmoid.configuration['fakeLastDayMonth'] = dayIndex
				plasmoid.configuration['useFakeParameters'] = true
			}
		}

		DaySelector {
			Kirigami.FormData.label: i18n("Fake week start day")
			onChanged: {
				plasmoid.configuration['fakeWeekStartDay'] = dayIndex
				plasmoid.configuration['useFakeParameters'] = true
			}
		}

	} // FormLayout


	Item {
		Layout.fillWidth: true
		Layout.fillHeight: true
	}

} // ColumnLayout

