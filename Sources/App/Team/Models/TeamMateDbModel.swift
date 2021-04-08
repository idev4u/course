//
//  TeamMateDbModel.swift
//  App
//
//  Created by Norman Sutorius on 02.01.20.
//

import Fluent
import Vapor

final class TeamMateDbModel: Model, Content {
    init() { }
    
    static var schema: String = "TeamMateDbModel"
        
    @ID(custom: .id)
    var id: Int?
    @Field(key: "name")
    var name: String
    @Field(key: "surename")
    var surename: String
    @Field(key: "image")
    var image: Data?
    @Field(key: "isOut")
    var isOut: Bool?
    @Field(key: "assignedTrackId")
    var assignedTrackId: Int?
}
