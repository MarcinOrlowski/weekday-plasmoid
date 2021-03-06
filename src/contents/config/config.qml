/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
	ConfigCategory {
		name: i18n("Appearance")
		icon: "view-visible"
		source: "configAppearance.qml"
	}
	ConfigCategory {
		name: i18n("User Theme")
		icon: "view-visible"
		source: "configTheme.qml"
	}
	ConfigCategory {
		name: i18n("Locale")
		icon: "languages"
		source: "configLocale.qml"
	}
	ConfigCategory {
		name: i18n("Calendar View")
		icon: "view-calendar"
		source: "configCalendar.qml"
	}
	ConfigCategory {
		name: i18n("Tooltip")
		icon: "view-calendar-workweek"
		source: "configTooltip.qml"
	}
	ConfigCategory {
		name: i18n("Export/Import")
		icon: "document-export"
		source: "configThemeExportImport.qml"
	}

}
