/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2024 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.workspace.calendar as PlasmaCalendar
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support
import "../js/DateTimeFormatter.js" as DTF
import "../js/meta.js" as Meta

PlasmoidItem {
	id: root

	// ------------------------------------------------------------------------------------------------------------------------

	Plasma5Support.DataSource {
		id: dataSource
		engine: "time"
		connectedSources: ["Local", "UTC"]
		interval: 60000
		intervalAlignment: Plasma5Support.Types.AlignToMinute
	}

	property date tzDate: {
		// get the time for the given timezone from the dataengine
		var now = dataSource.data["Local"]["DateTime"];
		// get current UTC time
		var msUTC = now.getTime() + (now.getTimezoneOffset() * 60000);
		// add the dataengine TZ offset to it
		return new Date(msUTC + (dataSource.data["Local"]["Offset"] * 1000));
	}

	// ------------------------------------------------------------------------------------------------------------------------

	property string tooltipMainTextValue: ''
	property string tooltipSubTextValue: ''

	Plasma5Support.DataSource {
		engine: "time"
		connectedSources: ["Local"]
		interval: 1000
		intervalAlignment: Plasma5Support.Types.NoAlignment
		onDataChanged: {
			var mainText = i18n("Widget is in Fake Parameters mode now.")
			var subText = i18n("Disable it in Settings/User Theme.")

			if (!Plasmoid.configuration.useFakeParameters) {
				var localeToUse = Plasmoid.configuration.useSpecificLocaleEnabled
						? Plasmoid.configuration.useSpecificLocaleLocaleName
						: ''

				mainText = DTF.format(Plasmoid.configuration.tooltipFirstLineFormat, localeToUse)
				subText = DTF.format(Plasmoid.configuration.tooltipSecondLineFormat, localeToUse)
			}

			tooltipMainTextValue = mainText
			tooltipSubTextValue = subText
		}
	}

	toolTipMainText: tooltipMainTextValue
	toolTipSubText: tooltipSubTextValue

	// ------------------------------------------------------------------------------------------------------------------------

	preferredRepresentation: compactRepresentation
	compactRepresentation: Week {
		id: weekWidget
		onToggleExpanded: root.expanded = !root.expanded
	}
	fullRepresentation: CalendarView { }

	// ------------------------------------------------------------------------------------------------------------------------

	Plasmoid.contextualActions: [
		PlasmaCore.Action {
			text: i18n('About %1…', Meta.title)
			icon.name: "help-about"
			onTriggered: aboutDialog.visible = true
		}
	]

	AboutDialog {
		id: aboutDialog
	}

} // main
