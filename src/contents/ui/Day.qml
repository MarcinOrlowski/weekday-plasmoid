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
	property string highlightFg: "white"
	property string highlightBg: "black"

	Layout.fillWidth: true
	Layout.minimumWidth: weekGrid.cellMinWidth
	Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

	Layout.margins: 0
	
	Rectangle {
		anchors.fill: parent
		color: highlight ? highlightBg : "#00000000"
	}

	Text {
//		padding: 6
		readonly property int dayIndex: 0

		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
		text: parent.label
		color: highlight ? highlightFg : "white"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
