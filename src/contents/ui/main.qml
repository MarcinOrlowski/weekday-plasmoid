/**
 * Weekday Plasmoid
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: main
/*
	states: [
		State {
			name: "horizontalPanel"
			when: plasmoid.formFactor === PlasmaCore.Types.Horizontal

			PropertyChanges {
				target: main
				Layout.maximumWidth: 100
			}
		},

		State {
			name: "verticalPanel"
			when: plasmoid.formFactor === PlasmaCore.Types.Vertical

			PropertyChanges {
				target: main
				Layout.maximumWidth: 300
			}
		}
	]
*/

    // ------------------------------------------------------------------------------------------------------------------------

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.compactRepresentation: Week {} 

    // ------------------------------------------------------------------------------------------------------------------------

} // main
