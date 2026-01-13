/**
 * Weekday Grid widget for Plasma 6 / KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2026 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQControls
import org.kde.plasma.components as PlasmaComponents

Kirigami.FormLayout {
	Layout.fillWidth: true

	property alias cfg_calendarViewEnabled: calendarViewEnabled.checked
	property alias cfg_showWeekNumbers: showWeekNumbers.checked

	FakeCalendarModeWarning {}

	CheckBox {
		id: calendarViewEnabled
		text: i18n("Enable calendar view")
	}

	CheckBox {
		id: showWeekNumbers
		enabled: cfg_calendarViewEnabled
		text: i18n("Show week numbers")
	}

	Item {
		Layout.fillWidth: true
		Layout.fillHeight: true
	}

}
