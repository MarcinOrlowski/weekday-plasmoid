/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1

Rectangle {
	property string label: '?'
	property string fg: "FFffffff"
	property string bg: "#00000000"
	property bool bold: false
	property bool italic: false

	implicitWidth: dayLabel.implicitWidth
	implicitHeight: dayLabel.implicitHeight

	Layout.fillWidth: true
	Layout.minimumWidth: weekGrid.cellMinWidth
	Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
	Layout.margins: 0
	
	color: bg

	Text {
		id: dayLabel

		text: label
		color: fg
		font.bold: bold
		font.italic: italic

		anchors.fill: parent

		Layout.fillWidth: true
		Layout.margins: 4

		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
	}
}
