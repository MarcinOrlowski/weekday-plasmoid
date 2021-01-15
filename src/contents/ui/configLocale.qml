/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.components 3.0 as PlasmaComponents

Kirigami.FormLayout {
	Layout.fillWidth: true

	property alias cfg_useSpecificLocaleEnabled: useSpecificLocaleEnabled.checked
	property alias cfg_useSpecificLocaleLocaleName: useSpecificLocaleLocaleName.text
	property alias cfg_nonDefaultWeekStartDayEnabled: nonDefaultWeekStartDayEnabled.checked
	property alias cfg_nonDefaultWeekStartDayDayIndex: nonDefaultWeekStartDayDayIndex.currentIndex

	property alias cfg_customDayLabelsEnabled: customDayLabelsEnabled.checked

	property alias cfg_customDayLabelSundayEnabled: customDayLabelSundayEnabled.checked
	property alias cfg_customDayLabelSundayLabel: customDayLabelSundayLabel.text
	property alias cfg_customDayLabelMondayEnabled: customDayLabelMondayEnabled.checked
	property alias cfg_customDayLabelMondayLabel: customDayLabelMondayLabel.text
	property alias cfg_customDayLabelTuesdayEnabled: customDayLabelTuesdayEnabled.checked
	property alias cfg_customDayLabelTuesdayLabel: customDayLabelTuesdayLabel.text
	property alias cfg_customDayLabelWednesdayEnabled: customDayLabelWednesdayEnabled.checked
	property alias cfg_customDayLabelWednesdayLabel: customDayLabelWednesdayLabel.text
	property alias cfg_customDayLabelThursdayEnabled: customDayLabelThursdayEnabled.checked
	property alias cfg_customDayLabelThursdayLabel: customDayLabelThursdayLabel.text
	property alias cfg_customDayLabelFridayEnabled: customDayLabelFridayEnabled.checked
	property alias cfg_customDayLabelFridayLabel: customDayLabelFridayLabel.text
	property alias cfg_customDayLabelSaturdayEnabled: customDayLabelSaturdayEnabled.checked
	property alias cfg_customDayLabelSaturdayLabel: customDayLabelSaturdayLabel.text

	RowLayout {
		CheckBox {
			id: useSpecificLocaleEnabled
			text: i18n("Use non default locale")
		}

		TextField {
			id: useSpecificLocaleLocaleName
			enabled: cfg_useSpecificLocaleEnabled
			placeholderText: "en_US"
			Kirigami.FormData.label: i18n('Name of locale')
		}
	}

	RowLayout {
		CheckBox {
			id: nonDefaultWeekStartDayEnabled
			text: i18n("Use non default week start day")
		}

		PlasmaComponents.ComboBox {
			id: nonDefaultWeekStartDayDayIndex
			enabled: cfg_nonDefaultWeekStartDayEnabled

			// This is to make it work on pre Qt5.14
			// https://develop.kde.org/docs/plasma/widget/plasma-qml-api/#combobox---multiple-choice
			property string _valueRole: "value"
			readonly property var _currentValue: _valueRole && currentIndex >= 0 ? model[currentIndex][_valueRole] : null

			textRole: "text"
			model: [
				{ value: 0, text: i18n("Sunday") },
				{ value: 1, text: i18n("Monday") },
				{ value: 2, text: i18n("Tuesday") },
				{ value: 3, text: i18n("Wednesday") },
				{ value: 4, text: i18n("Thursday") },
				{ value: 5, text: i18n("Friday") },
				{ value: 6, text: i18n("Saturday") },
			]
		}
	}

	// ------------------------------------------------------------------------------------------------------------------------

	CheckBox {
		id: customDayLabelsEnabled
		text: i18n("Use custom day labels")
	}

	Kirigami.FormLayout {
		Layout.fillWidth: true
		anchors.left: parent.left
		anchors.right: parent.right

		enabled: cfg_customDayLabelsEnabled

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Sunday")
			CheckBox {
				id: customDayLabelSundayEnabled
			}
			TextField {
				id: customDayLabelSundayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelSundayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Monday")
			CheckBox {
				id: customDayLabelMondayEnabled
			}
			TextField {
				id: customDayLabelMondayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelMondayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Tuesday")
			CheckBox {
				id: customDayLabelTuesdayEnabled
			}
			TextField {
				id: customDayLabelTuesdayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelTuesdayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Wednesday")
			CheckBox {
				id: customDayLabelWednesdayEnabled
			}
			TextField {
				id: customDayLabelWednesdayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelWednesdayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Thursday")
			CheckBox {
				id: customDayLabelThursdayEnabled
			}
			TextField {
				id: customDayLabelThursdayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelThursdayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Friday")
			CheckBox {
				id: customDayLabelFridayEnabled
			}
			TextField {
				id: customDayLabelFridayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelFridayEnabled
			}
		}

		RowLayout {
			Layout.fillWidth: true
			Kirigami.FormData.label: i18n("Saturday")
			CheckBox {
				id: customDayLabelSaturdayEnabled
			}
			TextField {
				id: customDayLabelSaturdayLabel
				maximumLength: 1
				Layout.fillWidth: true
				enabled: cfg_customDayLabelSaturdayEnabled
			}
		}

	} // FormLayout

	// ------------------------------------------------------------------------------------------------------------------------

	Item {
		Layout.fillWidth: true
		Layout.fillHeight: true
	}

} // FormLayout
