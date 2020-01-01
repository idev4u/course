//
//  TracksController.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

import Foundation

class TrackController {
    
    let teammates:TeamMates;
    var track1, track2, track3 : Track;
    init() {
     teammates = TeamMates()
        track1 = Track(TrackId: 1, ContextOwner: teammates.teamate4, RotateInPerson: teammates.teamate5, TrackName: "Azure")
        track2 = Track(TrackId: 2, ContextOwner: teammates.teamate6, RotateInPerson: teammates.teamate7, TrackName: "AWS")
        track3 = Track(TrackId: 3, ContextOwner: teammates.teamate8, RotateInPerson: teammates.teamate3, TrackName: "Mongo")
        
    }
        
    // Tracks
    
    func tracks() -> [Track]{
          return [track1, track2, track3]
    }
  
}
