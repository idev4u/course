//
//  TeamMateDbModel.swift
//  App
//
//  Created by Norman Sutorius on 02.01.20.
//

import FluentPostgreSQL
import Vapor
import PostgreSQL



struct TeamMateDbModel: Model, Content, Migration, Parameter {
    static let idKey: IDKey = \.id
    
    typealias ID = Int
    
    typealias Database = PostgreSQLDatabase
    
    var id: Int?
    var name: String
    var surename: String
    var image: Data?
    var isOut: Bool?
    var assignedTrackId: Int?
}
