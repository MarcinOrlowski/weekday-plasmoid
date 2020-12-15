/**
 * Weekday Widget
 *
 * Configurabler vertical multi clock plasmoid.
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/html-clock-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
//import org.kde.plasma.components 3.0 as PlasmaComponents


ColumnLayout {
	property int dayIndex: 0
	property string label: '?'
	property bool highlight: false

	Layout.fillWidth: true
	Layout.minimumWidth: weekGrid.cellMinWidth
	Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
	
	Rectangle {
		anchors.fill: parent
		color: highlight ? "red" : "blue"
	}

	Text {
		readonly property int dayIndex: 0

		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
		text: parent.label
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
