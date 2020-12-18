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
import QtQuick.Dialogs 1.3
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.plasmoid 2.0

ColumnLayout {
	Layout.fillWidth: true
	Layout.fillHeight: true

	QtControls.TextArea {
		id: textInput
		Layout.fillWidth: true
		Layout.fillHeight: true
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

	Dialog {
		id: customColorsNotEnabledDialog
    	standardButtons: StandardButton.Ok

        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignHCenter
            textFormat: Text.RichText
            text: i18n('Custom colors must be enabled for export to work.')
        }
	} // customColorsNotEnabedDialog

	RowLayout {
		PlasmaComponents.Button {
			text: 'Update'
			icon.name: 'view-refresh-symbolic'
			onClicked: {
				if (!plasmoid.configuration.customColorsEnabled) {
					customColorsNotEnabledDialog.visible = true
					return
				}

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
			text: 'Import'
			icon.name: 'view-refresh-symbolic'
			onClicked: {
			}
		}
	} // RowLayout

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

} // ColumnLayout
