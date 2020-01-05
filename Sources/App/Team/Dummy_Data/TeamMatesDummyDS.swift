//
//  TeamMates.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

import Foundation
import Vapor

struct TeamMatesDummyDS {
    let teamate1 = TeamMateDbModel(name: "Horst", surename: "Hansen", image: nil, isOut: true, assignedTrackId: nil)
    let teamate2 = TeamMateDbModel(name: "Klaus", surename: "Schmid", image: nil, isOut: false, assignedTrackId: nil)
    let teamate3 = TeamMateDbModel(name: "Gerd", surename: "Meier", image: nil, isOut: false, assignedTrackId: nil)
    let teamate4 = TeamMateDbModel(name: "Bernd", surename: "Schulze", image: nil, isOut: false , assignedTrackId: 1)
    let teamate5 = TeamMateDbModel(name: "Paul", surename: "Domer", image: nil, isOut: false, assignedTrackId: 1)
    let teamate6 = TeamMateDbModel(name: "Heinrich", surename: "Hertz", image: nil, isOut: false, assignedTrackId: 2)
    let teamate7 = TeamMateDbModel(name: "Richard", surename: "Löwe", image: nil, isOut: false, assignedTrackId: 2)
    let teamate8 = TeamMateDbModel(name: "Ludwig", surename: "Sutorius", image: nil, isOut: false, assignedTrackId: 3)

}
