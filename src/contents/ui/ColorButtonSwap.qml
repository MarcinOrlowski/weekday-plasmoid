/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
//import org.kde.kquickcontrols 2.0 as KQControls

Button {
	Layout.fillWidth: false
	property var buttonA: undefined
	property var buttonB: undefined
	text: '<>'
	onClicked: {
		var tmp = buttonA.color.toString()
		buttonA.color = buttonB.color
		buttonB.color = tmp
	}
}

