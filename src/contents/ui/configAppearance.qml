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

Kirigami.FormLayout {
	Layout.fillWidth: true

//	property alias cfg_widgetThemeName: themeName.value

	property alias cfg_customColorsWidgetBg: customColorsWidgetBg.color

	property alias cfg_customColorsTodayFg: customColorsTodayFg.color
	property alias cfg_customColorsTodayBg: customColorsTodayBg.color
	property alias cfg_customColorsTodayBold: customColorsTodayBold.checked
	property alias cfg_customColorsTodayItalic: customColorsTodayItalic.checked

	property alias cfg_customColorsPastDayFg: customColorsPastDayFg.color
	property alias cfg_customColorsPastDayBg: customColorsPastDayBg.color
	property alias cfg_customColorsPastDayBold: customColorsPastDayBold.checked
	property alias cfg_customColorsPastDayItalic: customColorsPastDayItalic.checked

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
		}
*/

	GridLayout {
		id: customColors
		columns: 6
		enabled: customColorsEnabled

		// Grid header
		LabelCenter { Layout.columnSpan: 2 }
		LabelCenter { text: i18n('Text') }
		LabelCenter { text: i18n('Bg') }
		LabelCenter { text: i18n('Bold') }
		LabelCenter { text: i18n('Italic') }

		// widget background
		LabelRight { Layout.columnSpan: 2; text: i18n('Widget') }
		LabelCenter {}
		ColorButton {
			id: customColorsWidgetBg
			dialogTitle: i18n('Select background color')
		}
		LabelCenter {}
		LabelCenter {}

		// current day
		LabelRight { Layout.columnSpan: 2; text: i18n('Today') }
		ColorButton {
			id: customColorsTodayFg
			dialogTitle: i18n('Select text color')
		}
		ColorButton {
			id: customColorsTodayBg
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsTodayBold
			Layout.alignment: Qt.AlignHCenter
		}
		CheckBox {
			id: customColorsTodayItalic
			Layout.alignment: Qt.AlignHCenter
		}

		// past days
		LabelRight { Layout.columnSpan: 2; text: i18n('Past days') }
		ColorButton {
			id: customColorsPastDayFg
			dialogTitle: i18n('Select text color')
		}
		ColorButton {
			id: customColorsPastDayBg
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsPastDayBold
			Layout.alignment: Qt.AlignHCenter
		}
		CheckBox {
			id: customColorsPastDayItalic
			Layout.alignment: Qt.AlignHCenter
		}

		// future days
		LabelRight { Layout.columnSpan: 2; text: i18n('Future days') }
		ColorButton {
			id: customColorsFutureDayFg
			dialogTitle: i18n('Select text color')
		}
		ColorButton {
			id: customColorsFutureDayBg
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsFutureDayBold
			Layout.alignment: Qt.AlignHCenter
		}
		CheckBox {
			id: customColorsFutureDayItalic
			Layout.alignment: Qt.AlignHCenter
		}

		// future Saturday
		LabelRight { text: i18n('Future Saturday') }
		CheckBox {
			id: customColorsFutureSaturdayEnabled
		}
		ColorButton {
			id: customColorsFutureSaturdayFg
			dialogTitle: i18n('Select text color')
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		ColorButton {
			id: customColorsFutureSaturdayBg
			dialogTitle: i18n('Select background color')
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		CheckBox {
			id: customColorsFutureSaturdayBold
			Layout.alignment: Qt.AlignHCenter
			enabled: cfg_customColorsFutureSaturdayEnabled
		}
		CheckBox {
			id: customColorsFutureSaturdayItalic
			Layout.alignment: Qt.AlignHCenter
			enabled: cfg_customColorsFutureSaturdayEnabled
		}


		// future Sunday
		LabelRight { text: i18n('Future Sunday') }
		CheckBox {
			id: customColorsFutureSundayEnabled
		}
		ColorButton {
			id: customColorsFutureSundayFg
			dialogTitle: i18n('Select text color')
			enabled: cfg_customColorsFutureSundayEnabled
		}
		ColorButton {
			id: customColorsFutureSundayBg
			dialogTitle: i18n('Select background color')
			enabled: cfg_customColorsFutureSundayEnabled
		}
		CheckBox {
			id: customColorsFutureSundayBold
			Layout.alignment: Qt.AlignHCenter
			enabled: cfg_customColorsFutureSundayEnabled
		}
		CheckBox {
			id: customColorsFutureSundayItalic
			Layout.alignment: Qt.AlignHCenter
			enabled: cfg_customColorsFutureSundayEnabled
		}

	} // customColors
	
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
