/**
 * Weekday Grid widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2021 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQControls
import org.kde.plasma.components 3.0 as PlasmaComponents
import "../js/themes.js" as Themes

Kirigami.FormLayout {
	Layout.fillWidth: true

	property alias cfg_themeName: themeName.text
	property alias cfg_useUserTheme: useUserTheme.checked

	// key of theme
	Text {
		visible: false
		id: themeName
	}

	FakeCalendarModeWarning {}

	PlasmaComponents.ComboBox {
		Kirigami.FormData.label: i18n('Theme')

		textRole: "text"
		model: []
		enabled: !cfg_useUserTheme
		Component.onCompleted: {
			// populate model from Theme object
			var tmp = []
			var idx = 0
			var currentIdx = undefined
			for(const key in Themes.themes) {
				var name = Themes.themes[key]['theme']['name']
				tmp.push({'value':key, 'text': name})
				if (key === plasmoid.configuration['themeName']) currentIdx = idx
				idx++
			}
			model = tmp

			currentIndex = currentIdx
		}
		onCurrentIndexChanged: cfg_themeName = model[currentIndex]['value']
	}

	PlasmaComponents.CheckBox {
		id: useUserTheme
		text: i18n("Use user theme")
	}
}

