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
import org.kde.plasma.components 3.0 as PlasmaComponents

RowLayout {
	readonly property bool enabled: enabledButton.checked
	readonly property var fg: fgButton.color 
	readonly property var bg: bgButton.color
	readonly property bool bold: boldButton.checked
	readonly property bool italic: italicButton.checked
	property bool alwaysEnabled: false

	function setEnabled(flag) {
		if (alwaysEnabled) flag = true
		enabledButton.checked = flag
	}
	function setFg(color) { fgButton.color = color }
	function setBg(color) { bgButton.color = color }
	function setBold(flag) { boldButton.checked = flag }
	function setItalic(flag) { italicButton.checked = flag }

	function getVal(node, key, def) {
		return (key in node) ? node[key] : def
	}

	function populate(node) {
		setEnabled(getVal(node, 'enabled', false))
		setFg(getVal(node, 'fg', '#FF000000'))
		setBg(getVal(node, 'bg', '#00000000'))
		setBold(getVal(node, 'bold', false))
		setItalic(getVal(node, 'italic', false))
	}

	Layout.columnSpan: 8

	ConfigCheckBox {
		id: enabledButton
		enabled: !alwaysEnabled
		checked: alwaysEnabled
		opacity: alwaysEnabled ? 0 : 1
	}
	ConfigColorButtonFg {
		id: fgButton
		enabled: enabledButton.checked
	}
	ColorButtonSwap {
		buttonA: fgButton
		buttonB: bgButton
		enabled: enabledButton.checked
	}
	ConfigColorButtonBg {
		id: bgButton
		enabled: enabledButton.checked
	}
	ConfigCheckBox {
		id: boldButton
		enabled: enabledButton.checked
	}
	ConfigCheckBox {
		id: italicButton
		enabled: enabledButton.checked
	}
	PlasmaComponents.Button {
		icon.name: 'edit-copy'
		enabled: enabledButton.checked
		onClicked: {
			customColors.clipboard = {
				"fg": fgButton.color.toString(),
				"bg": bgButton.color.toString(),
				"bold": boldButton.checked,
				"italic": italicButton.checked
			}
		}
	}
	PlasmaComponents.Button {
		icon.name: 'edit-paste'
		enabled: customColors.clipboard !== undefined
		onClicked: {
			var clip = customColors.clipboard
			enabledButton.checked = true
			fgButton.color = clip['fg']
			bgButton.color = clip['bg']
			boldButton.checked = clip['bold']
			italicButton.checked = clip['italic']
		}
	}

/*
	StyleCopyButton {}
	StylePasteButton {}
*/
}

