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

ColumnLayout {
    width: childrenRect.width

    property alias cfg_useSpecificLocaleEnabled: useSpecificLocaleEnabled.checked
	property alias cfg_useSpecificLocaleLocaleName: useSpecificLocaleLocaleName.text
	property alias cfg_nonDefaultWeekStartDayEnabled: nonDefaultWeekStartDayEnabled.checked
	property alias cfg_nonDefaultWeekStartDayDayIndex: nonDefaultWeekStartDayDayIndex.currentIndex

    GroupBox {
        title: i18n("Localization")
        Layout.fillWidth: true

        Kirigami.FormLayout {
            anchors.left: parent.left
            anchors.right: parent.right

        	RowLayout {
                Layout.fillWidth: true
        	    Kirigami.FormData.label: i18n("Use non default locale")

                CheckBox {
                    id: useSpecificLocaleEnabled
                }

                TextField {
					id: useSpecificLocaleLocaleName
                    Layout.fillWidth: true
                    enabled: cfg_useSpecificLocaleEnabled
                }
			}

        	RowLayout {
                Layout.fillWidth: true
        	    Kirigami.FormData.label: i18n("Use non default week start day")

                CheckBox {
                    id: nonDefaultWeekStartDayEnabled
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

        } // FormLayout
    } // localization

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

    GroupBox {
		id: colors
        title: i18n("Appearance")
        Layout.fillWidth: true

        Kirigami.FormLayout {
            anchors.left: parent.left
            anchors.right: parent.right

        	RowLayout {
                Layout.fillWidth: true
        	    Kirigami.FormData.label: i18n("Use custom theme")

                CheckBox {
                    id: customColorsEnabled
                }
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
//					onColorChanged: console.log(color)
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
		}
	}

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
