//
//  parkinglottopic.swift
//  App
//
//  Created by Norman Sutorius on 21.04.20.
//

import FluentPostgreSQL
import Vapor

struct ParkingLotTopic: Model, Content, Migration, Parameter {
    static let idKey: IDKey = \.id
    
    typealias ID = Int
    
    typealias Database = PostgreSQLDatabase
    var id: Int?
    var topic: String?
    var state: Bool? = false
}
