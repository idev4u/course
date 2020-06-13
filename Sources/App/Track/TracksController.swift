//
//  TracksController.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

//import Foundation
import Vapor

class TrackController {
    
    func listAllTracks(req: Request) throws -> Future<View> {
        let allTracks = Track.query(on: req).all()
        return allTracks.flatMap { track in
            let tracks = ["tracklist": track]
            return try req.view().render("pages/manage/tracks/tracks.leaf", tracks)
        }
    }
    
    func tracksFromDB(req:Request) -> Future<[Track]>{
        let allTracks = Track.query(on: req).sort(\.id, .descending).all()
        return allTracks
    }
}
