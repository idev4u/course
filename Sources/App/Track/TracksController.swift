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
    
    func tracksFromDB(req:Request) -> [Track]{
//        let allTracks = Track.query(on: req.db).sort(\.id, .descending).all()
        // fixme: Db query
//        return allTracks
        return []
    }
}

