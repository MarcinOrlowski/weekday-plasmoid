/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
//import QtQuick.Controls 2.3
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQControls
import "../js/themes.js" as Themes

ColumnLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true

	property alias cfg_customColorsWidgetBg: customColorsWidgetBg.color

	property alias cfg_customColorsTodayFg: customColorsTodayFg.color
	property alias cfg_customColorsTodayBg: customColorsTodayBg.color
	property alias cfg_customColorsTodayBold: customColorsTodayBold.checked
	property alias cfg_customColorsTodayItalic: customColorsTodayItalic.checked

	property alias cfg_customColorsTodaySaturdayEnabled: customColorsTodaySaturdayEnabled.checked
	property alias cfg_customColorsTodaySaturdayFg: customColorsTodaySaturdayFg.color
	property alias cfg_customColorsTodaySaturdayBg: customColorsTodaySaturdayBg.color
	property alias cfg_customColorsTodaySaturdayBold: customColorsTodaySaturdayBold.checked
	property alias cfg_customColorsTodaySaturdayItalic: customColorsTodaySaturdayItalic.checked

	property alias cfg_customColorsTodaySundayEnabled: customColorsTodaySundayEnabled.checked
	property alias cfg_customColorsTodaySundayFg: customColorsTodaySundayFg.color
	property alias cfg_customColorsTodaySundayBg: customColorsTodaySundayBg.color
	property alias cfg_customColorsTodaySundayBold: customColorsTodaySundayBold.checked
	property alias cfg_customColorsTodaySundayItalic: customColorsTodaySundayItalic.checked

	property alias cfg_customColorsPastDayFg: customColorsPastDayFg.color
	property alias cfg_customColorsPastDayBg: customColorsPastDayBg.color
	property alias cfg_customColorsPastDayBold: customColorsPastDayBold.checked
	property alias cfg_customColorsPastDayItalic: customColorsPastDayItalic.checked

	property alias cfg_customColorsPastSaturdayEnabled: customColorsPastSaturdayEnabled.checked
	property alias cfg_customColorsPastSaturdayFg: customColorsPastSaturdayFg.color
	property alias cfg_customColorsPastSaturdayBg: customColorsPastSaturdayBg.color
	property alias cfg_customColorsPastSaturdayBold: customColorsPastSaturdayBold.checked
	property alias cfg_customColorsPastSaturdayItalic: customColorsPastSaturdayItalic.checked

	property alias cfg_customColorsPastSundayEnabled: customColorsPastSundayEnabled.checked
	property alias cfg_customColorsPastSundayFg: customColorsPastSundayFg.color
	property alias cfg_customColorsPastSundayBg: customColorsPastSundayBg.color
	property alias cfg_customColorsPastSundayBold: customColorsPastSundayBold.checked
	property alias cfg_customColorsPastSundayItalic: customColorsPastSundayItalic.checked

	property alias cfg_customColorsFutureDayFg: customColorsFutureDayFg.color
	property alias cfg_customColorsFutureDayBg: customColorsFutureDayBg.color
	property alias cfg_customColorsFutureDayBold: customColorsFutureDayBold.checked
	property alias cfg_customColorsFutureDayItalic: customColorsFutureDayItalic.checked

	property alias cfg_customColorsFutureSaturdayEnabled: customColorsFutureSaturdayEnabled.checked
	property alias cfg_customColorsFutureSaturdayFg: customColorsFutureSaturdayFg.color
	property alias cfg_customColorsFutureSaturdayBg: customColorsFutureSaturdayBg.color
	property alias cfg_customColorsFutureSaturdayBold: customColorsFutureSaturdayBold.checked
	property alias cfg_customColorsFutureSaturdayItalic: customColorsFutureSaturdayItalic.checked

	property alias cfg_customColorsFutureSundayEnabled: customColorsFutureSundayEnabled.checked
	property alias cfg_customColorsFutureSundayFg: customColorsFutureSundayFg.color
	property alias cfg_customColorsFutureSundayBg: customColorsFutureSundayBg.color
	property alias cfg_customColorsFutureSundayBold: customColorsFutureSundayBold.checked
	property alias cfg_customColorsFutureSundayItalic: customColorsFutureSundayItalic.checked

	readonly property bool customColorsEnabled: plasmoid.configuration.themeName == Themes.custom

	Kirigami.InlineMessage {
		id: messageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Notice
		text: i18n('Custom colors must be enabled for this feature to work.')
		showCloseButton: true
		visible: false
	}

	RowLayout {
		id: themeSelector
		Layout.fillWidth: true

		ConfigComboBox {
			id: themeName
			before: i18n('Theme')
			configKey: 'themeName'
			model: [
				{ value: Themes.defaultTheme, text: i18n('Default') },

				{ value: 'amber', text: i18n('Amber') },
				{ value: 'accented-bw-dark', text: i18n('Accented B&W') },
				{ value: 'bw-dark', text: i18n('B&W') },
				{ value: 'forest', text: i18n('Forest') },
				{ value: 'sea-blue', text: i18n('Sea Blue') },
				{ value: 'violet', text: i18n('Violet') },

				{ value: Themes.custom, text: i18n('Custom colors') }
			]
		}

		Button {
			function getVal(theme, dayKey, key, fallback) {
				return dayKey in theme && theme[dayKey]['enabled'] ? theme[dayKey][key] : fallback
			}

			text: i18n('Clone as custom colors')
			enabled: plasmoid.configuration.themeName !== Themes.custom
			onClicked: {
				var theme = Themes.themes[plasmoid.configuration.themeName]

				cfg_customColorsWidgetBg = theme['widget']['bg']

				cfg_customColorsTodayFg = theme['today']['fg']
				cfg_customColorsTodayBg = theme['today']['bg']
				cfg_customColorsTodayBold = theme['today']['bold']
				cfg_customColorsTodayItalic = theme['today']['italic']

				cfg_customColorsTodaySaturdayEnabled = getVal(theme, 'todaySaturday', 'enabled', false)
				cfg_customColorsTodaySaturdayFg = getVal(theme, 'todaySaturday', 'fg', cfg_customColorsTodayFg)
				cfg_customColorsTodaySaturdayBg = getVal(theme, 'todaySaturday', 'bg', cfg_customColorsTodayBg)
				cfg_customColorsTodaySaturdayBold = getVal(theme, 'todaySaturday', 'bold', cfg_customColorsTodayBold)
				cfg_customColorsTodaySaturdayItalic = getVal(theme, 'todaySaturday', 'italic', cfg_customColorsTodayItalic)

				cfg_customColorsTodaySundayEnabled = getVal(theme, 'todaySunday', 'enabled', false)
				cfg_customColorsTodaySundayFg = getVal(theme, 'todaySunday', 'fg', cfg_customColorsTodayFg)
				cfg_customColorsTodaySundayBg = getVal(theme, 'todaySunday', 'bg', cfg_customColorsTodayBg)
				cfg_customColorsTodaySundayBold = getVal(theme, 'todaySunday', 'bold', cfg_customColorsTodayBold)
				cfg_customColorsTodaySundayItalic = getVal(theme, 'todaySunday', 'italic', cfg_customColorsTodayItalic)

				cfg_customColorsPastDayFg = theme['pastDay']['fg']
				cfg_customColorsPastDayBg = theme['pastDay']['bg']
				cfg_customColorsPastDayBold = theme['pastDay']['bold']
				cfg_customColorsPastDayItalic = theme['pastDay']['italic']

				cfg_customColorsPastSaturdayEnabled = getVal(theme, 'pastSaturday', 'enabled', false)
				cfg_customColorsPastSaturdayFg = getVal(theme, 'pastSaturday', 'fg', cfg_customColorsPastDayFg)
				cfg_customColorsPastSaturdayBg = getVal(theme, 'pastSaturday', 'bg', cfg_customColorsPastDayBg)
				cfg_customColorsPastSaturdayBold = getVal(theme, 'pastSaturday', 'bold', cfg_customColorsPastDayBold)
				cfg_customColorsPastSaturdayItalic = getVal(theme, 'pastSaturday', 'italic', cfg_customColorsPastDayItalic)

				cfg_customColorsPastSundayEnabled = getVal(theme, 'pastSunday', 'enabled', false)
				cfg_customColorsPastSundayFg = getVal(theme, 'pastSunday', 'fg', cfg_customColorsPastDayFg)
				cfg_customColorsPastSundayBg = getVal(theme, 'pastSunday', 'bg', cfg_customColorsPastDayBg)
				cfg_customColorsPastSundayBold = getVal(theme, 'pastSunday', 'bold', cfg_customColorsPastDayBold)
				cfg_customColorsPastSundayItalic = getVal(theme, 'pastSunday', 'italic', cfg_customColorsPastDayItalic)

				cfg_customColorsFutureDayFg = theme['futureDay']['fg']
				cfg_customColorsFutureDayBg = theme['futureDay']['bg']
				cfg_customColorsFutureDayBold = theme['futureDay']['bold']
				cfg_customColorsFutureDayItalic = theme['futureDay']['italic']

				cfg_customColorsFutureSaturdayEnabled = getVal(theme, 'futureSaturday', 'enabled', false)
				cfg_customColorsFutureSaturdayFg = getVal(theme, 'futureSaturday', 'fg', cfg_customColorsFutureDayFg)
				cfg_customColorsFutureSaturdayBg = getVal(theme, 'futureSaturday', 'bg', cfg_customColorsFutureDayBg)
				cfg_customColorsFutureSaturdayBold = getVal(theme, 'futureSaturday', 'bold', cfg_customColorsFutureDayBold)
				cfg_customColorsFutureSaturdayItalic = getVal(theme, 'futureSaturday', 'italic', cfg_customColorsFutureDayItalic)

				cfg_customColorsFutureSundayEnabled = getVal(theme, 'futureSunday', 'enabled', false)
				cfg_customColorsFutureSundayFg = getVal(theme, 'futureSunday', 'fg', cfg_customColorsFutureDayFg)
				cfg_customColorsFutureSundayBg = getVal(theme, 'futureSunday', 'bg', cfg_customColorsFutureDayBg)
				cfg_customColorsFutureSundayBold = getVal(theme, 'futureSunday', 'bold', cfg_customColorsFutureDayBold)
				cfg_customColorsFutureSundayItalic = getVal(theme, 'futureSunday', 'italic', cfg_customColorsFutureDayItalic)

				themeName.selectValue(Themes.custom)

				messageWidget.text = i18n('Custom colors populated from "%1" theme. Press "Apply" to see the change, otherwise old custom colors will be still used.', theme['theme']['name'])
				messageWidget.visible = true
			}
		}
	} // themeSelector

