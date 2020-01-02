//
//  TeamMates.swift
//  App
//
//  Created by Norman Sutorius on 01.01.20.
//

import Foundation
import Vapor

struct TeamMatesDummyDS {
    let teamate1 = TeamMate(name: "Horst", surename: "Hansen", image: nil, isOut: true, assingedTrackId: nil)
    let teamate2 = TeamMate(name: "Klaus", surename: "Schmid", image: nil, isOut: false, assingedTrackId: nil)
    let teamate3 = TeamMate(name: "Gerd", surename: "Meier", image: nil, isOut: false, assingedTrackId: nil)
    let teamate4 = TeamMate(name: "Bernd", surename: "Schulze", image: nil, isOut: false , assingedTrackId: 1)
    let teamate5 = TeamMate(name: "Paul", surename: "Domer", image: nil, isOut: false, assingedTrackId: 1)
    let teamate6 = TeamMate(name: "Heinrich", surename: "Hertz", image: nil, isOut: false, assingedTrackId: 2)
    let teamate7 = TeamMate(name: "Richard", surename: "Löwe", image: nil, isOut: false, assingedTrackId: 2)
    let teamate8 = TeamMate(name: "Ludwig", surename: "Sutorius", image: nil, isOut: false, assingedTrackId: 3)

}
