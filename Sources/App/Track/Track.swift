//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import FluentPostgreSQL
import Vapor



struct Track: PostgreSQLModel, Content, Migration, Parameter {
    var id: Int?
    var ContextOwner:TeamMate?
    var RotateInPerson:TeamMate?
    var name: String
}
