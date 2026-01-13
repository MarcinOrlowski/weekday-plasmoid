/**
 * Weekday Grid widget for Plasma 6 / KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020-2026 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQControls
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid
import "../js/themes.js" as Themes

Kirigami.FormLayout {
	Layout.fillWidth: true

	property alias cfg_themeName: themeName.text
	property alias cfg_useUserTheme: useUserTheme.checked
	property alias cfg_useCustomFont: useCustomFont.checked
	property alias cfg_customFont: fontSelector.selectedFont

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
				if (key === Plasmoid.configuration['themeName']) currentIdx = idx
				idx++
			}
			model = tmp

			if (currentIdx !== undefined) currentIndex = currentIdx
		}
		onCurrentIndexChanged: cfg_themeName = model[currentIndex]['value']
	}

	PlasmaComponents.CheckBox {
		id: useUserTheme
		text: i18n("Use user theme")
	}

	Item {
		height: 10
	}

	PlasmaComponents.CheckBox {
		id: useCustomFont
		text: i18n("Use custom font")
	}

	RowLayout {
		enabled: cfg_useCustomFont

		ColumnLayout {
			PlasmaComponents.Label {
				text: i18n('Font: %1', cfg_customFont.family)
			}
			PlasmaComponents.Label {
				text: i18n('Size: %1', cfg_customFont.pointSize)
			}
		}

		ConfigFontSelector {
			id: fontSelector
		}
	}

}
