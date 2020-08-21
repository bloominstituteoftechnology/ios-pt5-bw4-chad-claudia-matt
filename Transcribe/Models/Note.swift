//
//  Note.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation
import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var bodyText: String
    let audioFilename: String
    let color: Color
}
