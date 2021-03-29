//
//  Team.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Foundation
import Vapor

struct Team: Encodable {
    var team: [TeamMateDbModel]
}
