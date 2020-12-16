/**
 * Weekday Widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

ColumnLayout {
    width: childrenRect.width

    readonly property int indent: 24

    property alias cfg_useSpecificLocaleEnabled: useSpecificLocaleEnabled.checked
	property alias cfg_useSpecificLocaleLocaleName: useSpecificLocaleLocaleName.text

    GroupBox {
        title: i18n("Localization")
        Layout.fillWidth: true

        Kirigami.FormLayout {
            anchors.left: parent.left
            anchors.right: parent.right

        	RowLayout {
                Layout.fillWidth: true
        	    Kirigami.FormData.label: i18n("Use specific locale")

                CheckBox {
                    id: useSpecificLocaleEnabled
                }

                TextField {
					id: useSpecificLocaleLocaleName
                    Layout.fillWidth: true
                    enabled: cfg_useSpecificLocaleEnabled
                }
        	}
        } // FormLayout
    } // GroupBox

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

}
