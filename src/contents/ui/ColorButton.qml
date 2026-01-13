/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2023 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kquickcontrols as KQControls

KQControls.ColorButton {
	showAlphaChannel: true
	dialogTitle: i18n('Select background color')
	Layout.alignment: Qt.AlignHCenter
}
