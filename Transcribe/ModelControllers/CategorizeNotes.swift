//
//  CategorizeNotes.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/23/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation
import SwiftUI

struct CategorizeNotes {
    
    var testCategorizedNotes: [[Note]] = [
        [
        Note(title: "First Note", bodyText: "This is my first note, this is so cool. SwiftUI is awesome!", audioFilename: "audioFile1.mp3", color: Color("cardColor3"), category: "Misc."),
        Note(title: "Note to future self in the world, you've come a long way buddy.", bodyText: "This is your future self telling you to avoid riding your bike at night, especially when it rains", audioFilename: "audioFile1.mp3", color: Color("cardColor2"), category: "Misc.")
        ],
        [
        Note(title: "Grocery List", bodyText: "Buy milk, cheese, bread, sour cream, eggs, cake mix, vegetables, fruit", audioFilename: "audioFile1.mp3", color: Color("cardColor1"), category: "Shopping List"),
        Note(title: "Birthday Presents", bodyText: "Legos\nNERF guns\nVideo Games\nChocolate Cake\nSoccer Ball\niPad\nParty Streamers", audioFilename: "audioFile1.mp3", color: Color("cardColor1"), category: "Shopping List"),
        Note(title: "Wedding Registration Ideas", bodyText: "kitchenaid mixer, cuisinart blender, leather couch, 70 inch TV, picture frames, wall art.", audioFilename: "audioFile1.mp3", color: Color("cardColor1"), category: "Shopping List"),
        Note(title: "More Wedding Registration Ideas", bodyText: "kitchenaid mixer, cuisinart blender, leather couch, 70 inch TV, picture frames, wall art.", audioFilename: "audioFile1.mp3", color: Color("cardColor1"), category: "Shopping List")
        ],
        [
        Note(title: "Rap Lyrics", bodyText: "Bust some awesome rhymes, do it everytime-z", audioFilename: "audioFile1.mp3", color: Color("cardColor2"), category: "Lyrics")]]
    
}
