//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Foundation

struct Track:Encodable {
    let TrackId: Int
    var ContextOwner:TeamMate
    var RotateInPerson:TeamMate
    var TrackName: String
}
