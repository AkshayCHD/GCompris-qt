/* GCompris - Node.qml
 *
 * Copyright (C) RAJDEEP KAUR <rajdeep.kaur@kde.org> (Qt Quick port)
 *
 * Authors:
 *   Holger Kaelberer <holger.k@elberer.de>
 *   RAJDEEP KAUR <rajdeep.kaur@kde.org> (Qt Quick port)
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
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import GCompris 1.0

import "../../core"
import "family.js" as Activity

Item {
    id: node
    property int nodeWidth
    property int nodeHeight
    property string nodeImageSource
    property string borderColor
    property real borderWidth
    property string color
    property real radius

    Rectangle {
        id: content
        color: node.color
        width: 0.8 * nodeWidth
        height: 0.8 * nodeHeight
        border.color: borderColor
        border.width: borderWidth
        radius: node.radius
        Image {
            id: nodeImage
            source: nodeImageSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.6
            height: parent.height * 0.6

            SequentialAnimation {
                id: activeAnimation
                running: (currentPointer.state === "active" || currentPointer.state === "activeTo") && activity.mode == "normal"
                loops: Animation.Infinite
                alwaysRunToEnd: true
                NumberAnimation {
                    target: nodeImage
                    property: "rotation"
                    from: 0; to: 10
                    duration: 200
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: nodeImage
                    property: "rotation"
                    from: 10; to: -10
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: nodeImage
                    property: "rotation"
                    from: -10; to: 0
                    duration: 200
                    easing.type: Easing.InQuad
                }
            }
        }
    }
}
