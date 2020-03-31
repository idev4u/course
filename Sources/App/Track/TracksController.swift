//
//  TracksController.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

//import Foundation
import Vapor
import Foundation

class TrackController {
    
    func tracksFromDB(req:Request) -> Future<[Track]>{
        let allTracks = Track.query(on: req).sort(\.id, .descending).all()
        return allTracks
    }
}
