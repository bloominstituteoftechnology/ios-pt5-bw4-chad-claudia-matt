//
//  Note.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation

struct Note: Identifiable {
    let id = UUID()
    let title: String
    let bodyText: String
    let audioFilename: String
}
