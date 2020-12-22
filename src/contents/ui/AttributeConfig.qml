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
	// FIXME this should not be here, but this is not a reusable compnent though.
	Layout.columnSpan: 8

    // -----------------------------------------------------------------------

	property bool alwaysEnabled: false
	property bool fgEnabled: true
	property bool bgEnabled: true
	property bool boldEnabled: true
	property bool italicEnabled: true
	property bool copyEnabled: true
	property bool pasteEnabled: true

	property bool enabled: true
	property string fg: '#FF000000'
	property string bg: '#00000000'
	property bool bold: false
	property bool italic: false

    // -----------------------------------------------------------------------

	onEnabledChanged: enabledButton.checked = false
	onFgChanged: fgButton.color = fg
	onBgChanged: bgButton.color = bg
	onBoldChanged: boldButton.checked = bold
	onItalicChanged: italicButton.checked = italic

    // -----------------------------------------------------------------------

	/*
	** Checks if key (i.e. 'pastSaturday') exists in theme. If it does,
	** next checks if config node for key's 'enabled' is 'true'.
	** If so, returns value of field element from key node. If node is not
	** enabled, returns key value from parent node. This allows easy
	** handling of i.e. optional TodaySunday config, falling back to Today
	** if not enabled.
	*/
	function getValIfEnabled(theme, key, field, parentNode) {
		return (key in theme) && theme[key]['enabled']
			? theme[key][field]
			: parentNode[field]
	}

	function getNode(theme, key, parentNode) {
		if (parentNode === undefined) parentNode = theme[key]
		return (key in theme)
			? {
				'enabled': theme[key]['enabled'] || false,
				'fg': getValIfEnabled(theme, key, 'fg', parentNode),
				'bg': getValIfEnabled(theme, key, 'bg', parentNode),
				'bold': getValIfEnabled(theme, key, 'bold', parentNode),
				'italic': getValIfEnabled(theme, key, 'italic', parentNode)
			  }
			: parentNode
	}

	function populateIf(theme, key, parentNode) {
		populate(getNode(theme, key, parentNode))
	}

	function populate(node) {
		this.enabled = node['enabled']
		this.fg = node['fg'] || '#FF000000'
		this.bg = node['bg'] || '#00000000'
		this.bold = node['bold'] || false
		this.italic = node['italic'] || false
	}

    // -----------------------------------------------------------------------

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
		onColorChanged: fg = color.toString()
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
		onColorChanged: bg = color.toString()
	}
	ConfigCheckBox {
		id: boldButton
		enabled: enabledButton.checked
		opacity: boldEnabled ? 1 : 0
		onCheckedChanged: bold = checked
	}
	ConfigCheckBox {
		id: italicButton
		enabled: enabledButton.checked
		opacity: italicEnabled ? 1 : 0
		onCheckedChanged: italic = checked
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

