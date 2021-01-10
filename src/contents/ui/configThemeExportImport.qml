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
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQControls
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

	readonly property bool customColorsEnabled: plasmoid.configuration.themeName === Themes.custom

	// -----------------------------------------------------------------------

	Kirigami.InlineMessage {
		id: messageWidget
		Layout.fillWidth: true
		Layout.margins: Kirigami.Units.smallSpacing
		type: Kirigami.MessageType.Notice
		text: i18n('Custom colors must be enabled for this feature to work.')
		showCloseButton: false
		visible: !customColorsEnabled
	}

	QtControls.TextArea {
		id: textInput
		Layout.fillWidth: true
		Layout.fillHeight: true
		enabled: customColorsEnabled
		selectByMouse: true

		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.RightButton
			hoverEnabled: true
   			onClicked: {
        	    var selectStart = textInput.selectionStart;
            	var selectEnd = textInput.selectionEnd;
	            var curPos = textInput.cursorPosition;
	            contextMenu.x = mouse.x;
	            contextMenu.y = mouse.y;
	            contextMenu.open();
    	        textInput.cursorPosition = curPos;
	            textInput.select(selectStart,selectEnd);
	        }
	        onPressAndHold: {
    	        if (mouse.source === Qt.MouseEventNotSynthesized) {
        	        var selectStart = textInput.selectionStart;
            	    var selectEnd = textInput.selectionEnd;
	                var curPos = textInput.cursorPosition;
    	            contextMenu.x = mouse.x;
        	        contextMenu.y = mouse.y;
            	    contextMenu.open();
	                textInput.cursorPosition = curPos;
    	            textInput.select(selectStart,selectEnd);
        	    }
	        }

    	    QtControls.Menu {
        	    id: contextMenu
            	QtControls.MenuItem {
		            text: i18n("Cut")
        	        onTriggered: textInput.cut()
	            }
    	        QtControls.MenuItem {
        	        text: i18n("Copy")
	                onTriggered: textInput.copy()
    	        }
        	    QtControls.MenuItem {
            	    text: i18n("Paste")
	                onTriggered: textInput.paste()
    	        }
	        }
    	}
	}

	RowLayout {
		enabled: customColorsEnabled

		QtControls.Button {
			text: i18n('Export')
			icon.name: 'document-export'
			onClicked: textInput.text = JSON.stringify(theme.toJson())
		}

		QtControls.Button {
			text: i18n('Import')
			icon.name: 'document-import'
			onClicked: {
				try {
					var json = JSON.parse(textInput.text)

console.debug(JSON.stringify(json))

/*
					plasmoid.configuration.customColorsWidgetBg = json['widget']['bg']

					plasmoid.configuration.customColorsPastFg = json['past']['fg']
					plasmoid.configuration.customColorsPastBg = json['past']['bg']
					plasmoid.configuration.customColorsPastBold = json['past']['bold']
					plasmoid.configuration.customColorsPastItalic = json['past']['italic']

					plasmoid.configuration.customColorsPastSaturdayEnabled = json['pastSaturday']['enabled']
					plasmoid.configuration.customColorsPastSaturdayFg = json['pastSaturday']['fg']
					plasmoid.configuration.customColorsPastSaturdayBg = json['pastSaturday']['bg']
					plasmoid.configuration.customColorsPastSaturdayBold = json['pastSaturday']['bold']
					plasmoid.configuration.customColorsPastSaturdayItalic = json['pastSaturday']['italic']

					plasmoid.configuration.customColorsPastSundayEnabled = json['pastSunday']['enabled']
					plasmoid.configuration.customColorsPastSundayFg = json['pastSunday']['fg']
					plasmoid.configuration.customColorsPastSundayBg = json['pastSunday']['bg']
					plasmoid.configuration.customColorsPastSundayBold = json['pastSunday']['bold']
					plasmoid.configuration.customColorsPastSundayItalic = json['pastSunday']['italic']
	

					plasmoid.configuration.customColorsTodayFg = json['today']['fg']
					plasmoid.configuration.customColorsTodayBg = json['today']['bg']
					plasmoid.configuration.customColorsTodayBold = json['today']['bold']
					plasmoid.configuration.customColorsTodayItalic = json['today']['italic']

					plasmoid.configuration.customColorsTodaySaturdayEnabled = json['todaySaturday']['enabled']
					plasmoid.configuration.customColorsTodaySaturdayFg = json['todaySaturday']['fg']
					plasmoid.configuration.customColorsTodaySaturdayBg = json['todaySaturday']['bg']
					plasmoid.configuration.customColorsTodaySaturdayBold = json['todaySaturday']['bold']
					plasmoid.configuration.customColorsTodaySaturdayItalic = json['todaySaturday']['italic']

					plasmoid.configuration.customColorsTodaySundayEnabled = json['todaySunday']['enabled']
					plasmoid.configuration.customColorsTodaySundayFg = json['todaySunday']['fg']
					plasmoid.configuration.customColorsTodaySundayBg = json['todaySunday']['bg']
					plasmoid.configuration.customColorsTodaySundayBold = json['todaySunday']['bold']
					plasmoid.configuration.customColorsTodaySundayItalic = json['todaySunday']['italic']
	

					plasmoid.configuration.customColorsFutureFg = json['future']['fg']
					plasmoid.configuration.customColorsFutureBg = json['future']['bg']
					plasmoid.configuration.customColorsFutureBold = json['future']['bold']
					plasmoid.configuration.customColorsFutureItalic = json['future']['italic']

					plasmoid.configuration.customColorsFutureSaturdayEnabled = json['futureSaturday']['enabled']
					plasmoid.configuration.customColorsFutureSaturdayFg = json['futureSaturday']['fg']
					plasmoid.configuration.customColorsFutureSaturdayBg = json['futureSaturday']['bg']
					plasmoid.configuration.customColorsFutureSaturdayBold = json['futureSaturday']['bold']
					plasmoid.configuration.customColorsFutureSaturdayItalic = json['futureSaturday']['italic']

					plasmoid.configuration.customColorsFutureSundayEnabled = json['futureSunday']['enabled']
					plasmoid.configuration.customColorsFutureSundayFg = json['futureSunday']['fg']
					plasmoid.configuration.customColorsFutureSundayBg = json['futureSunday']['bg']
					plasmoid.configuration.customColorsFutureSundayBold = json['futureSunday']['bold']
					plasmoid.configuration.customColorsFutureSundayItalic = json['futureSunday']['italic']

					plasmod.configuration.themeName = Themes.custom
*/
				} catch (error) {

				}
			}
		}
	} // RowLayout

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

} // ColumnLayout
