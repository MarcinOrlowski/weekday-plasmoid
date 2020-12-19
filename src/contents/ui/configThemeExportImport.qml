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
					'widget': {'bg': plasmoid.configuration.customColorsWidgetBg.toString()},
					'today': {
						'fg': plasmoid.configuration.customColorsTodayFg.toString(),
						'bg': plasmoid.configuration.customColorsTodayBg.toString(),
						'bold': plasmoid.configuration.customColorsTodayBold,
						'italic': plasmoid.configuration.customColorsTodayItalic
					},
					'pastDay': {
						'fg': plasmoid.configuration.customColorsPastDayFg.toString(),
						'bg': plasmoid.configuration.customColorsPastDayBg.toString(),
						'bold': plasmoid.configuration.customColorsPastDayBold,
						'italic': plasmoid.configuration.customColorsPastDayItalic
					},
					'futureDay': {
						'fg': plasmoid.configuration.customColorsFutureDayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureDayBg.toString(),
						'bold': plasmoid.configuration.customColorsFutureDayBold,
						'italic': plasmoid.configuration.customColorsFutureDayItalic
					},
					'futureSaturday': {
						'enabled': plasmoid.configuration.customColorsFutureSaturdayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSaturdayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureSaturdayBg.toString(),
						'bold': plasmoid.configuration.customColorsFutureSaturdayBold,
						'italic': plasmoid.configuration.customColorsFutureSaturdayItalic
					},
					'futureSunday': {
						'enabled': plasmoid.configuration.customColorsFutureSundayEnabled,
						'fg': plasmoid.configuration.customColorsFutureSundayFg.toString(),
						'bg': plasmoid.configuration.customColorsFutureSundayBg.toString(),
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
