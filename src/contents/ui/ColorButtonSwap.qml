/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
import org.kde.plasma.components 3.0 as PlasmaComponents

PlasmaComponents.Button {
	property var buttonA: undefined
	property var buttonB: undefined
//	text: ''
	icon.name: 'swap-panels'
	onClicked: {
		// we need to 'export' color, otherwise using just .color would get
		// get us only color reference, overwritten next line, killing the swap
		var tmp = buttonA.color.toString()
		buttonA.color = buttonB.color
		buttonB.color = tmp
	}
}
