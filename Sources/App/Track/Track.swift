//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import FluentPostgreSQL
import Vapor

typealias Database = PostgreSQLDatabase

struct Track: Model, Content, Migration, Parameter {
    static let idKey: IDKey = \.id
    
    typealias ID = Int
    
    typealias Database = PostgreSQLDatabase
    var id: Int?
    var ContextOwner:TeamMateDbModel?
    var RotateInPerson:TeamMateDbModel?
    var name: String
}
