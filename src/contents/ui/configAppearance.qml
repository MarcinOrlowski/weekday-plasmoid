/**
 * Weekday Widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQControls

Kirigami.FormLayout {
//    width: childrenRect.width
	Layout.fillWidth: true

	property alias cfg_customColorsEnabled: customColorsEnabled.checked

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

	CheckBox {
		id: customColorsEnabled
		text: i18n("Use custom colors")
	}

	GridLayout {
		columns: 5
		enabled: cfg_customColorsEnabled

		// Grid header
		LabelCenter {}
		LabelCenter { text: i18n('Text') }
		LabelCenter { text: i18n('Bg') }
		LabelCenter { text: i18n('Bold') }
		LabelCenter { text: i18n('Italic') }

		// current day
		LabelRight { text: i18n('Today') }
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
		LabelRight { text: i18n('Past days') }
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
		LabelRight { text: i18n('Future days') }
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





	} // GridLayout
	
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
