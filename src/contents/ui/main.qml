/**
 * Weekday Plasmoid
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import org.kde.plasma.plasmoid 2.0

Item {
    id: main

    // ------------------------------------------------------------------------------------------------------------------------

	Plasmoid.compactRepresentation: Weekday {}
	Plasmoid.fullRepresentation: Weekday {}

    // ------------------------------------------------------------------------------------------------------------------------

} // main
