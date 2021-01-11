/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0

Item {
	readonly property string defaultBg: '#00000000'
	readonly property string defaultFg: '#FF000000'
	readonly property bool defaultBold: false
	readonly property bool defaultItalic: false

	// -----------------------------------------------------------------------

	// General theme attributes
	property string widgetBg: defaultBg

	// lastDayMonth
	property bool	lastDayMonthEnabled: false
	property string lastDayMonthBg: defaultBg

	// Past days
	property string pastFg: defaultFg
	property string pastBg: defaultBg
	property bool	pastBold: defaultBold
	property bool	pastItalic: defaultItalic

	property bool	pastSaturdayEnabled: false
	property string pastSaturdayFg: defaultFg
	property string pastSaturdayBg: defaultBg
	property bool	pastSaturdayBold: defaultBold
	property bool	pastSaturdayItalic: defaultItalic

	property bool	pastSundayEnabled: false
	property string pastSundayFg: defaultFg
	property string pastSundayBg: defaultBg
	property bool	pastSundayBold: defaultBold
	property bool	pastSundayItalic: defaultItalic

	// Current day
	property string todayFg: defaultFg
	property string todayBg: defaultBg
	property bool	todayBold: defaultBold
	property bool	todayItalic: defaultItalic

	property bool	todaySaturdayEnabled: false
	property string todaySaturdayFg: defaultFg
	property string todaySaturdayBg: defaultBg
	property bool	todaySaturdayBold: defaultBold
	property bool	todaySaturdayItalic: defaultItalic

	property bool	todaySundayEnabled: false
	property string todaySundayFg: defaultFg
	property string todaySundayBg: defaultBg
	property bool	todaySundayBold: defaultBold
	property bool	todaySundayItalic: defaultItalic

	// Future days
	property string futureFg: defaultFg
	property string futureBg: defaultBg
	property bool	futureBold: defaultBold
	property bool	futureItalic: defaultItalic

	property bool	futureSaturdayEnabled: false
	property string futureSaturdayFg: defaultFg
	property string futureSaturdayBg: defaultBg
	property bool	futureSaturdayBold: defaultBold
	property bool	futureSaturdayItalic: defaultItalic

	property bool	futureSundayEnabled: false
	property string futureSundayFg: defaultFg
	property string futureSundayBg: defaultBg
	property bool	futureSundayBold: defaultBold
	property bool	futureSundayItalic: defaultItalic

	// -----------------------------------------------------------------------

	function fromJson(j) {
		widgetBg = j.widget.bg || defaultBg

		lastDayMonthEnabled = j.lastDayMonth.enabled || false
		lastDayMonthBg = j.lastDayMonth.bg || defaultBg

		pastFg = j.past.fg || defaultFg
		pastBg = j.past.bg || defaultBg
		pastBold = j.past.bold || defaultBold
		pastItalic = j.past.italic || defaultItalic

		pastSaturdayEnabled = j.pastSaturdayEnabled || false
		pastSaturdayFg = j.pastSaturday.fg || defaultFg
		pastSaturdayBg = j.pastSaturday.bg || defaultBg
		pastSaturdayBold = j.pastSaturday.bold || defaultBold
		pastSaturdayItalic = j.pastSaturday.italic || defaultItalic

		pastSundayEnabled = j.pastSundayEnabled || false
		pastSundayFg = j.pastSunday.fg || defaultFg
		pastSundayBg = j.pastSunday.bg || defaultBg
		pastSundayBold = j.pastSunday.bold || defaultBold
		pastSundayItalic = j.pastSunday.italic || defaultItalic

		futureFg = j.future.fg || defaultFg
		futureBg = j.future.bg || defaultBg
		futureBold = j.future.bold || defaultBold
		futureItalic = j.future.italic || defaultItalic

		futureSaturdayEnabled = j.futureSaturdayEnabled || false
		futureSaturdayFg = j.futureSaturday.fg || defaultFg
		futureSaturdayBg = j.futureSaturday.bg || defaultBg
		futureSaturdayBold = j.futureSaturday.bold || defaultBold
		futureSaturdayItalic = j.futureSaturday.italic || defaultItalic

		futureSundayEnabled = j.futureSundayEnabled || false
		futureSundayFg = j.futureSunday.fg || defaultFg
		futureSundayBg = j.futureSunday.bg || defaultBg
		futureSundayBold = j.futureSunday.bold || defaultBold
		futureSundayItalic = j.futureSunday.italic || defaultItalic
	}

	// -----------------------------------------------------------------------

	function toJson() {
		return {
			'widget': {
				'bg': widgetBg
			},

			'lastDayMonth': {
				'enabled': lastDayMonthEnabled,
				'bg': lastDayMonthBg,
			},

			'past': {
				'fg': pastFg,
				'bg': pastBg,
				'bold': pastBold,
				'italic': pastItalic,
			},
			'pastSaturday': {
				'enabled': pastSaturdayEnabled,
				'fg': pastSaturdayFg,
				'bg': pastSaturdayBg,
				'bold': pastSaturdayBold,
				'italic': pastSaturdayItalic,
			},
			'pastSunday': {
				'enabled': pastSundayEnabled,
				'fg': pastSundayFg,
				'bg': pastSundayBg,
				'bold': pastSundayBold,
				'italic': pastSundayItalic,
			},

			'today': {
				'fg': todayFg,
				'bg': todayBg,
				'bold': todayBold,
				'italic': todayItalic,
			},
			'todaySaturday': {
				'enabled': todaySaturdayEnabled,
				'fg': todaySaturdayFg,
				'bg': todaySaturdayBg,
				'bold': todaySaturdayBold,
				'italic': todaySaturdayItalic,
			},
			'todaySunday': {
				'enabled': todaySundayEnabled,
				'fg': todaySundayFg,
				'bg': todaySundayBg,
				'bold': todaySundayBold,
				'italic': todaySundayItalic,
			},

			'future': {
				'fg': futureFg,
				'bg': futureBg,
				'bold': futureBold,
				'italic': futureItalic,
			},
			'futureSaturday': {
				'enabled': futureSaturdayEnabled,
				'fg': futureSaturdayFg,
				'bg': futureSaturdayBg,
				'bold': futureSaturdayBold,
				'italic': futureSaturdayItalic,
			},
			'futureSunday': {
				'enabled': futureSundayEnabled,
				'fg': futureSundayFg,
				'bg': futureSundayBg,
				'bold': futureSundayBold,
				'italic': futureSundayItalic,
			}
		}
	}

	// -----------------------------------------------------------------------
}
