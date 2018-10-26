/* GCompris - constellations.qml
 *
 * Copyright (C) 2018 YOUR NAME <xx@yy.org>
 *
 * Authors:
 *   <THE GTK VERSION AUTHOR> (GTK+ version)
 *   YOUR NAME <YOUR EMAIL> (Qt Quick port)
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

import "../../core"
import "constellations.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    Keys.onPressed: Activity.checkStars(event)
    property bool running: false
    
    pageComponent: Image {
        id: background
        anchors.fill: parent
        signal start
        signal stop
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/gcompris/src/activities/constellations/resource/bg.jpg"
        sourceSize.width: Math.max(parent.width, parent.height)

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        IntroMessage {
            id: message
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 5
                left: parent.left
                leftMargin: 5
            }
            z: 100
            intro: [      
                qsTr("a group of stars forming a recognizable pattern "
                     +"that is traditionally named after its apparent form or identified with a mythological figure "
                     +"is known as a constellation. "),
                qsTr("Your task in to help tux count the number of stars in the rotating "
                     +"constellation shown on the screen.") ,
                qsTr("As the levels increase the contellations would become more complex "
                     +"and would start rotating faster and faster.")
            ]
        }


        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property alias mainRec: mainRec
            //property alias rot: rot
            property bool running: running
        }
        

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }
        GCText {
            id: constellationName
            fontSize: smallSize
            color: "#FFFFFF"
            text: qsTr("Cancer")
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            z: 12
        }


        Rectangle {
            width: constellationName.width * 2
            height: constellationName.height
            radius: 10
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000" }
                GradientStop { position: 0.9; color: "#666" }
                GradientStop { position: 1.0; color: "#AAA" }
            }
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            z: 11
        }

        Rectangle {
            id: mainRec
            height: parent.height * 0.6
            width: parent.width * 0.4
            z: 1
            color: "transparent"
	        anchors.centerIn: parent
           
            Image {
                id: one
                width: 60
                height: 60
                x: 0.5*mainRec.width - this.width/2
                y: -this.height/2
                z: 3
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/gcompris/src/activities/constellations/resource/star.svg"
            }

            Image {
                id: two
                width: 60
                height: 60
                x: 0.55*mainRec.width- this.width/2
                y: 0.3*mainRec.height- this.height/2
                z: 3
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/gcompris/src/activities/constellations/resource/star.svg"
                
            }

            Image {
                id: three
                width: 60
                height: 60
                x: 0.5*mainRec.width - this.width/2
                y: 0.6*mainRec.height- this.height/2
                z: 3
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/gcompris/src/activities/constellations/resource/star.svg"

            }

            Image {
                id: four
                width: 60
                height: 60
                x: mainRec.width - this.width/2
                y: mainRec.height - this.height/2
                z: 3
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/gcompris/src/activities/constellations/resource/star.svg"
            }

            Image {
                id: five
                width: 60
                height: 60
                x: -this.width/2
                y: 0.9*mainRec.height - this.height/2
                z: 3
                fillMode: Image.PreserveAspectCrop
                source: "qrc:/gcompris/src/activities/constellations/resource/star.svg"

            }

            Rectangle {
                id: rec1
                x: one.x + one.width/2
                y: one.y + one.height/2
                property double x2: two.x + two.width/2
                property double y2: two.y + two.height/2
                width: 5
                color:"white"
                height: Math.sqrt(Math.pow((one.x - two.x),2) + Math.pow((one.y - two.y),2))
                transform: Rotation { angle: -(Math.atan((rec1.x2 - rec1.x)/(rec1.y2-rec1.y)) * 180 / Math.PI) }
            }
        
            Rectangle {
                id: rec2
                x: two.x + two.width/2
                y: two.y + two.height/2
                property double x2: three.x + three.width/2
                property double y2: three.y + three.height/2
                width: 5
                color:"white"
                height: Math.sqrt(Math.pow((two.x - three.x),2) + Math.pow((two.y - three.y),2))
                transform: Rotation { angle: -(Math.atan((rec2.x2 - rec2.x)/(rec2.y2-rec2.y)) * 180 / Math.PI) }
            }
            
            Rectangle {
                id: rec3
                x: three.x + three.width/2
                y: three.y + three.height/2
                property double x2: four.x + four.width/2
                property double y2: four.y + four.height/2
                width: 5
                color:"white"
                height: Math.sqrt(Math.pow((three.x - four.x),2) + Math.pow((three.y - four.y),2))
                transform: Rotation { angle: -(Math.atan((rec3.x2 - rec3.x)/(rec3.y2-rec3.y)) * 180 / Math.PI) }
            }
            
            Rectangle {
                id: rec4
                x: three.x + three.width/2
                y: three.y + three.height/2
                property double x2: five.x + five.width/2
                property double y2: five.y + five.height/2
                width: 5
                color:"white"
                height: Math.sqrt(Math.pow((three.x - five.x),2) + Math.pow((three.y - five.y),2))
                transform: Rotation { angle: -(Math.atan((rec4.x2 - rec4.x)/(rec4.y2-rec4.y)) * 180 / Math.PI) }
            }
        
          
            states: [
                State {
                    name: "rotated"
                    PropertyChanges { target: mainRec; rotation: 180 }
                },
                State {
                    name: "still"
                    PropertyChanges { target: mainRec; rotation: 0 }
                }
            ]

            
            transitions: Transition {
                  RotationAnimation {
                    id: rot
                    loops: Animation.Infinite
                    duration: 5000
                    from: 0
                    to: 360
                }
            }
            
        }
        
        DialogHelp {
            id: dialogHelp
            onClose: home()
        }
        
        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
