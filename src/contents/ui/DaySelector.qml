/**
 * Weekday Grid widget for Plasma 6 / KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2026 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 *
 * DaySelector helper component.
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents

RowLayout {
	signal changed(int dayIndex)

	property int value: 0

	PlasmaComponents.ComboBox {
		property int _lastIndex: 0

		id: day
		model: [
			i18n("Sunday"),
			i18n("Monday"),
			i18n("Tuesday"),
			i18n("Wednesday"),
			i18n("Thursday"),
			i18n("Friday"),
			i18n("Saturday"),
		]
		onCurrentIndexChanged: {
			if (currentIndex !== parent.value) {
				changed(currentIndex)
				parent.value = currentIndex
			}
		}
	}
	PlasmaComponents.Button {
		implicitWidth: minimumWidth
		icon.name: "go-previous"
		onClicked: day.currentIndex = (day.currentIndex > 0) ? (day.currentIndex - 1) : 6
	}
	PlasmaComponents.Button {
		implicitWidth: minimumWidth
		icon.name: "go-next"
		onClicked: day.currentIndex = (day.currentIndex + 1) % 7
	}
}
