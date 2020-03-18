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
        track1 = Track(id: 1, ContextOwner: teammates.teamate4, RotateInPerson: teammates.teamate5, name: "Azure")
        track2 = Track(id: 2, ContextOwner: teammates.teamate6, RotateInPerson: teammates.teamate7, name: "AWS")
        track3 = Track(id: 3, ContextOwner: teammates.teamate8, RotateInPerson: teammates.teamate3, name: "Mongo")
    }
    
    // Tracks
    func tracks() -> [Track]{
        return [track1, track2, track3]
    }
    func tracksAsync(req:Request) -> Future<[Track]>{

        let promise = req.eventLoop.newPromise([Track].self)
        let trackList = [self.track1, self.track2, self.track3]
        promise.succeed(result: trackList)

        /// Dispatch some work to happen on a background thread
//        DispatchQueue.global().async {
//
//            print("inside the dispatch queue")
//            /// When the "blocking work" has completed,
//            /// complete the promise and its associated future.
//            let trackList = [self.track1, self.track2, self.track3]
//            promise.succeed(result: trackList)
//        }

        /// Wait for the future to be completed,
        /// then transform the result to a simple String
        let result: Future<[Track]> = promise.futureResult
//        let result = promise.futureResult.transform(to: ["hello world"])
        return result
    }
}
