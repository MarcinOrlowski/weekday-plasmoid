/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "../js/meta.js" as Meta
import "../js/DateTimeFormatter.js" as DTF

Item {
    id: main

    Component.onCompleted: {
        plasmoid.setAction("showAboutDialog", i18n('About %1…', Meta.title));
        plasmoid.setAction("checkUpdateAvailability", i18n("Check update…"));
    }

	function action_checkUpdateAvailability() {
		updateChecker.checkUpdateAvailability(true)
	}

    function action_showAboutDialog() {
        aboutDialog.visible = true
    }
    AboutDialog {
		id: aboutDialog
	}

    // ------------------------------------------------------------------------------------------------------------------------

	Plasmoid.toolTipMainText: {
//		var localetouse = plasmoid.configuration.usespecificlocaleenabled ? plasmoid.configuration.usespecificlocalelocalename : ''
//		return new date().tolocaledatestring(qt.locale(localetouse), locale.longformat)
		var template = '%DDD:u%, %d% %MMM% %yyyy%'
//		return DTF.format(template, localeToUse)
		return DTF.format(template)
	}
	Plasmoid.toolTipSubText: {
		var template = '%dy% day of %yyyy%'
//		return DTF.format(template, localeToUse)
		return DTF.format(template)
	}

    // ------------------------------------------------------------------------------------------------------------------------

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	Plasmoid.compactRepresentation: Week {
		timerInterval: 1
	}

    // ------------------------------------------------------------------------------------------------------------------------

	UpdateChecker {
		id: updateChecker

		// once per 7 days
		checkInterval: (((1000*60)*60)*24*7)
	}

} // main
