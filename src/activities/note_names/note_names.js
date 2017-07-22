/* GCompris - note_names.js
 *
 * Copyright (C) 2016 Johnny Jazeix <jazeix@gmail.com>
 *
 * Authors:
 *   Beth Hadley <bethmhadley@gmail.com> (GTK+ version)
 *   Johnny Jazeix <jazeix@gmail.com> (Qt Quick port)
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
.pragma library
.import QtQuick 2.0 as Quick
.import "qrc:/gcompris/src/core/core.js" as Core

var currentLevel = 0
var numberOfLevel = 20
var items
var notesToFind = []

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.score.currentSubLevel = 1
    items.bar.level = currentLevel + 1

    items.staff.eraseAllNotes()

    items.staff.noteIsColored = [1, 2, 5, 8, 11, 12, 15, 18].indexOf(items.bar.level) !== -1

    items.gridRepeater.clear();

    if(items.bar.level === 1 || items.bar.level === 11) {
        //items.staff.displayNoteLabel(true);
        for(var i = 0 ; i < 8 ; ++ i) {
            items.staff.addNote("" + (i + 1), 4, "", true);
        }
    }
    else {
        //items.staff.displayNoteLabel(false);
        if([5, 6, 7, 8, 9, 10, 15, 16, 17, 18, 19, 20].indexOf(items.bar.level) !== -1) {
            var notes = Core.shuffle(["1", "2", "3", "4", "5", "6", "7", "-1", "-2", "-3", "-4", "-5"]);
            for(var i = 0 ; i < notes.length ; ++ i) {
                items.gridRepeater.append({"note": notes[i]});
            }
            notesToFind = Core.shuffle(notes)
        }
        else {
            var notes = Core.shuffle(["1", "2", "3", "4", "5", "6", "7"]);
            for(var i = 0 ; i < notes.length ; ++ i) {
                items.gridRepeater.append({"note": notes[i]});
            }
            notesToFind = Core.shuffle(notes);
            var noteToPlay = 'qrc:/gcompris/src/activities/playpiano/resource/' + 'bass' + '_pitches/' + '1' + '/' + notesToFind[items.score.currentSubLevel - 1] + '.wav';
            items.audioEffects.play(noteToPlay);
            print(notesToFind[items.score.currentSubLevel - 1])
        }
        items.staff.addNote(notesToFind[items.score.currentSubLevel-1], 4, "", true);
    }
    items.score.numberOfSubLevels = notesToFind.length
}

function nextLevel() {
    if(numberOfLevel <= ++ currentLevel) {
        currentLevel = 0
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}

function checkAnswer(answer) {
    if(answer === notesToFind[items.score.currentSubLevel - 1]) {
        if(items.score.currentSubLevel >= notesToFind.length) {
            // Go to next level
            items.bonus.good("note");
        }
        else {
            items.score.currentSubLevel ++;
            items.staff.eraseAllNotes();
            items.staff.addNote(notesToFind[items.score.currentSubLevel-1], 4, "", true);
        }
    }
    else {
        items.bonus.bad("note");
    }
}
