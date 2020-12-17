/**
 * Weekday Widget for KDE
 *
 * @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
 * @copyright 2020 Marcin Orlowski
 * @license   http://www.opensource.org/licenses/mit-license.php MIT
 * @link      https://github.com/MarcinOrlowski/weekday-plasmoid
 */

import QtQuick 2.0
import Qt.labs.settings 1.0
import "../js/meta.js" as Meta

Item {
	// URL to metadata.desktop file of recent stable public release
    property string plasmoidUMetaDataUrl: Meta.updateCheckerUrl

	// Periodic update check interval (millis). Timer disabled if set to 0
	property var checkInterval: 0

	Timer {
		interval: checkInterval
        repeat: true
        running: checkInterval !== 0
        triggeredOnStart: checkInterval !== 0
        onTriggered: checkUpdateAvailability()
	}

	NotificationManager {
		id: updateCheckerNotificationManager
	}

    Settings {
        id: updateCheckerSettings
        category: "UpdateChecker"
        property string lastVersionCheckDate: ''
    }

    function checkUpdateAvailability(force) {
		if (force === undefined) force = false

        var d = new Date()
        var today = d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate()
        if (force || today != updateCheckerSettings.lastVersionCheckDate) {
            var xhr = new XMLHttpRequest()
            xhr.open('GET', plasmoidUMetaDataUrl)
            xhr.onreadystatechange = (function () {
                // We only care about DONE readyState.
                if (xhr.readyState !== 4) return
                if (xhr.status === 200) {
                    updateCheckerSettings.lastVersionCheckDate = today
                    var remoteVersion = xhr.responseText.match(/X\-KDE\-PluginInfo\-Version=(.*)/)[1]
                    if (remoteVersion != Meta.version) {
						updateCheckerNotificationManager.post({
							'title': Meta.title,
							'summary': i18n("New version (v%1) available!", remoteVersion),
                            'body': `You are currently using version ${Meta.version}. See project page for more information. Link in About dialog.`,
                            'expireTimeout': 0,
                        });
                    } else {
						updateCheckerNotificationManager.post({
							'title': Meta.title,
							'summary': i18n("No update available."),
                            'body': `You are using most recent version.`,
                            'expireTimeout': 1000 * 10,
                        });
					}
                }
            });
            xhr.send()
        }
    }
}

