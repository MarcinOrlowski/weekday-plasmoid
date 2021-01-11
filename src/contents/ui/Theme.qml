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

    // -----------------------------------------------------------------------

	// General theme attributes
	property string widgetBg: defaultBg

	// lastDayMonth
	property bool lastDayMonthEnabled: false
	property string lastDayMonthBg: defaultBg

	// Past days
	property string pastFg: defaultFg
	property string pastBg: defaultBg
	property bool	pastBold: false
	property bool	pastItalic: false

	property bool	pastSaturdayEnabled: false
	property string pastSaturdayFg: defaultFg
	property string pastSaturdayBg: defaultBg
	property bool	pastSaturdayBold: false
	property bool	pastSaturdayItalic: false

	property bool	pastSundayEnabled: false
	property string pastSundayFg: defaultFg
	property string pastSundayBg: defaultBg
	property bool	pastSundayBold: false
	property bool	pastSundayItalic: false

	// Current day
	property string todayFg: defaultFg
	property string todayBg: defaultBg
	property bool	todayBold: false
	property bool	todayItalic: false

	property bool	todaySaturdayEnabled: false
	property string todaySaturdayFg: defaultFg
	property string todaySaturdayBg: defaultBg
	property bool	todaySaturdayBold: false
	property bool	todaySaturdayItalic: false

	property bool	todaySundayEnabled: false
	property string todaySundayFg: defaultFg
	property string todaySundayBg: defaultBg
	property bool	todaySundayBold: false
	property bool	todaySundayItalic: false

	// Future days
	property string futureFg: defaultFg
	property string futureBg: defaultBg
	property bool	futureBold: false
	property bool	futureItalic: false

	property bool	futureSaturdayEnabled: false
	property string futureSaturdayFg: defaultFg
	property string futureSaturdayBg: defaultBg
	property bool	futureSaturdayBold: false
	property bool	futureSaturdayItalic: false

	property bool	futureSundayEnabled: false
	property string futureSundayFg: defaultFg
	property string futureSundayBg: defaultBg
	property bool	futureSundayBold: false
	property bool	futureSundayItalic: false

    // -----------------------------------------------------------------------

	function fromJson(obj) {

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
