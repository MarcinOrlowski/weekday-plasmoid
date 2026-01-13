/**
 * Weekday Grid widget for Plasma 6 / KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2026 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid

Kirigami.InlineMessage {
	Layout.fillWidth: true
	Layout.margins: Kirigami.Units.smallSpacing
	type: Kirigami.MessageType.Warning
	text: 'Widget "Fake parameters" mode is enabled in "Theme" editor.'
	showCloseButton: true
	visible: Plasmoid.configuration.useFakeParameters
}
