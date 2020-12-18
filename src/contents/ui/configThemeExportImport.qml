/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.plasmoid 2.0

ColumnLayout {
//	width: childrenRect.width
	Layout.fillWidth: true
	Layout.fillHeight: true

//    property alias cfg_useSpecificLocaleEnabled: useSpecificLocaleEnabled.checked

//	Item {
//		Kirigami.FormData.label: i18n('Localization')
//		Kirigami.FormData.isSection: true
//	}

	QtControls.TextArea {
		id: jsonTextArea
		Layout.fillWidth: true
		Layout.fillHeight: true
	}

	RowLayout {
		PlasmaComponents.Button {
			text: 'Update'
			icon.name: 'view-refresh-symbolic'
			onClicked: {
				var json = {
					'widget': {'bg': plasmoid.configuration.customColorsWidgetBg.toString()},
					'today': {
						'fg': plasmoid.configuration.customColorsTodayFg.toString(),
						'bg': plasmoid.configuration.customColorsTodayBg.toString(),
						'bold': plasmoid.configuration.customColorsTodayBold,
						'italic': plasmoid.configuration.customColorsTodayItalic
					},
					'pastDay': {
						'fg': plasmoid.configuration.customColorsPastDayFg.toString(),
						'bg': plasmoid.configuration.customColorsPastDayBg.toString(),
						'bold': plasmoid.configuration.customColorsPastDayBold,
						'italic': plasmoid.configuration.customColorsPastDayItalic
					},
					'futureDay': {
						'fg': plasmoid.configuration.customColorsFutureDayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureDayBg.toString(),
						'bold': plasmoid.configuration.customColorsFutureDayBold,
						'italic': plasmoid.configuration.customColorsFutureDayItalic
					},
					'futureSaturday': {
						'enabled': plasmoid.configuration.customColorsFutureSaturdayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSaturdayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureSaturdayBg.toString(),
						'bold': plasmoid.configuration.customColorsFutureSaturdayBold,
						'italic': plasmoid.configuration.customColorsFutureSaturdayItalic
					},
					'futureSunday': {
						'enabled': plasmoid.configuration.customColorsFutureSundayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSundayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureSundayBg.toString(),
						'bold': plasmoid.configuration.customColorsFutureSundayBold,
						'italic': plasmoid.configuration.customColorsFutureSundayItalic
					}
				}

				jsonTextArea.text = JSON.stringify(json)
			}
		}

		PlasmaComponents.Button {
			text: 'Import'
			icon.name: 'view-refresh-symbolic'
			onClicked: {
			}
		}
	}

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
