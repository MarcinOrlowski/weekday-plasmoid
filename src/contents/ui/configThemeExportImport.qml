/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "../js/themes.js" as Themes

ColumnLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true

	// -----------------------------------------------------------------------

	Theme {
		id: theme
	}

	// -----------------------------------------------------------------------

	property alias cfg_widgetBg: theme.widgetBg

	property alias cfg_lastDayMonthEnabled: theme.lastDayMonthEnabled
	property alias cfg_lastDayMonthBg: theme.lastDayMonthBg

	// past
	property alias cfg_pastFg: theme.pastFg
	property alias cfg_pastBg: theme.pastBg
	property alias cfg_pastBold: theme.pastBold
	property alias cfg_pastItalic: theme.pastItalic

	property alias cfg_pastSaturdayEnabled: theme.pastSaturdayEnabled
	property alias cfg_pastSaturdayFg: theme.pastSaturdayFg
	property alias cfg_pastSaturdayBg: theme.pastSaturdayBg
	property alias cfg_pastSaturdayBold: theme.pastSaturdayBold
	property alias cfg_pastSaturdayItalic: theme.pastSaturdayItalic

	property alias cfg_pastSundayEnabled: theme.pastSundayEnabled
	property alias cfg_pastSundayFg: theme.pastSundayFg
	property alias cfg_pastSundayBg: theme.pastSundayBg
	property alias cfg_pastSundayBold: theme.pastSundayBold
	property alias cfg_pastSundayItalic: theme.pastSundayItalic

	// today
	property alias cfg_todayFg: theme.todayFg
	property alias cfg_todayBg: theme.todayBg
	property alias cfg_todayBold: theme.todayBold
	property alias cfg_todayItalic: theme.todayItalic

	property alias cfg_todaySaturdayEnabled: theme.todaySaturdayEnabled
	property alias cfg_todaySaturdayFg: theme.todaySaturdayFg
	property alias cfg_todaySaturdayBg: theme.todaySaturdayBg
	property alias cfg_todaySaturdayBold: theme.todaySaturdayBold
	property alias cfg_todaySaturdayItalic: theme.todaySaturdayItalic

	property alias cfg_todaySundayEnabled: theme.todaySundayEnabled
	property alias cfg_todaySundayFg: theme.todaySundayFg
	property alias cfg_todaySundayBg: theme.todaySundayBg
	property alias cfg_todaySundayBold: theme.todaySundayBold
	property alias cfg_todaySundayItalic: theme.todaySundayItalic

	// future
	property alias cfg_futureFg: theme.futureFg
	property alias cfg_futureBg: theme.futureBg
	property alias cfg_futureBold: theme.futureBold
	property alias cfg_futureItalic: theme.futureItalic

	property alias cfg_futureSaturdayEnabled: theme.futureSaturdayEnabled
	property alias cfg_futureSaturdayFg: theme.futureSaturdayFg
	property alias cfg_futureSaturdayBg: theme.futureSaturdayBg
	property alias cfg_futureSaturdayBold: theme.futureSaturdayBold
	property alias cfg_futureSaturdayItalic: theme.futureSaturdayItalic

	property alias cfg_futureSundayEnabled: theme.futureSundayEnabled
	property alias cfg_futureSundayFg: theme.futureSundayFg
	property alias cfg_futureSundayBg: theme.futureSundayBg
	property alias cfg_futureSundayBold: theme.futureSundayBold
	property alias cfg_futureSundayItalic: theme.futureSundayItalic

	// -----------------------------------------------------------------------

	/*
	** Imports theme from JSON object to cfg_* properties.
	*/ 
	function fromJson(j) {
		var result = false

		cfg_widgetBg = j.widget.bg || theme.defaultBg

		cfg_lastDayMonthEnabled = j.lastDayMonth.enabled || false
		cfg_lastDayMonthBg = j.lastDayMonth.bg || theme.defaultBg

		cfg_pastFg = j.past.fg || theme.defaultFg
		cfg_pastBg = j.past.bg || theme.defaultBg
		cfg_pastBold = j.past.bold || theme.defaultBold
		cfg_pastItalic = j.past.italic || theme.defaultItalic

		cfg_pastSaturdayEnabled = j.pastSaturdayEnabled || false
		cfg_pastSaturdayFg = j.pastSaturday.fg || theme.defaultFg
		cfg_pastSaturdayBg = j.pastSaturday.bg || theme.defaultBg
		cfg_pastSaturdayBold = j.pastSaturday.bold || theme.defaultBold
		cfg_pastSaturdayItalic = j.pastSaturday.italic || theme.defaultItalic

		cfg_pastSundayEnabled = j.pastSundayEnabled || false
		cfg_pastSundayFg = j.pastSunday.fg || theme.defaultFg
		cfg_pastSundayBg = j.pastSunday.bg || theme.defaultBg
		cfg_pastSundayBold = j.pastSunday.bold || theme.defaultBold
		cfg_pastSundayItalic = j.pastSunday.italic || theme.defaultItalic

		cfg_futureFg = j.future.fg || theme.defaultFg
		cfg_futureBg = j.future.bg || theme.defaultBg
		cfg_futureBold = j.future.bold || theme.defaultBold
		cfg_futureItalic = j.future.italic || theme.defaultItalic

		cfg_futureSaturdayEnabled = j.futureSaturdayEnabled || false
		cfg_futureSaturdayFg = j.futureSaturday.fg || theme.defaultFg
		cfg_futureSaturdayBg = j.futureSaturday.bg || theme.defaultBg
		cfg_futureSaturdayBold = j.futureSaturday.bold || theme.defaultBold
		cfg_futureSaturdayItalic = j.futureSaturday.italic || theme.defaultItalic

		cfg_futureSundayEnabled = j.futureSundayEnabled || false
		cfg_futureSundayFg = j.futureSunday.fg || theme.defaultFg
		cfg_futureSundayBg = j.futureSunday.bg || theme.defaultBg
		cfg_futureSundayBold = j.futureSunday.bold || theme.defaultBold
		cfg_futureSundayItalic = j.futureSunday.italic || theme.defaultItalic
	}

	// -----------------------------------------------------------------------

	FakeCalendarModeWarning {}

	Kirigami.InlineMessage {
		id: infoMessageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Information
		text: i18n('OK')
		showCloseButton: true
		visible: false
	}

	Kirigami.InlineMessage {
		id: errorMessageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Error
		text: i18n('Error occured.')
		showCloseButton: true
		visible: false
	}

	QtControls.TextArea {
		id: textInput
		Layout.fillWidth: true
		Layout.fillHeight: true
		selectByMouse: true
	}

	RowLayout {
		QtControls.Button {
			text: i18n('Export to JSON')
			icon.name: 'document-export'
			onClicked: textInput.text = JSON.stringify(theme.toJson(exportEnabledElementsOnly.checked))
		}

		QtControls.Button {
			text: i18n('Import from JSON')
			icon.name: 'document-import'
			onClicked: {
				try {
					var json = JSON.parse(textInput.text)
					fromJson(json)
					infoMessageWidget.text = i18n('User theme imported successfuly.')
					infoMessageWidget.visible = true
				} catch (error) {
					errorMessageWidget.text = i18n('Failed to process theme JSON.')
					errorMessageWidget.visible = true

					console.debug(error)
				}
			}
		}
	} // RowLayout

	RowLayout {
		PlasmaComponents.CheckBox {
			id: exportEnabledElementsOnly
			text: i18n("Export enabled elements only")
		}
	} // RowLayout

	Item {
		Layout.fillWidth: true
		Layout.fillHeight: true
	}

} // ColumnLayout
