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

	property alias cfg_customColorsPassedDayFg: customColorsPassedDayFg.color
	property alias cfg_customColorsPassedDayBg: customColorsPassedDayBg.color
	property alias cfg_customColorsPassedDayBold: customColorsPassedDayBold.checked
	property alias cfg_customColorsPassedDayItalic: customColorsPassedDayItalic.checked

	property alias cfg_customColorsTodayFg: customColorsTodayFg.color
	property alias cfg_customColorsTodayBg: customColorsTodayBg.color
	property alias cfg_customColorsTodayBold: customColorsTodayBold.checked
	property alias cfg_customColorsTodayItalic: customColorsTodayItalic.checked

	property alias cfg_customColorsFutureDayFg: customColorsFutureDayFg.color
	property alias cfg_customColorsFutureDayBg: customColorsFutureDayBg.color
	property alias cfg_customColorsFutureDayBold: customColorsFutureDayBold.checked
	property alias cfg_customColorsFutureDayItalic: customColorsFutureDayItalic.checked

//	Item {
//		Kirigami.FormData.label: i18n('Appearance')
//		Kirigami.FormData.isSection: true
//	}

	CheckBox {
		id: customColorsEnabled
		text: i18n("Use custom colors")
	}

	GridLayout {
		columns: 5
		enabled: cfg_customColorsEnabled

		PlasmaComponents.Label {
			text: ''
		}
		PlasmaComponents.Label {
			text: i18n('Text')
		}
		PlasmaComponents.Label {
			text: i18n('Bg')
		}
		PlasmaComponents.Label {
			text: i18n('Bold')
		}
		PlasmaComponents.Label {
			text: i18n('Italic')
		}

		// passed day
		PlasmaComponents.Label {
			text: i18n('Passed days')
		}
		KQControls.ColorButton {
			id: customColorsPassedDayFg
			showAlphaChannel: true
			dialogTitle: i18n('Select text color')
//			onColorChanged: console.log(color)
		}
		KQControls.ColorButton {
			id: customColorsPassedDayBg
			showAlphaChannel: true
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsPassedDayBold
		}
		CheckBox {
			id: customColorsPassedDayItalic
		}

		// current day
		PlasmaComponents.Label {
			text: i18n('Today')
		}
		KQControls.ColorButton {
			id: customColorsTodayFg
			showAlphaChannel: true
			dialogTitle: i18n('Select text color')
		}
		KQControls.ColorButton {
			id: customColorsTodayBg
			showAlphaChannel: true
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsTodayBold
		}
		CheckBox {
			id: customColorsTodayItalic
		}

		// future day
		PlasmaComponents.Label {
			text: i18n('Future days')
		}
		KQControls.ColorButton {
			id: customColorsFutureDayFg
			showAlphaChannel: true
			dialogTitle: i18n('Select text color')
		}
		KQControls.ColorButton {
			id: customColorsFutureDayBg
			showAlphaChannel: true
			dialogTitle: i18n('Select background color')
		}
		CheckBox {
			id: customColorsFutureDayBold
		}
		CheckBox {
			id: customColorsFutureDayItalic
		}
	} // GridLayout
	
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
