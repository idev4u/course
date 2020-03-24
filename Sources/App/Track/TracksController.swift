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
    
    let teammates:TeamMatesDummyDS;
    var track1, track2, track3 : Track;
    init() {
        teammates = TeamMatesDummyDS()
        track1 = Track(id: 1, ContextOwner: teammates.teamate4, RotateInPerson: teammates.teamate5, name: "Gravity")
        track2 = Track(id: 2, ContextOwner: teammates.teamate6, RotateInPerson: teammates.teamate7, name: "Standard Blocks")
        track3 = Track(id: 3, ContextOwner: teammates.teamate8, RotateInPerson: teammates.teamate3, name: "Cloud Native")
    }
    
    // Tracks
    func tracks() -> [Track]{
        return [track1, track2, track3]
    }
    func tracksAsync(req:Request) -> Future<[Track]>{

        let promise = req.eventLoop.newPromise([Track].self)
        let trackList = [self.track1, self.track2, self.track3]
        promise.succeed(result: trackList)

        let result: Future<[Track]> = promise.futureResult

        return result
    }
    
    func tracksFromDB(req:Request) -> Future<[Track]>{
        let allTracks = Track.query(on: req).sort(\.id, .descending).all()
//        let tracksCol = allTracks.map(to: [Track].self) { someTracks in
//            for t in someTracks {
//                print(t)
//                
//            }
//            return []
//        }
  // next query each track and init with mates
        
//        let allTeamMatesIn = TeamMateDbModel.query(on: req).filter(\.isOut, .equal, false).all()
//
        return allTracks
        
    }
}
