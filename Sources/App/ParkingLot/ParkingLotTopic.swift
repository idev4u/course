//
//  parkinglottopic.swift
//  App
//
//  Created by Norman Sutorius on 21.04.20.
//

import Fluent
import Vapor

final class ParkingLotTopic: Model, Content {
    static var schema:String = "ParkingLotTopic"
    
//    static let idKey: IDKey = \.id
//
//    typealias ID = Int
//
//    typealias Database = PostgreSQLDatabase
    @ID(key: .id)
    var id: Int?
    var topic: String?
    var state: Bool? = false
}
