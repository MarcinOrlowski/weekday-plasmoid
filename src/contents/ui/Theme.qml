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

	// Appends objToAdd if addConditionally is false, otherwise checks value
	// of boolean node 'enabled' of first key in objToAdd and adds objToAdd
	// only if 'enabled' is true. objToAdd is expected to be just single
	// node object (single theme config item).
	function addIf(targetJson, addConditionally, objToAdd) {
		var result = targetJson
		var keys = Object.keys(objToAdd)
		var key = keys[0]
		if (addConditionally) {
			if (objToAdd[key]['enabled']) {
				result[key] = objToAdd[key]
			}
		} else {
			result[key] = objToAdd[key]
		}
		return result
	}

	// -----------------------------------------------------------------------

	function toJson(exportEnabledElementsOnly) {
		var json = {
			'widget': {
				'bg': widgetBg
			}
		}


		json = addIf(json, exportEnabledElementsOnly, {
			'lastDayMonth': {
				'enabled': lastDayMonthEnabled,
				'bg': lastDayMonthBg,
			}
		})

		json['past'] = {
			'fg': pastFg,
			'bg': pastBg,
			'bold': pastBold,
			'italic': pastItalic,
		}

		json = addIf(json, exportEnabledElementsOnly, {
			'pastSaturday': {
				'enabled': pastSaturdayEnabled,
				'fg': pastSaturdayFg,
				'bg': pastSaturdayBg,
				'bold': pastSaturdayBold,
				'italic': pastSaturdayItalic,
			}
		})
		json = addIf(json, exportEnabledElementsOnly, {
			'pastSunday': {
				'enabled': pastSundayEnabled,
				'fg': pastSundayFg,
				'bg': pastSundayBg,
				'bold': pastSundayBold,
				'italic': pastSundayItalic,
			}
		})
	
		json['today'] = {
			'fg': todayFg,
			'bg': todayBg,
			'bold': todayBold,
			'italic': todayItalic,
		}

		json = addIf(json, exportEnabledElementsOnly, {
			'todaySaturday': {
				'enabled': todaySaturdayEnabled,
				'fg': todaySaturdayFg,
				'bg': todaySaturdayBg,
				'bold': todaySaturdayBold,
				'italic': todaySaturdayItalic,
			}
		})
		json = addIf(json, exportEnabledElementsOnly, {
			'todaySunday': {
				'enabled': todaySundayEnabled,
				'fg': todaySundayFg,
				'bg': todaySundayBg,
				'bold': todaySundayBold,
				'italic': todaySundayItalic,
			}
		})

		json['future'] = {
			'fg': futureFg,
			'bg': futureBg,
			'bold': futureBold,
			'italic': futureItalic,
		}

		json = addIf(json, exportEnabledElementsOnly, {
			'futureSaturday': {
				'enabled': futureSaturdayEnabled,
				'fg': futureSaturdayFg,
				'bg': futureSaturdayBg,
				'bold': futureSaturdayBold,
				'italic': futureSaturdayItalic,
			}
		})
		json = addIf(json, exportEnabledElementsOnly, {
			'futureSunday': {
				'enabled': futureSundayEnabled,
				'fg': futureSundayFg,
				'bg': futureSundayBg,
				'bold': futureSundayBold,
				'italic': futureSundayItalic,
			}
		})

		return json
	}

	// -----------------------------------------------------------------------
}
