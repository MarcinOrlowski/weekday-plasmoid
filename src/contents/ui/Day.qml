/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1

Rectangle {
	id: container

	property string label: '?'
	property string fg: "#FFffffff"
	property string bg: "#00000000"
	property bool bold: false
	property bool italic: false
	property bool lastDay: false
	property string lastDayBg: "#FF00ff00"

	readonly property int lastDayWidth: 2

	property bool useCustomFont: false
	property font typeface: undefined

	implicitWidth: dayLabel.implicitWidth + (lastDay ? lastDayWidth : 0)
	implicitHeight: dayLabel.implicitHeight

	Layout.fillWidth: true
	Layout.minimumWidth: weekGrid.cellMinWidth + (lastDay ? lastDayWidth : 0)
	Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
	Layout.margins: 0

	color: bg

	Text {
		id: dayLabel

		text: label
		color: fg
		font.bold: bold
		font.italic: italic

		font.family: useCustomFont ? typeface.family : theme.defaultFont.family
		font.pointSize: useCustomFont ? typeface.pointSize : theme.defaultFont.pointSize

		anchors.fill: container

		Layout.fillWidth: true
		Layout.margins: 4

		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
	}

	Rectangle {
		visible: lastDay
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		implicitWidth: lastDayWidth
		color: lastDayBg
	}
}
