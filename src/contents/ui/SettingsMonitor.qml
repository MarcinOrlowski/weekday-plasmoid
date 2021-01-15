/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents

// Hope there a smarter way to know when settings are changed
// and I just missed it so far...
Item {
	// FIXME: The main issue (thus not that harmful) is that changed() will be emitted 
	// for each attribute changed (i.e. all theme's). I could deffer signal with timer
	// but that's just making crappy apprach even worse.
	signal changed()

	// Locale settings
	property bool useSpecificLocaleEnabled: plasmoid.configuration.useSpecificLocaleEnabled
	onUseSpecificLocaleEnabledChanged: changed()
	property string useSpecificLocaleLocaleName: plasmoid.configuration.useSpecificLocaleLocaleName
	onUseSpecificLocaleLocaleNameChanged: changed()
	property bool nonDefaultWeekStartDayEnabled: plasmoid.configuration.nonDefaultWeekStartDayEnabled
	onNonDefaultWeekStartDayEnabledChanged: changed()
	property int nonDefaultWeekStartDayDayIndex: plasmoid.configuration.nonDefaultWeekStartDayDayIndex
	onNonDefaultWeekStartDayDayIndexChanged: changed()

	// Appearance theme
	property string themeName: plasmoid.configuration.themeName
	onThemeNameChanged: changed()
	property bool useUserTheme: plasmoid.configuration.useUserTheme
	onUseUserThemeChanged: changed()

	// User theme settings
	property string widgetBg: plasmoid.configuration.widgetBg
	onWidgetBgChanged: changed()

	property string lastDayMonthEnabled: plasmoid.configuration.lastDayMonthEnabled
	onLastDayMonthEnabledChanged: changed()
	property string lastDayMonthBg: plasmoid.configuration.lastDayMonthBg
	onLastDayMonthBgChanged: changed()

	property string pastFg: plasmoid.configuration.pastFg
	onPastFgChanged: changed()
	property string pastBg: plasmoid.configuration.pastBg
	onPastBgChanged: changed()
	property bool pastBold: plasmoid.configuration.pastBold
	onPastBoldChanged: changed()
	property bool pastItalic: plasmoid.configuration.pastItalic
	onPastItalicChanged: changed()

	property string pastSaturdayEnabled: plasmoid.configuration.pastSaturdayEnabled
	onPastSaturdayEnabledChanged: changed()
	property string pastSaturdayFg: plasmoid.configuration.pastSaturdayFg
	onPastSaturdayFgChanged: changed()
	property string pastSaturdayBg: plasmoid.configuration.pastSaturdayBg
	onPastSaturdayBgChanged: changed()
	property bool pastSaturdayBold: plasmoid.configuration.pastSaturdayBold
	onPastSaturdayBoldChanged: changed()
	property bool pastSaturdayItalic: plasmoid.configuration.pastSaturdayItalic
	onPastSaturdayItalicChanged: changed()

	property string pastSundayEnabled: plasmoid.configuration.pastSundayEnabled
	onPastSundayEnabledChanged: changed()
	property string pastSundayFg: plasmoid.configuration.pastSundayFg
	onPastSundayFgChanged: changed()
	property string pastSundayBg: plasmoid.configuration.pastSundayBg
	onPastSundayBgChanged: changed()
	property bool pastSundayBold: plasmoid.configuration.pastSundayBold
	onPastSundayBoldChanged: changed()
	property bool pastSundayItalic: plasmoid.configuration.pastSundayItalic
	onPastSundayItalicChanged: changed()

	property string todayFg: plasmoid.configuration.todayFg
	onTodayFgChanged: changed()
	property string todayBg: plasmoid.configuration.todayBg
	onTodayBgChanged: changed()
	property bool todayBold: plasmoid.configuration.todayBold
	onTodayBoldChanged: changed()
	property bool todayItalic: plasmoid.configuration.todayItalic
	onTodayItalicChanged: changed()

	property string todaySaturdayEnabled: plasmoid.configuration.todaySaturdayEnabled
	onTodaySaturdayEnabledChanged: changed()
	property string todaySaturdayFg: plasmoid.configuration.todaySaturdayFg
	onTodaySaturdayFgChanged: changed()
	property string todaySaturdayBg: plasmoid.configuration.todaySaturdayBg
	onTodaySaturdayBgChanged: changed()
	property bool todaySaturdayBold: plasmoid.configuration.todaySaturdayBold
	onTodaySaturdayBoldChanged: changed()
	property bool todaySaturdayItalic: plasmoid.configuration.todaySaturdayItalic
	onTodaySaturdayItalicChanged: changed()

	property string todaySundayEnabled: plasmoid.configuration.todaySundayEnabled
	onTodaySundayEnabledChanged: changed()
	property string todaySundayFg: plasmoid.configuration.todaySundayFg
	onTodaySundayFgChanged: changed()
	property string todaySundayBg: plasmoid.configuration.todaySundayBg
	onTodaySundayBgChanged: changed()
	property bool todaySundayBold: plasmoid.configuration.todaySundayBold
	onTodaySundayBoldChanged: changed()
	property bool todaySundayItalic: plasmoid.configuration.todaySundayItalic
	onTodaySundayItalicChanged: changed()

	property string futureFg: plasmoid.configuration.futureFg
	onFutureFgChanged: changed()
	property string futureBg: plasmoid.configuration.futureBg
	onFutureBgChanged: changed()
	property bool futureBold: plasmoid.configuration.futureBold
	onFutureBoldChanged: changed()
	property bool futureItalic: plasmoid.configuration.futureItalic
	onFutureItalicChanged: changed()

	property string futureSaturdayEnabled: plasmoid.configuration.futureSaturdayEnabled
	onFutureSaturdayEnabledChanged: changed()
	property string futureSaturdayFg: plasmoid.configuration.futureSaturdayFg
	onFutureSaturdayFgChanged: changed()
	property string futureSaturdayBg: plasmoid.configuration.futureSaturdayBg
	onFutureSaturdayBgChanged: changed()
	property string futureSaturdayBold: plasmoid.configuration.futureSaturdayBold
	onFutureSaturdayBoldChanged: changed()
	property bool futureSaturdayItalic: plasmoid.configuration.futureSaturdayItalic
	onFutureSaturdayItalicChanged: changed()

	property string futureSundayEnabled: plasmoid.configuration.futureSundayEnabled
	onFutureSundayEnabledChanged: changed()
	property string futureSundayFg: plasmoid.configuration.futureSundayFg
	onFutureSundayFgChanged: changed()
	property string futureSundayBg: plasmoid.configuration.futureSundayBg
	onFutureSundayBgChanged: changed()
	property string futureSundayBold: plasmoid.configuration.futureSundayBold
	onFutureSundayBoldChanged: changed()
	property bool futureSundayItalic: plasmoid.configuration.futureSundayItalic
	onFutureSundayItalicChanged: changed()

}

