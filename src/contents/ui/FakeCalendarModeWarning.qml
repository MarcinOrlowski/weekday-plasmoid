/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

Kirigami.InlineMessage {
	Layout.fillWidth: true
	Layout.margins: Kirigami.Units.smallSpacing
	type: Kirigami.MessageType.Warning
	text: 'Widget "Fake parameters" mode is enabled in "Theme" editor.'
	showCloseButton: true
	visible: plasmoid.configuration.useFakeParameters
}

