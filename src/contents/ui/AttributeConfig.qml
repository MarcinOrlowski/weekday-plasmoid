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

RowLayout {
	// FIXME this should not be here, but this is not a reusable component though.
	Layout.columnSpan: 8

	// -----------------------------------------------------------------------

	property bool alwaysEnabled: false
	property bool fgEnabled: true
	property bool bgEnabled: true
	property bool boldEnabled: true
	property bool italicEnabled: true
	property bool copyEnabled: true
	property bool pasteEnabled: true

	property bool configEnabled: false
	property string fg: '#FF000000'
	property string bg: '#00000000'
	property bool bold: false
	property bool italic: false

	// -----------------------------------------------------------------------

	onAlwaysEnabledChanged: if(alwaysEnabled) configEnabled = true
	onConfigEnabledChanged: enabledButton.checked = configEnabled
	onFgChanged: fgButton.color = fg
	onBgChanged: bgButton.color = bg
	onBoldChanged: boldButton.checked = bold
	onItalicChanged: italicButton.checked = italic

	// -----------------------------------------------------------------------

	function getThemeVal(theme, key, field, defaultVal) {
		return (key in theme)
			? (theme[key][field] || defaultVal)
			: defaultVal
	}

	function getNode(theme, key, parentNode) {
		if (parentNode === undefined) parentNode = theme[key]

		var defaultFg = parentNode['fg'] || '#FF000000'
		var defaultBg = parentNode['bg'] || '#00000000'
		var defaultBold = parentNode['bold'] || false
		var defaultItalic = parentNode['italic'] || false

		return {
			'enabled': getThemeVal(theme, key, 'enabled', alwaysEnabled),
			'fg': getThemeVal(theme, key, 'fg', defaultFg),
			'bg': getThemeVal(theme, key, 'bg', defaultBg),
			'bold': getThemeVal(theme, key, 'bold', defaultBold),
			'italic': getThemeVal(theme, key, 'italic', defaultItalic)
		}
	}

	function populateIf(theme, key, parentNode) {
		populate(getNode(theme, key, parentNode))
	}

	function populate(node) {
		this.configEnabled = node['enabled'] || false
		this.fg = node['fg'] || '#FF000000'
		this.bg = node['bg'] || '#00000000'
		this.bold = node['bold'] || false
		this.italic = node['italic'] || false
	}

	// -----------------------------------------------------------------------

	ConfigCheckBox {
		id: enabledButton
		enabled: !alwaysEnabled
		checked: configEnabled
		opacity: alwaysEnabled ? 0 : 1
		onCheckedChanged: configEnabled = checked
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
	ConfigCheckableButton {
		id: boldButton
		enabled: enabledButton.checked
		icon.name: 'format-text-bold-symbolic'
		opacity: boldEnabled ? 1 : 0
		onCheckedChanged: bold = checked
	}
	ConfigCheckableButton {
		id: italicButton
		enabled: enabledButton.checked
		icon.name: 'format-text-italic-symbolic'
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

} // RowLayout

