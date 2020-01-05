//
//  TeamMateDbModel.swift
//  App
//
//  Created by Norman Sutorius on 02.01.20.
//

import FluentPostgreSQL
import Vapor

struct TeamMateDbModel: PostgreSQLModel, Content, Migration, Parameter {
    var id: Int?
    var name: String
    var surename: String
    var image: Data?
    var isOut: Bool?
    var assignedTrackId: Int?
}