/*
	PlasmaComponents.ComboBox {
		id: themeName
	    textRole: "text"
	    property string _valueRole: "value"
	    readonly property string _currentValue: _valueRole && currentIndex >= 0 ? model[currentIndex][_valueRole] : Themes.defaultTheme

		model: [
			{ value: Themes.defaultTheme, text: i18n('Default') },
			{ value: 'amber', text: i18n('Amber') },
			{ value: 'forest', text: i18n('Forest') },
			{ value: 'yellow', text: i18n('Yellow') },
			{ value: Themes.custom, text: i18n('Custom colors') }
		]
	} // themeName
*/

	GridLayout {
		id: customColors
		columns: 7
		enabled: customColorsEnabled

		// Grid header
		LabelCenter { Layout.columnSpan: 2 }
		LabelCenter { text: i18n('Text') }
		LabelCenter { text: i18n('Bg') }
		LabelCenter { text: i18n('Bold') }
		LabelCenter { text: i18n('Italic') }
		LabelCenter {}

		// widget background
		LabelRight { text: i18n('Widget') }
		LabelCenter { Layout.columnSpan: 2}
		ConfigColorButtonBg {
			id: customColorsWidgetBg
		}
		LabelCenter { Layout.columnSpan: 3 }

    	// ------------------------------------------------------------------------------------------------------------------------

		// Today
		LabelRight {
			id: customColorsTodayLabel
			text: i18n('Today')
		}
		LabelCenter {}
		ConfigColorButtonFg {
			id: customColorsTodayFg
		}
		ConfigColorButtonBg {
			id: customColorsTodayBg
		}
		ConfigCheckBox {
			id: customColorsTodayBold
		}
		ConfigCheckBox {
			id: customColorsTodayItalic
		}
		LabelCenter {}

		// ------------------------------------------------------------------------------------------------------------------------

		// Today Saturday
		LabelRight {
			text: i18n('Today Saturday')
		}
		CheckBox {
			id: customColorsTodaySaturdayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsTodaySaturdayFg
			enabled: cfg_customColorsTodaySaturdayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsTodaySaturdayBg
			enabled: cfg_customColorsTodaySaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsTodaySaturdayBold
			enabled: cfg_customColorsTodaySaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsTodaySaturdayItalic
			enabled: cfg_customColorsTodaySaturdayEnabled
		}
		Button {
			text: i18n('Clone "%1"', customColorsTodayLabel.text )
			onClicked: {
				cfg_customColorsTodaySaturdayEnabled = true
				cfg_customColorsTodaySaturdayFg = cfg_customColorsTodayFg
				cfg_customColorsTodaySaturdayBg = cfg_customColorsTodayBg
				cfg_customColorsTodaySaturdayBold = cfg_customColorsTodayBold
				cfg_customColorsTodaySaturdayItalic = cfg_customColorsTodayItalic
			}
		}

		// ------------------------------------------------------------------------------------------------------------------------

		// past Today
		LabelRight {
			text: i18n('Today Sunday')
		}
		CheckBox {
			id: customColorsTodaySundayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsTodaySundayFg
			enabled: cfg_customColorsTodaySundayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsTodaySundayBg
			enabled: cfg_customColorsTodaySundayEnabled
		}
		ConfigCheckBox {
			id: customColorsTodaySundayBold
			enabled: cfg_customColorsTodaySundayEnabled
		}
		ConfigCheckBox {
			id: customColorsTodaySundayItalic
			enabled: cfg_customColorsTodaySundayEnabled
		}
		Button {
			text: i18n('Clone "%1"', customColorsTodayLabel.text )
			onClicked: {
				cfg_customColorsTodaySundayEnabled = true
				cfg_customColorsTodaySundayFg = cfg_customColorsTodayFg
				cfg_customColorsTodaySundayBg = cfg_customColorsTodayBg
				cfg_customColorsTodaySundayBold = cfg_customColorsTodayBold
				cfg_customColorsTodaySundayItalic = cfg_customColorsTodayItalic
			}
		}

    	// ------------------------------------------------------------------------------------------------------------------------

		// past days
		LabelRight {
			id: customColorsPastDayLabel
			text: i18n('Past days')
		}
		LabelCenter {}
		ConfigColorButtonFg {
			id: customColorsPastDayFg
		}
		ConfigColorButtonBg {
			id: customColorsPastDayBg
		}
		ConfigCheckBox {
			id: customColorsPastDayBold
		}
		ConfigCheckBox {
			id: customColorsPastDayItalic
		}
		LabelCenter {}

    	// ------------------------------------------------------------------------------------------------------------------------

		// past Saturday
		LabelRight {
			text: i18n('Past Saturday')
		}
		CheckBox {
			id: customColorsPastSaturdayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsPastSaturdayFg
			enabled: cfg_customColorsPastSaturdayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsPastSaturdayBg
			enabled: cfg_customColorsPastSaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsPastSaturdayBold
			enabled: cfg_customColorsPastSaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsPastSaturdayItalic
			enabled: cfg_customColorsPastSaturdayEnabled
		}
		Button {
			text: i18n('Clone "%1"', customColorsPastDayLabel.text )
			onClicked: {
				cfg_customColorsPastSaturdayEnabled = true
				cfg_customColorsPastSaturdayFg = cfg_customColorsPastDayFg
				cfg_customColorsPastSaturdayBg = cfg_customColorsPastDayBg
				cfg_customColorsPastSaturdayBold = cfg_customColorsPastDayBold
				cfg_customColorsPastSaturdayItalic = cfg_customColorsPastDayItalic
			}
		}

    	// ------------------------------------------------------------------------------------------------------------------------

		// past Sunday
		LabelRight {
			text: i18n('Past Sunday')
		}
		CheckBox {
			id: customColorsPastSundayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsPastSundayFg
			enabled: cfg_customColorsPastSundayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsPastSundayBg
			enabled: cfg_customColorsPastSundayEnabled
		}
		ConfigCheckBox {
			id: customColorsPastSundayBold
			enabled: cfg_customColorsPastSundayEnabled
		}
		ConfigCheckBox {
			id: customColorsPastSundayItalic
			enabled: cfg_customColorsPastSundayEnabled
		}
		Button {
			text: i18n('Clone "%1"', customColorsPastDayLabel.text )
			onClicked: {
				cfg_customColorsPastSundayEnabled = true
				cfg_customColorsPastSundayFg = cfg_customColorsPastDayFg
				cfg_customColorsPastSundayBg = cfg_customColorsPastDayBg
				cfg_customColorsPastSundayBold = cfg_customColorsPastDayBold
				cfg_customColorsPastSundayItalic = cfg_customColorsPastDayItalic
			}
		}

    	// ------------------------------------------------------------------------------------------------------------------------

		// future days
		LabelRight { id: futureDaysLabel; text: i18n('Future days') }
		LabelCenter {}  
		ConfigColorButtonFg {
			id: customColorsFutureDayFg
		}
		ConfigColorButtonBg {
			id: customColorsFutureDayBg
		}
		ConfigCheckBox {
			id: customColorsFutureDayBold
		}
		ConfigCheckBox {
			id: customColorsFutureDayItalic
		}
		LabelCenter {}

    	// ------------------------------------------------------------------------------------------------------------------------

		// future Saturday
		LabelRight { text: i18n('Future Saturday') }
		CheckBox {
			id: customColorsFutureSaturdayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsFutureSaturdayFg
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsFutureSaturdayBg
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsFutureSaturdayBold
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		ConfigCheckBox {
			id: customColorsFutureSaturdayItalic
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		Button {
			text: i18n('Clone "%1"', futureDaysLabel.text )
			onClicked: {
				cfg_customColorsFutureSaturdayEnabled = true
				cfg_customColorsFutureSaturdayFg = cfg_customColorsFutureDayFg
				cfg_customColorsFutureSaturdayBg = cfg_customColorsFutureDayBg
				cfg_customColorsFutureSaturdayBold = cfg_customColorsFutureDayBold
				cfg_customColorsFutureSaturdayItalic = cfg_customColorsFutureDayItalic
			}
		}

    	// ------------------------------------------------------------------------------------------------------------------------

		// future Sunday
		LabelRight { text: i18n('Future Sunday') }
		CheckBox {
			id: customColorsFutureSundayEnabled
		}
		ConfigColorButtonFg {
			id: customColorsFutureSundayFg
			enabled: cfg_customColorsFutureSundayEnabled
		}
		ConfigColorButtonBg {
			id: customColorsFutureSundayBg
			enabled: cfg_customColorsFutureSundayEnabled
		}
		ConfigCheckBox {
			id: customColorsFutureSundayBold
			enabled: cfg_customColorsFutureSundayEnabled
		}
		ConfigCheckBox {
			id: customColorsFutureSundayItalic
			enabled: cfg_customColorsFutureSundayEnabled
		}
		Button {
			text: i18n('Clone "%1"', futureDaysLabel.text )
			onClicked: {
				cfg_customColorsFutureSundayEnabled = true
				cfg_customColorsFutureSundayFg = cfg_customColorsFutureDayFg
				cfg_customColorsFutureSundayBg = cfg_customColorsFutureDayBg
				cfg_customColorsFutureSundayBold = cfg_customColorsFutureDayBold
				cfg_customColorsFutureSundayItalic = cfg_customColorsFutureDayItalic
			}
		}
	} // customColors (GridLayout)

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

} // ColumnLayout
