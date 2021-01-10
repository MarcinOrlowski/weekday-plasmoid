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

	property alias cfg_widgetBg: widgetConfig.bg

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

	property bool customColorsEnabled: plasmoid.configuration.themeName === Themes.custom

	Kirigami.InlineMessage {
		id: messageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Warning
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
			text: i18n('Clone as custom colors')
			enabled: !customColorsEnabled

			onClicked: {
				var theme = Themes.themes[plasmoid.configuration.themeName]

				widgetConfig.populateIf(theme, 'widget')

				todayConfig.populateIf(theme, 'today', theme['today'])
				todaySaturdayConfig.populateIf(theme, 'todaySaturday', theme['today'])
				todaySundayConfig.populateIf(theme, 'todaySunday', theme['today'])

				pastConfig.populateIf(theme, 'past')
				pastSaturdayConfig.populateIf(theme, 'pastSaturday', theme['past'])
				pastSundayConfig.populateIf(theme, 'pastSunday', theme['past'])

				futureConfig.populateIf(theme, 'future')
				futureSaturdayConfig.populateIf(theme, 'futureSaturday', theme['future'])
				futureSundayConfig.populateIf(theme, 'futureSunday', theme['future'])

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
		columns: 9
		enabled: customColorsEnabled

		property var clipboard: undefined

		// Grid header
		LabelCenter { Layout.columnSpan: 2 }
		LabelCenter { text: i18n('Text') }
		LabelCenter {}
		LabelCenter { text: i18n('Bg') }
		LabelCenter { text: i18n('Bold') }
		LabelCenter { text: i18n('Italic') }
		LabelCenter {}
		LabelCenter {}

		// widget background
		LabelRight { text: i18n('Widget') }
		AttributeConfig {
			id: widgetConfig
			alwaysEnabled: true
			fgEnabled: false
			boldEnabled: false
			italicEnabled: false
		}

    	// ------------------------------------------------------------------------------------------------------------------------

		// Today
		LabelRight { text: i18n('Today') } 
		AttributeConfig { id: todayConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Today Saturday') }
		AttributeConfig { id: todaySaturdayConfig }
		LabelRight { text: i18n('Today Sunday') }
		AttributeConfig { id: todaySundayConfig }

		LabelRight { text: i18n('Past Days') } 
		AttributeConfig { id: pastConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Past Saturday') }
		AttributeConfig { id: pastSaturdayConfig }
		LabelRight { text: i18n('Past Sunday') }
		AttributeConfig { id: pastSundayConfig }

		LabelRight { text: i18n('Future') } 
		AttributeConfig { id: futureConfig; alwaysEnabled: true }
		LabelRight { text: i18n('Future Saturday') }
		AttributeConfig { id: futureSaturdayConfig }
		LabelRight { text: i18n('Future Sunday') }
		AttributeConfig { id: futureSundayConfig }
	} // customColors (GridLayout)

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

} // ColumnLayout

