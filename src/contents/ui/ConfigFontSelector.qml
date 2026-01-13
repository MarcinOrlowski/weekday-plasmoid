/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2024 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Dialogs

QtControls.Button {
	// There seems to be a bug in FontDialog that causes "font" property to
	// act as "selectedFont" which means both are updated immediately while
	// "font" is documented to be updated only once selection is Accepted,
	// so I had to add "proxy" property to work that around.
	property font selectedFont: Qt.application.font

	text: i18n("Select font")
	onClicked: customFontDialog.open()
	FontDialog {
		id: customFontDialog
		onAccepted: selectedFont = customFontDialog.selectedFont
		Component.onCompleted: customFontDialog.selectedFont = selectedFont
	}
}

