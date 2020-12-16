/**
 * Weekday Widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

ColumnLayout {
	id: container

/*
	Rectangle {
		anchors.fill: parent
		color: "#aa0000ff"
	}
*/

    // ------------------------------------------------------------------------------------------------------------------------

	// we always count from 0 being sunday
	property int weekdayOffset: 0
	property int firstDayOfWeek: 0

	property string todayFg: "white"
	property string todayBg: "#ff006e"

	// we start from Sunday here
	property var labels: ['', '', '', '', '', '', '']

    // ------------------------------------------------------------------------------------------------------------------------

	// https://doc.qt.io/qt-5/richtext-html-subset.html
	Timer {
		interval: 1000 * 30
		repeat: true
		running: true
		triggeredOnStart: true
		onTriggered: {
			// https://doc.qt.io/qt-5/qml-qtqml-locale.html
			// Offset indicates first day of week with Sunday equals 0
			// and Saturday equals 6
			// https://doc.qt.io/qt-5/qml-qtqml-locale.html#firstDayOfWeek-prop
			firstDayOfWeek = Qt.locale().firstDayOfWeek

			var now = new Date()
			weekdayOffset = now.getDay()-firstDayOfWeek

			// it's known that Jan 5, 2020 is Sunday
			// so we shift the index offset (based on locale) so the first
			// cell of 'labels' is always first day of the week.
			var tmp = ['', '', '', '', '', '', '']

			for(var i=0; i<7; i++) {
				// it's known that Jan 5, 2020 is Sunday
				var day = new Date(2020, 0, 5+firstDayOfWeek+i)
				tmp[i] = Qt.formatDate(day, 'ddd').substr(0, 1).toUpperCase()
			}
			labels = tmp
		}
	}

    // ------------------------------------------------------------------------------------------------------------------------

	GridLayout {
		id: weekGrid
		columns: 7
		rows: 1
		Layout.fillWidth: true
		Layout.fillHeight: true
		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
/*
		Rectangle {
			anchors.fill: parent
			color: "#aa00ff00"
		}
*/
		readonly property int cellMinWidth: 16

		Repeater {
			model: 7
			Day {
				dayIndex: index
				label: container.labels[this.dayIndex]
				highlight: weekdayOffset === this.dayIndex
				highlightFg: container.todayFg
				highlightBg: container.todayBg
			}
		}
	} // weekGrid

} // container
