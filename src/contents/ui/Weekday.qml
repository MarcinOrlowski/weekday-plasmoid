/**
 * HTML Clock Plasmoid
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
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "../js/utils.js" as Utils

GridLayout {
	id: mainContainer

	rows: 1
	columns: 7

	Layout.fillWidth: true

    // ------------------------------------------------------------------------------------------------------------------------

	// we always count from 0 being sunday
	property int weekday: 3
	property bool weekStartsOnSunday: false

	property string today: "#ff0000"

	// we start from Sunday here
	property var labels: []

	Component.onCompleted: {
		// it's known that Jan 5, 2020 is Sunday
		for(var i=0; i<7; i++) {
			// it's known that Jan 5, 2020 is Sunday
			var now = new Date(2020, 0, 5+i)
			labels[i] = Qt.formatDate(now, 'ddd').substr(0, 1).toUpperCase()
		}
	}

    // ------------------------------------------------------------------------------------------------------------------------

	// https://doc.qt.io/qt-5/richtext-html-subset.html
	Timer {
		interval: 1000 * 30
		repeat: true
		running: true
		triggeredOnStart: true
		onTriggered: {
			var now = new Date()
			weekday = now.getDay()

			var row='<table width="100%"><tr>'
			for(var i=0; i<7; i++) {
				var label = labels[i % 7]
				row += '<td align="center" '
				if (weekday == i%7) {
					row += ' bgcolor="red">'
					row += `<b>${label}</b>`
				} else {
					row += '>' + label
				}
				row += '</td>'
			}

			row+='</tr></table>'

			widget.text = row
		}
	}

    // ------------------------------------------------------------------------------------------------------------------------

	PlasmaComponents.Label {
		id: widget
		anchors.left: parent.left
		anchors.right: parent.right

		Layout.fillWidth: true
		Layout.alignment: Qt.AlignHCenter
		textFormat: Text.RichText
//		visible: mainContainer.weekStartsOnSunday && weekday == 0
		text: ''
	}

	// ------------------------------------------------------------------------------------------------------------------------

} // mainContainer
