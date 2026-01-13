/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2023 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid

// Hope there a smarter way to know when settings are changed
// and I just missed it so far...
Item {
	// Emited when monitored settings' properties changed.
	signal changed()

	// ------------------------------------------------------------------------------------------------------------------------

	// Once settings are applied, there'll be burst of changed() signals emited (for each settings property monitored).
	// I do not need that storm. One approach would be to emit changed() on first emitChangedSignal() and then ignore all
	// subsequent calls for some time, but that's could trigger premature reaction (i.e. UI update). So I do opposite here.
	// Each emitChangedSignal() call queuest and postpones emit attempt, but the signal will be emited only if last emit
	// attempt was at least silenceThresholdMillis ago. Any emitSignal() call within that threshold will restart the counter.
	readonly property int silenceThresholdMillis: 250

	function emitChangedSignal() {
		signalEmiter.restart()
	}

	Timer {
		id: signalEmiter
		interval: silenceThresholdMillis
		repeat: false
		running: false
		triggeredOnStart: false
		onTriggered: changed()
	}

	// ------------------------------------------------------------------------------------------------------------------------

	// fonts
	property bool useCustomFont: Plasmoid.configuration.useCustomFont
	onUseCustomFontChanged: emitChangedSignal()
	property font customFont: Plasmoid.configuration.customFont
	onCustomFontChanged: emitChangedSignal()

	// Locale settings
	property bool useSpecificLocaleEnabled: Plasmoid.configuration.useSpecificLocaleEnabled
	onUseSpecificLocaleEnabledChanged: emitChangedSignal()
	property string useSpecificLocaleLocaleName: Plasmoid.configuration.useSpecificLocaleLocaleName
	onUseSpecificLocaleLocaleNameChanged: emitChangedSignal()
	property bool nonDefaultWeekStartDayEnabled: Plasmoid.configuration.nonDefaultWeekStartDayEnabled
	onNonDefaultWeekStartDayEnabledChanged: emitChangedSignal()
	property int nonDefaultWeekStartDayDayIndex: Plasmoid.configuration.nonDefaultWeekStartDayDayIndex
	onNonDefaultWeekStartDayDayIndexChanged: emitChangedSignal()

	// Custom labels
	property bool customDayLabelsEnabled: Plasmoid.configuration.customDayLabelsEnabled
	onCustomDayLabelsEnabledChanged: emitChangedSignal()

	property bool customDayLabelMondayEnabled: Plasmoid.configuration.customDayLabelMondayEnabled
	onCustomDayLabelMondayEnabledChanged: emitChangedSignal()
	property string customDayLabelMondayLabel: Plasmoid.configuration.customDayLabelMondayLabel
	onCustomDayLabelMondayLabelChanged: emitChangedSignal()
	property bool customDayLabelTuesdayEnabled: Plasmoid.configuration.customDayLabelTuesdayEnabled
	onCustomDayLabelTuesdayEnabledChanged: emitChangedSignal()
	property string customDayLabelTuesdayLabel: Plasmoid.configuration.customDayLabelTuesdayLabel
	onCustomDayLabelTuesdayLabelChanged: emitChangedSignal()
	property bool customDayLabelWednesdayEnabled: Plasmoid.configuration.customDayLabelWednesdayEnabled
	onCustomDayLabelWednesdayEnabledChanged: emitChangedSignal()
	property string customDayLabelWednesdayLabel: Plasmoid.configuration.customDayLabelWednesdayLabel
	onCustomDayLabelWednesdayLabelChanged: emitChangedSignal()
	property bool customDayLabelThursdayEnabled: Plasmoid.configuration.customDayLabelThursdayEnabled
	onCustomDayLabelThursdayEnabledChanged: emitChangedSignal()
	property string customDayLabelThursdayLabel: Plasmoid.configuration.customDayLabelThursdayLabel
	onCustomDayLabelThursdayLabelChanged: emitChangedSignal()
	property bool customDayLabelFridayEnabled: Plasmoid.configuration.customDayLabelFridayEnabled
	onCustomDayLabelFridayEnabledChanged: emitChangedSignal()
	property string customDayLabelFridayLabel: Plasmoid.configuration.customDayLabelFridayLabel
	onCustomDayLabelFridayLabelChanged: emitChangedSignal()
	property bool customDayLabelSaturdayEnabled: Plasmoid.configuration.customDayLabelSaturdayEnabled
	onCustomDayLabelSaturdayEnabledChanged: emitChangedSignal()
	property string customDayLabelSaturdayLabel: Plasmoid.configuration.customDayLabelSaturdayLabel
	onCustomDayLabelSaturdayLabelChanged: emitChangedSignal()
	property bool customDayLabelSundayEnabled: Plasmoid.configuration.customDayLabelSundayEnabled
	onCustomDayLabelSundayEnabledChanged: emitChangedSignal()
	property string customDayLabelSundayLabel: Plasmoid.configuration.customDayLabelSundayLabel
	onCustomDayLabelSundayLabelChanged: emitChangedSignal()

	// ------------------------------------------------------------------------------------------------------------------------

	// Appearance theme
	property string themeName: Plasmoid.configuration.themeName
	onThemeNameChanged: emitChangedSignal()
	property bool useUserTheme: Plasmoid.configuration.useUserTheme
	onUseUserThemeChanged: emitChangedSignal()

	// ------------------------------------------------------------------------------------------------------------------------

	// User theme settings
	property string widgetBg: Plasmoid.configuration.widgetBg
	onWidgetBgChanged: emitChangedSignal()

	property string lastDayMonthEnabled: Plasmoid.configuration.lastDayMonthEnabled
	onLastDayMonthEnabledChanged: emitChangedSignal()
	property string lastDayMonthBg: Plasmoid.configuration.lastDayMonthBg
	onLastDayMonthBgChanged: emitChangedSignal()

	property string pastFg: Plasmoid.configuration.pastFg
	onPastFgChanged: emitChangedSignal()
	property string pastBg: Plasmoid.configuration.pastBg
	onPastBgChanged: emitChangedSignal()
	property bool pastBold: Plasmoid.configuration.pastBold
	onPastBoldChanged: emitChangedSignal()
	property bool pastItalic: Plasmoid.configuration.pastItalic
	onPastItalicChanged: emitChangedSignal()

	property string pastSaturdayEnabled: Plasmoid.configuration.pastSaturdayEnabled
	onPastSaturdayEnabledChanged: emitChangedSignal()
	property string pastSaturdayFg: Plasmoid.configuration.pastSaturdayFg
	onPastSaturdayFgChanged: emitChangedSignal()
	property string pastSaturdayBg: Plasmoid.configuration.pastSaturdayBg
	onPastSaturdayBgChanged: emitChangedSignal()
	property bool pastSaturdayBold: Plasmoid.configuration.pastSaturdayBold
	onPastSaturdayBoldChanged: emitChangedSignal()
	property bool pastSaturdayItalic: Plasmoid.configuration.pastSaturdayItalic
	onPastSaturdayItalicChanged: emitChangedSignal()

	property string pastSundayEnabled: Plasmoid.configuration.pastSundayEnabled
	onPastSundayEnabledChanged: emitChangedSignal()
	property string pastSundayFg: Plasmoid.configuration.pastSundayFg
	onPastSundayFgChanged: emitChangedSignal()
	property string pastSundayBg: Plasmoid.configuration.pastSundayBg
	onPastSundayBgChanged: emitChangedSignal()
	property bool pastSundayBold: Plasmoid.configuration.pastSundayBold
	onPastSundayBoldChanged: emitChangedSignal()
	property bool pastSundayItalic: Plasmoid.configuration.pastSundayItalic
	onPastSundayItalicChanged: emitChangedSignal()

	property string todayFg: Plasmoid.configuration.todayFg
	onTodayFgChanged: emitChangedSignal()
	property string todayBg: Plasmoid.configuration.todayBg
	onTodayBgChanged: emitChangedSignal()
	property bool todayBold: Plasmoid.configuration.todayBold
	onTodayBoldChanged: emitChangedSignal()
	property bool todayItalic: Plasmoid.configuration.todayItalic
	onTodayItalicChanged: emitChangedSignal()

	property string todaySaturdayEnabled: Plasmoid.configuration.todaySaturdayEnabled
	onTodaySaturdayEnabledChanged: emitChangedSignal()
	property string todaySaturdayFg: Plasmoid.configuration.todaySaturdayFg
	onTodaySaturdayFgChanged: emitChangedSignal()
	property string todaySaturdayBg: Plasmoid.configuration.todaySaturdayBg
	onTodaySaturdayBgChanged: emitChangedSignal()
	property bool todaySaturdayBold: Plasmoid.configuration.todaySaturdayBold
	onTodaySaturdayBoldChanged: emitChangedSignal()
	property bool todaySaturdayItalic: Plasmoid.configuration.todaySaturdayItalic
	onTodaySaturdayItalicChanged: emitChangedSignal()

	property string todaySundayEnabled: Plasmoid.configuration.todaySundayEnabled
	onTodaySundayEnabledChanged: emitChangedSignal()
	property string todaySundayFg: Plasmoid.configuration.todaySundayFg
	onTodaySundayFgChanged: emitChangedSignal()
	property string todaySundayBg: Plasmoid.configuration.todaySundayBg
	onTodaySundayBgChanged: emitChangedSignal()
	property bool todaySundayBold: Plasmoid.configuration.todaySundayBold
	onTodaySundayBoldChanged: emitChangedSignal()
	property bool todaySundayItalic: Plasmoid.configuration.todaySundayItalic
	onTodaySundayItalicChanged: emitChangedSignal()

	property string futureFg: Plasmoid.configuration.futureFg
	onFutureFgChanged: emitChangedSignal()
	property string futureBg: Plasmoid.configuration.futureBg
	onFutureBgChanged: emitChangedSignal()
	property bool futureBold: Plasmoid.configuration.futureBold
	onFutureBoldChanged: emitChangedSignal()
	property bool futureItalic: Plasmoid.configuration.futureItalic
	onFutureItalicChanged: emitChangedSignal()

	property string futureSaturdayEnabled: Plasmoid.configuration.futureSaturdayEnabled
	onFutureSaturdayEnabledChanged: emitChangedSignal()
	property string futureSaturdayFg: Plasmoid.configuration.futureSaturdayFg
	onFutureSaturdayFgChanged: emitChangedSignal()
	property string futureSaturdayBg: Plasmoid.configuration.futureSaturdayBg
	onFutureSaturdayBgChanged: emitChangedSignal()
	property string futureSaturdayBold: Plasmoid.configuration.futureSaturdayBold
	onFutureSaturdayBoldChanged: emitChangedSignal()
	property bool futureSaturdayItalic: Plasmoid.configuration.futureSaturdayItalic
	onFutureSaturdayItalicChanged: emitChangedSignal()

	property string futureSundayEnabled: Plasmoid.configuration.futureSundayEnabled
	onFutureSundayEnabledChanged: emitChangedSignal()
	property string futureSundayFg: Plasmoid.configuration.futureSundayFg
	onFutureSundayFgChanged: emitChangedSignal()
	property string futureSundayBg: Plasmoid.configuration.futureSundayBg
	onFutureSundayBgChanged: emitChangedSignal()
	property string futureSundayBold: Plasmoid.configuration.futureSundayBold
	onFutureSundayBoldChanged: emitChangedSignal()
	property bool futureSundayItalic: Plasmoid.configuration.futureSundayItalic
	onFutureSundayItalicChanged: emitChangedSignal()

	// Fake parameters
	property bool useFakeParameters: Plasmoid.configuration.useFakeParameters
	onUseFakeParametersChanged: emitChangedSignal()
	property int fakeToday: Plasmoid.configuration.fakeToday
	onFakeTodayChanged: emitChangedSignal()
	property int fakeLastDayMonth: Plasmoid.configuration.fakeLastDayMonth
	onFakeLastDayMonthChanged: emitChangedSignal()
	property int fakeWeekStartDay: Plasmoid.configuration.fakeWeekStartDay
	onFakeWeekStartDayChanged: emitChangedSignal()

}
