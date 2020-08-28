//
//  Recording.swift
//  Transcribe
//
//  Created by Chad Parker on 8/26/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation

struct Recording: Identifiable, Hashable, Codable {
    let id = UUID()
    let audioFileURL: URL
    let textTranscript: String
    let duration: Int
}
