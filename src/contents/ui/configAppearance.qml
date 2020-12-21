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

	property alias cfg_customColorsTodayFg: todayConfig.fg
	property alias cfg_customColorsTodayBg: todayConfig.bg
	property alias cfg_customColorsTodayBold: todayConfig.bold
	property alias cfg_customColorsTodayItalic: todayConfig.italic

	property alias cfg_customColorsTodaySaturdayEnabled: todaySaturdayConfig.enabled
	property alias cfg_customColorsTodaySaturdayFg: todaySaturdayConfig.fg
	property alias cfg_customColorsTodaySaturdayBg: todaySaturdayConfig.bg
	property alias cfg_customColorsTodaySaturdayBold: todaySaturdayConfig.bold
	property alias cfg_customColorsTodaySaturdayItalic: todaySaturdayConfig.italic

	property alias cfg_customColorsTodaySundayEnabled: todaySundayConfig.enabled
	property alias cfg_customColorsTodaySundayFg: todaySundayConfig.fg
	property alias cfg_customColorsTodaySundayBg: todaySundayConfig.bg
	property alias cfg_customColorsTodaySundayBold: todaySundayConfig.bold
	property alias cfg_customColorsTodaySundayItalic: todaySundayConfig.italic

	property alias cfg_customColorsPastFg: todayConfig.fg
	property alias cfg_customColorsPastBg: todayConfig.bg
	property alias cfg_customColorsPastBold: todayConfig.bold
	property alias cfg_customColorsPastItalic: todayConfig.italic

	property alias cfg_customColorsPastSaturdayEnabled: todaySaturdayConfig.enabled
	property alias cfg_customColorsPastSaturdayFg: todaySaturdayConfig.fg
	property alias cfg_customColorsPastSaturdayBg: todaySaturdayConfig.bg
	property alias cfg_customColorsPastSaturdayBold: todaySaturdayConfig.bold
	property alias cfg_customColorsPastSaturdayItalic: todaySaturdayConfig.italic

	property alias cfg_customColorsPastSundayEnabled: todaySundayConfig.enabled
	property alias cfg_customColorsPastSundayFg: todaySundayConfig.fg
	property alias cfg_customColorsPastSundayBg: todaySundayConfig.bg
	property alias cfg_customColorsPastSundayBold: todaySundayConfig.bold
	property alias cfg_customColorsPastSundayItalic: todaySundayConfig.italic

	property alias cfg_customColorsFutureFg: todayConfig.fg
	property alias cfg_customColorsFutureBg: todayConfig.bg
	property alias cfg_customColorsFutureBold: todayConfig.bold
	property alias cfg_customColorsFutureItalic: todayConfig.italic

	property alias cfg_customColorsFutureSaturdayEnabled: todaySaturdayConfig.enabled
	property alias cfg_customColorsFutureSaturdayFg: todaySaturdayConfig.fg
	property alias cfg_customColorsFutureSaturdayBg: todaySaturdayConfig.bg
	property alias cfg_customColorsFutureSaturdayBold: todaySaturdayConfig.bold
	property alias cfg_customColorsFutureSaturdayItalic: todaySaturdayConfig.italic

	property alias cfg_customColorsFutureSundayEnabled: todaySundayConfig.enabled
	property alias cfg_customColorsFutureSundayFg: todaySundayConfig.fg
	property alias cfg_customColorsFutureSundayBg: todaySundayConfig.bg
	property alias cfg_customColorsFutureSundayBold: todaySundayConfig.bold
	property alias cfg_customColorsFutureSundayItalic: todaySundayConfig.italic

	readonly property bool customColorsEnabled: plasmoid.configuration.themeName == Themes.custom

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
			/*
			** Checks if dayKey (i.e. 'pastSaturday') exists in theme. If it does,
			** next checks if config node for dayKey's 'enabled' is 'true'.
			** If so, returns value of key element from dayKey node of the theme.
			** If node is not enabled, returns key value from parent node. This
			** allows easy handling of i.e. optional TodaySunday config, falling
			** back to Today if not enabled.
			*/
			function getValIfEnabled(theme, dayKey, key, parentNode) {
				return (dayKey in theme) && theme[dayKey]['enabled']
					? theme[dayKey][key]
					: parentNode[key]
			}

			function getNode(theme, key, parentNode) {
				if (parentNode === undefined) parentNode = theme[key]
				return (key in theme) 
					? {
						'enabled': ('enabled' in theme) ? theme['enabled'] : false,
						'fg': getValIfEnabled(theme, key, 'fg', parentNode),
						'bg': getValIfEnabled(theme, key, 'bg', parentNode),
						'bold': getValIfEnabled(theme, key, 'bold', parentNode),
						'italic': getValIfEnabled(theme, key, 'italic', parentNode)
					  }
					: parentNode
			}

			text: i18n('Clone as custom colors')
			enabled: plasmoid.configuration.themeName !== Themes.custom

			onClicked: {
				var theme = Themes.themes[plasmoid.configuration.themeName]

				cfg_customColorsWidgetBg = theme['widget']['bg']

				todayConfig.populate(getNode(theme, 'today', theme['today']))
				todaySaturdayConfig.populate(getNode(theme, 'todaySaturday', theme['today']))
				todaySundayConfig.populate(getNode(theme, 'todaySunday', theme['today']))

				pastConfig.populate(getNode(theme, 'pastDay'))
				pastSaturdayConfig.populate(getNode(theme, 'pastSaturday', theme['pastDay']))
				pastSundayConfig.populate(getNode(theme, 'pastSunday', theme['pastDay']))

				futureConfig.populate(getNode(theme, 'futureDay'))
				futureSaturdayConfig.populate(getNode(theme, 'futureSaturday', theme['futureDay']))
				futureSundayConfig.populate(getNode(theme, 'futureSunday', theme['futureDay']))

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
		LabelCenter { Layout.columnSpan: 3}
		ConfigColorButtonBg {
			id: customColorsWidgetBg
		}
		LabelCenter { Layout.columnSpan: 4 }

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

