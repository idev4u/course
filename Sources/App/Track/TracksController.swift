//
//  TracksController.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

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
}
