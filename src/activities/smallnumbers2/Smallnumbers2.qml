/* GCompris - smallnumbers2.qml
 *
 * Copyright (C) 2014 Bruno Coudoin <bruno.coudoin@gcompris.net>
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.6
import GCompris 1.0

import "../../core"
import "../gletters"
import "../gletters/gletters.js" as Activity

Gletters {
    id: activity
    dataSetUrl: "qrc:/gcompris/src/activities/smallnumbers2/resource/"
    configurationButtonVisible: true
    property string activityName: "smallnumbers2"

    QtObject {
            id: items
            property string mode: "dot"
    }

    DialogActivityConfig {
        id: smallDialogActivityConfig
        currentActivity: activity
        content: Component {
            Item {
                property alias modeBox: modeBox
                property var availableModes: [
                    { "text": qsTr("Dots"), "value": "dot" },
                    { "text": qsTr("Numbers"), "value": "number" },
                    { "text": qsTr("Romans"), "value": "roman" },
                    { "text": qsTr("Images"), "value": "image" }
                ]
                Flow {
                    id: flow
                    spacing: 5
                    width: smallDialogActivityConfig.width
                    GCComboBox {
                        id: modeBox
                        model: availableModes
                        background: smallDialogActivityConfig
                        label: qsTr("Select Domino mode")
                    }
                }
            }
        }
        onClose: home()
        onLoadData: {
            if(dataToSave && dataToSave["mode"]) {
                items.mode = dataToSave["mode"];
            }
        }
        onSaveData: {
            var newMode = smallDialogActivityConfig.configItem.availableModes[smallDialogActivityConfig.configItem.modeBox.currentIndex].value;
            if (newMode !== items.mode) {
                items.mode = newMode;
                dataToSave = {"mode": items.mode};
            }
            Activity.initLevel();
        }
        function setDefaultValues() {
            for(var i = 0 ; i < smallDialogActivityConfig.configItem.availableModes.length ; i++) {
                if(smallDialogActivityConfig.configItem.availableModes[i].value === items.mode) {
                    smallDialogActivityConfig.configItem.modeBox.currentIndex = i;
                    break;
                }
            }
        }
    }

    function getMode() {
        return items.mode;
    }

    function getDominoValues(key) {
        var val1 = Math.floor(Math.random() * key)
        return [val1, key - val1]
    }
}
