//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Foundation

struct Track:Encodable {
    let Owner:TeamMate
    let NewMate:TeamMate
    let TrackName: String
}
