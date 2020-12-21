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
	property bool alwaysEnabled: false
	property bool fgEnabled: true
	property bool bgEnabled: true
	property bool boldEnabled: true
	property bool italicEnabled: true
	property bool copyEnabled: true
	property bool pasteEnabled: true

	property bool enabled: enabledButton.checked
	property var fg: fgButton.color
	property var bg: bgButton.color
	property bool bold: boldButton.checked
	property bool italic: italicButton.checked

	function setEnabled(flag) {
		if (alwaysEnabled) flag = true
		enabledButton.checked = flag
	}
	function setFg(color) { fgButton.color = color }
	function setBg(color) { bgButton.color = color }
	function setBold(flag) { boldButton.checked = flag }
	function setItalic(flag) { italicButton.checked = flag }

	function populate(node) {
		setEnabled(node['enabled'] || false)
		setFg(node['fg'] || '#FF000000')
		setBg(node['bg'] || '#00000000')
		setBold(node['bold'] || false)
		setItalic(node['italic'] || false)
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
		opacity: fgEnabled ? 1 : 0
	}
	ColorButtonSwap {
		buttonA: fgButton
		buttonB: bgButton
		enabled: enabledButton.checked
		opacity: (fgEnabled && bgEnabled) ? 1 : 0
	}
	ConfigColorButtonBg {
		id: bgButton
		enabled: enabledButton.checked
		opacity: bgEnabled ? 1 : 0
	}
	ConfigCheckBox {
		id: boldButton
		enabled: enabledButton.checked
		opacity: boldEnabled ? 1 : 0
	}
	ConfigCheckBox {
		id: italicButton
		enabled: enabledButton.checked
		opacity: italicEnabled ? 1 : 0
	}
	PlasmaComponents.Button {
		icon.name: 'edit-copy'
		enabled: enabledButton.checked
		opacity: copyEnabled ? 1 : 0
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
		opacity: pasteEnabled ? 1 : 0
		onClicked: {
			var clip = customColors.clipboard
			enabledButton.checked = true
			fgButton.color = clip['fg']
			bgButton.color = clip['bg']
			boldButton.checked = clip['bold']
			italicButton.checked = clip['italic']
		}
	}
}

