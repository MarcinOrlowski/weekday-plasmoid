/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
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

	readonly property bool customColorsEnabled: plasmoid.configuration.themeName === Themes.custom

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

		PlasmaComponents.Button {
			text: i18n('Export')
			icon.name: 'document-export'
			onClicked: {
				var json = {
					'widget': {'bg': plasmoid.configuration.customColorsWidgetBg},
					'today': {
						'fg': plasmoid.configuration.customColorsTodayFg,
						'bg': plasmoid.configuration.customColorsTodayBg,
						'bold': plasmoid.configuration.customColorsTodayBold,
						'italic': plasmoid.configuration.customColorsTodayItalic
					},
					'todaySaturday': {
						'enabled': plasmoid.configuration.customColorsTodaySaturdayEnabled,
						'fg': plasmoid.configuration.customColorsTodaySaturdayFg,
						'bg': plasmoid.configuration.customColorsTodaySaturdayBg,
						'bold': plasmoid.configuration.customColorsTodaySaturdayBold,
						'italic': plasmoid.configuration.customColorsTodaySaturdayItalic
					},
					'todaySunday': {
						'enabled': plasmoid.configuration.customColorsTodaySundayEnabled,
						'fg': plasmoid.configuration.customColorsTodaySundayFg,
						'bg': plasmoid.configuration.customColorsTodaySundayBg,
						'bold': plasmoid.configuration.customColorsTodaySundayBold,
						'italic': plasmoid.configuration.customColorsTodaySundayItalic
					},

					'past': {
						'fg': plasmoid.configuration.customColorsPastDayFg,
						'bg': plasmoid.configuration.customColorsPastDayBg,
						'bold': plasmoid.configuration.customColorsPastDayBold,
						'italic': plasmoid.configuration.customColorsPastDayItalic
					},
					'pastSaturday': {
						'enabled': plasmoid.configuration.customColorsPastSaturdayEnabled,
						'fg': plasmoid.configuration.customColorsPastSaturdayFg,
						'bg': plasmoid.configuration.customColorsPastSaturdayBg,
						'bold': plasmoid.configuration.customColorsPastSaturdayBold,
						'italic': plasmoid.configuration.customColorsPastSaturdayItalic
					},
					'pastSunday': {
						'enabled': plasmoid.configuration.customColorsPastSundayEnabled,
						'fg': plasmoid.configuration.customColorsPastSundayFg,
						'bg': plasmoid.configuration.customColorsPastSundayBg,
						'bold': plasmoid.configuration.customColorsPastSundayBold,
						'italic': plasmoid.configuration.customColorsPastSundayItalic
					},

					'future': {
						'fg': plasmoid.configuration.customColorsFutureDayFg,
						'bg': plasmoid.configuration.customColorsFutureDayBg,
						'bold': plasmoid.configuration.customColorsFutureDayBold,
						'italic': plasmoid.configuration.customColorsFutureDayItalic
					},
					'futureSaturday': {
						'enabled': plasmoid.configuration.customColorsFutureSaturdayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSaturdayFg,
						'bg': plasmoid.configuration.customColorsFutureSaturdayBg,
						'bold': plasmoid.configuration.customColorsFutureSaturdayBold,
						'italic': plasmoid.configuration.customColorsFutureSaturdayItalic
					},
					'futureSunday': {
						'enabled': plasmoid.configuration.customColorsFutureSundayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSundayFg,
						'bg': plasmoid.configuration.customColorsFutureSundayBg,
						'bold': plasmoid.configuration.customColorsFutureSundayBold,
						'italic': plasmoid.configuration.customColorsFutureSundayItalic
					}
				}

				textInput.text = JSON.stringify(json)
			}
		}

		PlasmaComponents.Button {
			text: i18n('Import')
			icon.name: 'document-import'
			onClicked: {
			}
		}
	} // RowLayout

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

} // ColumnLayout
