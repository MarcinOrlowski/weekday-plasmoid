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
	property bool useCustomFont: plasmoid.configuration.useCustomFont
	onUseCustomFontChanged: emitChangedSignal()
	property font customFont: plasmoid.configuration.customFont
	onCustomFontChanged: emitChangedSignal()

	// Locale settings
	property bool useSpecificLocaleEnabled: plasmoid.configuration.useSpecificLocaleEnabled
	onUseSpecificLocaleEnabledChanged: emitChangedSignal()
	property string useSpecificLocaleLocaleName: plasmoid.configuration.useSpecificLocaleLocaleName
	onUseSpecificLocaleLocaleNameChanged: emitChangedSignal()
	property bool nonDefaultWeekStartDayEnabled: plasmoid.configuration.nonDefaultWeekStartDayEnabled
	onNonDefaultWeekStartDayEnabledChanged: emitChangedSignal()
	property int nonDefaultWeekStartDayDayIndex: plasmoid.configuration.nonDefaultWeekStartDayDayIndex
	onNonDefaultWeekStartDayDayIndexChanged: emitChangedSignal()

	// Custom labels
	property bool customDayLabelsEnabled: plasmoid.configuration.customDayLabelsEnabled
	onCustomDayLabelsEnabledChanged: emitChangedSignal()

	property bool customDayLabelMondayEnabled: plasmoid.configuration.customDayLabelMondayEnabled
	onCustomDayLabelMondayEnabledChanged: emitChangedSignal()
	property string customDayLabelMondayLabel: plasmoid.configuration.customDayLabelMondayLabel
	onCustomDayLabelMondayLabelChanged: emitChangedSignal()
	property bool customDayLabelTuesdayEnabled: plasmoid.configuration.customDayLabelTuesdayEnabled
	onCustomDayLabelTuesdayEnabledChanged: emitChangedSignal()
	property string customDayLabelTuesdayLabel: plasmoid.configuration.customDayLabelTuesdayLabel
	onCustomDayLabelTuesdayLabelChanged: emitChangedSignal()
	property bool customDayLabelWednesdayEnabled: plasmoid.configuration.customDayLabelWednesdayEnabled
	onCustomDayLabelWednesdayEnabledChanged: emitChangedSignal()
	property string customDayLabelWednesdayLabel: plasmoid.configuration.customDayLabelWednesdayLabel
	onCustomDayLabelWednesdayLabelChanged: emitChangedSignal()
	property bool customDayLabelThursdayEnabled: plasmoid.configuration.customDayLabelThursdayEnabled
	onCustomDayLabelThursdayEnabledChanged: emitChangedSignal()
	property string customDayLabelThursdayLabel: plasmoid.configuration.customDayLabelThursdayLabel
	onCustomDayLabelThursdayLabelChanged: emitChangedSignal()
	property bool customDayLabelFridayEnabled: plasmoid.configuration.customDayLabelFridayEnabled
	onCustomDayLabelFridayEnabledChanged: emitChangedSignal()
	property string customDayLabelFridayLabel: plasmoid.configuration.customDayLabelFridayLabel
	onCustomDayLabelFridayLabelChanged: emitChangedSignal()
	property bool customDayLabelSaturdayEnabled: plasmoid.configuration.customDayLabelSaturdayEnabled
	onCustomDayLabelSaturdayEnabledChanged: emitChangedSignal()
	property string customDayLabelSaturdayLabel: plasmoid.configuration.customDayLabelSaturdayLabel
	onCustomDayLabelSaturdayLabelChanged: emitChangedSignal()
	property bool customDayLabelSundayEnabled: plasmoid.configuration.customDayLabelSundayEnabled
	onCustomDayLabelSundayEnabledChanged: emitChangedSignal()
	property string customDayLabelSundayLabel: plasmoid.configuration.customDayLabelSundayLabel
	onCustomDayLabelSundayLabelChanged: emitChangedSignal()

	// ------------------------------------------------------------------------------------------------------------------------

	// Appearance theme
	property string themeName: plasmoid.configuration.themeName
	onThemeNameChanged: emitChangedSignal()
	property bool useUserTheme: plasmoid.configuration.useUserTheme
	onUseUserThemeChanged: emitChangedSignal()

	// ------------------------------------------------------------------------------------------------------------------------

	// User theme settings
	property string widgetBg: plasmoid.configuration.widgetBg
	onWidgetBgChanged: emitChangedSignal()

	property string lastDayMonthEnabled: plasmoid.configuration.lastDayMonthEnabled
	onLastDayMonthEnabledChanged: emitChangedSignal()
	property string lastDayMonthBg: plasmoid.configuration.lastDayMonthBg
	onLastDayMonthBgChanged: emitChangedSignal()

	property string pastFg: plasmoid.configuration.pastFg
	onPastFgChanged: emitChangedSignal()
	property string pastBg: plasmoid.configuration.pastBg
	onPastBgChanged: emitChangedSignal()
	property bool pastBold: plasmoid.configuration.pastBold
	onPastBoldChanged: emitChangedSignal()
	property bool pastItalic: plasmoid.configuration.pastItalic
	onPastItalicChanged: emitChangedSignal()

	property string pastSaturdayEnabled: plasmoid.configuration.pastSaturdayEnabled
	onPastSaturdayEnabledChanged: emitChangedSignal()
	property string pastSaturdayFg: plasmoid.configuration.pastSaturdayFg
	onPastSaturdayFgChanged: emitChangedSignal()
	property string pastSaturdayBg: plasmoid.configuration.pastSaturdayBg
	onPastSaturdayBgChanged: emitChangedSignal()
	property bool pastSaturdayBold: plasmoid.configuration.pastSaturdayBold
	onPastSaturdayBoldChanged: emitChangedSignal()
	property bool pastSaturdayItalic: plasmoid.configuration.pastSaturdayItalic
	onPastSaturdayItalicChanged: emitChangedSignal()

	property string pastSundayEnabled: plasmoid.configuration.pastSundayEnabled
	onPastSundayEnabledChanged: emitChangedSignal()
	property string pastSundayFg: plasmoid.configuration.pastSundayFg
	onPastSundayFgChanged: emitChangedSignal()
	property string pastSundayBg: plasmoid.configuration.pastSundayBg
	onPastSundayBgChanged: emitChangedSignal()
	property bool pastSundayBold: plasmoid.configuration.pastSundayBold
	onPastSundayBoldChanged: emitChangedSignal()
	property bool pastSundayItalic: plasmoid.configuration.pastSundayItalic
	onPastSundayItalicChanged: emitChangedSignal()

	property string todayFg: plasmoid.configuration.todayFg
	onTodayFgChanged: emitChangedSignal()
	property string todayBg: plasmoid.configuration.todayBg
	onTodayBgChanged: emitChangedSignal()
	property bool todayBold: plasmoid.configuration.todayBold
	onTodayBoldChanged: emitChangedSignal()
	property bool todayItalic: plasmoid.configuration.todayItalic
	onTodayItalicChanged: emitChangedSignal()

	property string todaySaturdayEnabled: plasmoid.configuration.todaySaturdayEnabled
	onTodaySaturdayEnabledChanged: emitChangedSignal()
	property string todaySaturdayFg: plasmoid.configuration.todaySaturdayFg
	onTodaySaturdayFgChanged: emitChangedSignal()
	property string todaySaturdayBg: plasmoid.configuration.todaySaturdayBg
	onTodaySaturdayBgChanged: emitChangedSignal()
	property bool todaySaturdayBold: plasmoid.configuration.todaySaturdayBold
	onTodaySaturdayBoldChanged: emitChangedSignal()
	property bool todaySaturdayItalic: plasmoid.configuration.todaySaturdayItalic
	onTodaySaturdayItalicChanged: emitChangedSignal()

	property string todaySundayEnabled: plasmoid.configuration.todaySundayEnabled
	onTodaySundayEnabledChanged: emitChangedSignal()
	property string todaySundayFg: plasmoid.configuration.todaySundayFg
	onTodaySundayFgChanged: emitChangedSignal()
	property string todaySundayBg: plasmoid.configuration.todaySundayBg
	onTodaySundayBgChanged: emitChangedSignal()
	property bool todaySundayBold: plasmoid.configuration.todaySundayBold
	onTodaySundayBoldChanged: emitChangedSignal()
	property bool todaySundayItalic: plasmoid.configuration.todaySundayItalic
	onTodaySundayItalicChanged: emitChangedSignal()

	property string futureFg: plasmoid.configuration.futureFg
	onFutureFgChanged: emitChangedSignal()
	property string futureBg: plasmoid.configuration.futureBg
	onFutureBgChanged: emitChangedSignal()
	property bool futureBold: plasmoid.configuration.futureBold
	onFutureBoldChanged: emitChangedSignal()
	property bool futureItalic: plasmoid.configuration.futureItalic
	onFutureItalicChanged: emitChangedSignal()

	property string futureSaturdayEnabled: plasmoid.configuration.futureSaturdayEnabled
	onFutureSaturdayEnabledChanged: emitChangedSignal()
	property string futureSaturdayFg: plasmoid.configuration.futureSaturdayFg
	onFutureSaturdayFgChanged: emitChangedSignal()
	property string futureSaturdayBg: plasmoid.configuration.futureSaturdayBg
	onFutureSaturdayBgChanged: emitChangedSignal()
	property string futureSaturdayBold: plasmoid.configuration.futureSaturdayBold
	onFutureSaturdayBoldChanged: emitChangedSignal()
	property bool futureSaturdayItalic: plasmoid.configuration.futureSaturdayItalic
	onFutureSaturdayItalicChanged: emitChangedSignal()

	property string futureSundayEnabled: plasmoid.configuration.futureSundayEnabled
	onFutureSundayEnabledChanged: emitChangedSignal()
	property string futureSundayFg: plasmoid.configuration.futureSundayFg
	onFutureSundayFgChanged: emitChangedSignal()
	property string futureSundayBg: plasmoid.configuration.futureSundayBg
	onFutureSundayBgChanged: emitChangedSignal()
	property string futureSundayBold: plasmoid.configuration.futureSundayBold
	onFutureSundayBoldChanged: emitChangedSignal()
	property bool futureSundayItalic: plasmoid.configuration.futureSundayItalic
	onFutureSundayItalicChanged: emitChangedSignal()

	// Fake parameters
	property bool useFakeParameters: plasmoid.configuration.useFakeParameters
	onUseFakeParametersChanged: emitChangedSignal()
	property int fakeToday: plasmoid.configuration.fakeToday
	onFakeTodayChanged: emitChangedSignal()
	property int fakeLastDayMonth: plasmoid.configuration.fakeLastDayMonth
	onFakeLastDayMonthChanged: emitChangedSignal()
	property int fakeWeekStartDay: plasmoid.configuration.fakeWeekStartDay
	onFakeWeekStartDayChanged: emitChangedSignal()

}
