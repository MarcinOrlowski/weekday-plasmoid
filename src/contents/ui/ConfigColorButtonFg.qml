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
// KDeclarative
import org.kde.kquickcontrols 2.0 as KQControls

KQControls.ColorButton {
	showAlphaChannel: true
	dialogTitle: i18n('Select text color')
	Layout.alignment: Qt.AlignHCenter
}
