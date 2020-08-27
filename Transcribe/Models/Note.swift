//
//  Note.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation
import SwiftUI

struct Note: Identifiable, Hashable, Codable {
    let id = UUID()
    var title: String
    var bodyText: String
    let audioFilename: String
    var category: String
    var recordings: [Recording] = []
}
