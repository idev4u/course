//
//  TeamMate.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Foundation
import Vapor

struct TeamMate: Encodable, Content {
    let name: String
    let surename: String
    let image: File?
    var isOut: Bool?
    var assingedTrackId: Int?
}
