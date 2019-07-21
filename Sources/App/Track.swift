//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Foundation

struct Track:Encodable {
    let TrackId: Int
    var Owner:TeamMate
    var NewMate:TeamMate
    var TrackName: String
}
