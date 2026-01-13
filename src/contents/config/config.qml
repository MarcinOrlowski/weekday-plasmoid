/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2024 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import org.kde.plasma.configuration

ConfigModel {
	ConfigCategory {
		name: i18n("Appearance")
		icon: "view-visible"
		source: "ConfigAppearance.qml"
	}
	ConfigCategory {
		name: i18n("User Theme")
		icon: "view-visible"
		source: "ConfigTheme.qml"
	}
	ConfigCategory {
		name: i18n("Locale")
		icon: "languages"
		source: "ConfigLocale.qml"
	}
	ConfigCategory {
		name: i18n("Calendar View")
		icon: "view-calendar"
		source: "ConfigCalendar.qml"
	}
	ConfigCategory {
		name: i18n("Tooltip")
		icon: "view-calendar-workweek"
		source: "ConfigTooltip.qml"
	}
	ConfigCategory {
		name: i18n("Export/Import")
		icon: "document-export"
		source: "ConfigThemeExportImport.qml"
	}

}
